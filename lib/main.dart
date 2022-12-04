import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:chat_real_time_app/routes/routes.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'S&A Private Chat',
      initialRoute: 'chat',
      routes: appRoutes,
    );
  }
}
