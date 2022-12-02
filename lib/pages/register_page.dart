import 'package:flutter/material.dart';

import '../widgets/widgets.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

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
                route: 'login',
                subTitle: '¿Ya tienes cuenta?',
                title: 'Ingresa ahora!',
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
  final userCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 35),
      child: Column(
        children: [
          CustomInput(
            icon: Icons.person_outline,
            placeholder: 'Nombre de usuario',
            textController: userCtrl,
            keyboardType: TextInputType.text,
          ),
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
            text: 'Registrarse',
            onPressed: () {
              print('Hola');
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
