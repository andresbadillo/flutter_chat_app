import 'package:flutter/material.dart';

class Labels extends StatelessWidget {
  const Labels({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: const [
          Text(
            '¿No tienes cuenta?',
            style: TextStyle(
              color: Colors.black54,
              fontSize: 15,
              fontWeight: FontWeight.w300,
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Crea una ahora!',
            style: TextStyle(
              color: Color(0xff1a535c),
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
