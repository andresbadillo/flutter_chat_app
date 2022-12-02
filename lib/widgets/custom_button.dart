import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Function() onPressed;

  const CustomButton({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        primary: const Color(0xff1a535c),
        maximumSize: const Size(double.infinity, 55),
        minimumSize: const Size(double.infinity, 55),
        shape: const StadiumBorder(),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Color(0xfff7fff7),
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
    );
  }
}
