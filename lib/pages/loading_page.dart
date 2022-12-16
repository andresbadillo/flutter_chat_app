import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:chat_real_time_app/services/auth_service.dart';
import 'package:chat_real_time_app/pages/pages.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff7fff7),
      body: FutureBuilder(
        future: checkLoginState(context),
        builder: (context, snapshot) {
          return Center(
            child: Container(
              child: const SizedBox(
                height: 180,
                child: Image(image: AssetImage('assets/logo.png')),
              ),
            ),
          );
        },
      ),
    );
  }

  Future checkLoginState(BuildContext context) async {
    final authService = Provider.of<AuthService>(context, listen: false);
    final autenticado = await authService.isLoggedIn();

    if (autenticado) {
      // Todo: Conectar al socket server
      // Navigator.pushReplacementNamed(context, 'usuarios');

      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => const UsuariosPage(),
        ),
      );
    } else {
      // Navigator.pushReplacementNamed(context, 'login');

      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => const LoginPage(),
        ),
      );
    }
  }
}
