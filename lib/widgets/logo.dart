import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  const Logo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.only(top: 50),
        width: 250,
        child: Column(
          children: const [
            SizedBox(
              height: 180,
              child: Image(image: AssetImage('assets/logo.png')),
            ),
            SizedBox(height: 0),
            Text(
              'Messenger',
              style: TextStyle(
                color: Color(0xff1a535c),
                fontSize: 32,
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
