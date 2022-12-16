import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:chat_real_time_app/models/usuario.dart';
import 'package:chat_real_time_app/services/auth_service.dart';

class UsuariosPage extends StatefulWidget {
  const UsuariosPage({Key? key}) : super(key: key);

  @override
  State<UsuariosPage> createState() => _UsuariosPageState();
}

class _UsuariosPageState extends State<UsuariosPage> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  final usuarios = [
    Usuario(
      online: true,
      email: 'andres@gmail.com',
      nombre: 'Andres',
      uid: '1',
    ),
    Usuario(
      online: true,
      email: 'sarah@gmail.com',
      nombre: 'Sarah',
      uid: '2',
    ),
    Usuario(
      online: false,
      email: 'cristian@gmail.com',
      nombre: 'Cristian',
      uid: '3',
    )
  ];

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final usuario = authService.usuario;

    return Scaffold(
        backgroundColor: const Color(0xffF7FFF7),
        appBar: AppBar(
          title: Text(
            usuario?.nombre ?? 'Sin nombre',
            style: TextStyle(
              color: Color(0xffF7FFF7),
            ),
          ),
          elevation: 1,
          centerTitle: true,
          backgroundColor: const Color(0xff1A535C),
          leading: IconButton(
            icon: const Icon(
              Icons.logout_outlined,
              color: Color(0xffF7FFF7),
            ),
            onPressed: () {
              //Todo: Desconectar el socket service
              Navigator.pushReplacementNamed(context, 'login');
              AuthService.deleteToken();
            },
          ),
          actions: [
            Container(
              margin: const EdgeInsets.only(right: 10),
              child: const Icon(Icons.check_circle, color: Color(0xffF7FFF7)),
              // child: Icon(Icons.offline_bolt, color: Color(0xffFF6B6B)),
            ),
          ],
        ),
        body: SmartRefresher(
          controller: _refreshController,
          enablePullDown: true,
          header: WaterDropHeader(
            complete: Icon(
              Icons.check,
              color: Color(0xff1A535C).withOpacity(0.8),
            ),
            waterDropColor: Color(0xff1A535C),
          ),
          physics: const BouncingScrollPhysics(),
          onRefresh: _cargarUsuarios,
          child: _listViewUsuarios(),
        ));
  }

  ListView _listViewUsuarios() {
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) => _usuarioListTile(usuarios[index]),
      separatorBuilder: (context, index) => const Divider(),
      itemCount: usuarios.length,
    );
  }

  ListTile _usuarioListTile(Usuario usuario) {
    return ListTile(
      title: Text(usuario.nombre),
      subtitle: Text(usuario.email),
      leading: CircleAvatar(
        backgroundColor: const Color(0xff1A535C),
        child: Text(
          usuario.nombre.substring(0, 2),
          style: const TextStyle(color: Color(0xffF7FFF7)),
        ),
      ),
      trailing: Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(
          color: usuario.online ? Colors.green : Colors.red,
          borderRadius: BorderRadius.circular(100),
        ),
      ),
    );
  }

  _cargarUsuarios() async {
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }
}
