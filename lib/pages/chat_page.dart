import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:provider/provider.dart';

import 'package:chat_real_time_app/models/mensajes_response.dart';
import 'package:chat_real_time_app/services/services.dart';
import 'package:chat_real_time_app/widgets/widgets.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {
  final _textController = TextEditingController();
  final _focusNode = FocusNode();

  ChatService? chatService;
  SocketService? socketService;
  AuthService? authService;

  List<ChatMessage> _messages = [];

  bool _isWriting = false;

  @override
  void initState() {
    super.initState();
    chatService = Provider.of<ChatService>(context, listen: false);
    socketService = Provider.of<SocketService>(context, listen: false);
    authService = Provider.of<AuthService>(context, listen: false);

    socketService?.socket.on('mensaje-personal', _escucharMensaje);

    _cargarHistorial(chatService!.usuarioPara!.uid);
  }

  void _cargarHistorial(String usuarioID) async {
    List<Mensaje> chat = await chatService!.getChat(usuarioID);

    final history = chat.map((m) => ChatMessage(
          text: m.mensaje,
          uid: m.de,
          animationController: AnimationController(
            vsync: this,
            duration: const Duration(milliseconds: 0),
          )..forward(),
        ));

    setState(() {
      _messages.insertAll(0, history);
    });
  }

  void _escucharMensaje(dynamic payload) {
    ChatMessage message = ChatMessage(
      text: payload['mensaje:'],
      uid: payload['de:'],
      animationController: AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 300),
      ),
    );

    setState(() {
      _messages.insert(0, message);
    });

    message.animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    final usuarioPara = chatService!.usuarioPara;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: const Color(0xfff7fff7),
              child: Text(
                usuarioPara!.nombre.substring(0, 2),
                style: const TextStyle(fontSize: 12, color: Color(0xff1a535c)),
              ),
            ),
            const SizedBox(width: 10),
            Text(
              usuarioPara.nombre,
              style: const TextStyle(
                color: Color(0xfff7fff7),
                fontSize: 12,
              ),
            ),
          ],
        ),
        backgroundColor: const Color(0xff1a535c),
        elevation: 1,
      ),
      body: Container(
        color: const Color(0xfff7fff7),
        child: Column(
          children: [
            Flexible(
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: _messages.length,
                itemBuilder: (context, index) => _messages[index],
                reverse: true,
              ),
            ),
            const Divider(height: 1),
            Container(
              height: 50,
              margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(100),
              ),
              child: _inputChat(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _inputChat() {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          children: [
            Flexible(
              child: TextField(
                controller: _textController,
                onSubmitted: _handleSubmit,
                onChanged: (String texto) {
                  setState(() {
                    if (texto.trim().isNotEmpty) {
                      _isWriting = true;
                    } else {
                      _isWriting = false;
                    }
                  });
                },
                decoration: const InputDecoration.collapsed(
                  hintText: 'Enviar mensaje',
                ),
                focusNode: _focusNode,
              ),
            ),
            // Boton de enviar
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              child: Platform.isIOS
                  ? CupertinoButton(
                      disabledColor: Colors.grey,
                      onPressed: _isWriting
                          ? () => _handleSubmit(_textController.text.trim())
                          : null,
                      child: const Text(
                        'Enviar',
                        style: TextStyle(color: Color(0xff1a535c)),
                      ),
                    )
                  : Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      child: IconTheme(
                        data: const IconThemeData(
                          color: Color(0xff1a535c),
                        ),
                        child: IconButton(
                          highlightColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          icon: const Icon(Icons.send),
                          onPressed: _isWriting
                              ? () => _handleSubmit(_textController.text.trim())
                              : null,
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  _handleSubmit(String texto) {
    if (texto.isEmpty) return;

    _textController.clear();
    _focusNode.requestFocus();

    final newMessage = ChatMessage(
      text: texto,
      uid: authService!.usuario!.uid,
      animationController: AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 300),
      ),
    );

    _messages.insert(0, newMessage);
    newMessage.animationController.forward();

    setState(() {
      _isWriting = false;
    });

    socketService!.emit('mensaje-personal', {
      'de': authService!.usuario!.uid,
      'para': chatService!.usuarioPara!.uid,
      'mensaje': texto,
    });
  }

  @override
  void dispose() {
    for (ChatMessage message in _messages) {
      message.animationController.dispose();
    }

    socketService?.socket.off('mensaje-personal');
    super.dispose();
  }
}
