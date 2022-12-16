import 'package:chat_real_time_app/global/environment.dart';
import 'package:flutter/material.dart';

import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socket_io_client/socket_io_client.dart';

enum ServerStatus {
  OnLine,
  OffLine,
  Connecting,
}

class SocketService with ChangeNotifier {
  ServerStatus _serverStatus = ServerStatus.Connecting;
  late IO.Socket _socket;

  ServerStatus get serverStatus => _serverStatus;

  Socket get socket => _socket;
  Function get emit => _socket.emit;

  void connect() {
    // Dart Client from: https://pub.dev/packages/socket_io_client
    _socket = IO.io(
      Environment.socketUrl,
      OptionBuilder()
          .setTransports(['websocket']) // for Flutter or Dart VM
          .enableAutoConnect() // disable auto-connection
          .enableForceNew()
          .build(),
    );
    _socket.connect();
    _socket.onConnect((_) {
      // print('connect');
      _socket.emit('mensaje', 'Conectado desde flutter');
      _serverStatus = ServerStatus.OnLine;
      notifyListeners();
    });
    _socket.onDisconnect((_) {
      _serverStatus = ServerStatus.OffLine;
      notifyListeners();
    });
    // _socket.on('nuevo-mensaje', (payload) {
    //   print('nuevo-mensaje:');
    //   print('nombre: ' + payload['nombre']);
    //   print('mensaje: ' + payload['mensaje']);
    //   print(payload.containsKey('mensaje2') ? payload['mensaje2'] : 'No hay');
    //   notifyListeners();
    // });

    // _socket.off('nuevo-mensaje');
  }

  void disconnect() {
    _socket.disconnect();
  }
}
