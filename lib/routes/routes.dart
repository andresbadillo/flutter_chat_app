import 'package:chat_real_time_app/pages/chat_page.dart';
import 'package:chat_real_time_app/pages/loading_page.dart';
import 'package:chat_real_time_app/pages/login_page.dart';
import 'package:chat_real_time_app/pages/register_page.dart';
import 'package:chat_real_time_app/pages/usuarios_page.dart';
import 'package:flutter/material.dart';

final Map<String, WidgetBuilder> appRoutes = {
  'usuarios': (_) => UsuariosPage(),
  'chat': (_) => ChatPage(),
  'login': (_) => LoginPage(),
  'register': (_) => RegisterPage(),
  'loading': (_) => LoadingPage(),
};
