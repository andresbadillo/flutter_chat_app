import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:chat_real_time_app/helpers/mostrar_alerta.dart';
import 'package:chat_real_time_app/services/auth_service.dart';
import '../widgets/widgets.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff7fff7),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Logo(),
              _Form(),
              Labels(
                route: 'register',
                subTitle: '¿No tienes una cuenta?',
                title: 'Crea una ahora!',
              ),
              _Bottom(),
            ],
          ),
        ),
      ),
    );
  }
}

class _Form extends StatefulWidget {
  const _Form({Key? key}) : super(key: key);

  @override
  State<_Form> createState() => __FormState();
}

class __FormState extends State<_Form> {
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 35),
      child: Column(
        children: [
          CustomInput(
            icon: Icons.mail_outline,
            placeholder: 'Correo electrónico',
            textController: emailCtrl,
            keyboardType: TextInputType.emailAddress,
          ),
          CustomInput(
            icon: Icons.lock_outline,
            placeholder: 'Contraseña',
            textController: passCtrl,
            keyboardType: TextInputType.text,
            isPassword: true,
          ),
          CustomButton(
            text: 'Ingresar',
            onPressed: authService.autenticando
                ? null
                : () async {
                    FocusScope.of(context).unfocus();
                    final loginOk = await authService.login(
                      emailCtrl.text.trim(),
                      passCtrl.text.trim(),
                    );
                    if (loginOk) {
                      // Todo: Conectar a nuestro socket server
                      Navigator.pushReplacementNamed(context, 'usuarios');
                    } else {
                      mostrarAlerta(
                        context,
                        'Login incorrecto',
                        'Revisa tus credenciales de acceso',
                      );
                    }
                  },
          ),
        ],
      ),
    );
  }
}

class _Bottom extends StatelessWidget {
  const _Bottom({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Text(
          'Terminos y condiciones de uso',
          style: TextStyle(fontWeight: FontWeight.w300),
        ),
        SizedBox(height: 20)
      ],
    );
  }
}
