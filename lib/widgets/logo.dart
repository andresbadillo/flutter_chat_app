import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  const Logo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.only(top: 40),
        width: 250,
        child: Column(
          children: const [
            Image(image: AssetImage('assets/logo.png')),
            SizedBox(height: 10),
            Text(
              'Messenger',
              style: TextStyle(
                color: Color(0xff1a535c),
                fontSize: 35,
                fontWeight: FontWeight.bold,
                fontFamily: "Pacifico",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
