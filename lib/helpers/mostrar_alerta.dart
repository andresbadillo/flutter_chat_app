import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

mostrarAlerta(BuildContext context, String titulo, String subtitulo) {
  if (Platform.isAndroid) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(titulo),
        content: Text(subtitulo),
        actions: [
          MaterialButton(
            elevation: 5,
            color: const Color(0xff1a535c),
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Ok',
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
    );
  }

  showCupertinoDialog(
    context: context,
    builder: (context) => CupertinoAlertDialog(
      title: Text(titulo),
      content: Text(subtitulo),
      actions: [
        CupertinoDialogAction(
          isDefaultAction: true,
          child: const Text(
            'Ok',
            style: TextStyle(color: Color(0xff1a535c)),
          ),
          onPressed: () => Navigator.pop(context),
        )
      ],
    ),
  );
}