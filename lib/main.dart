import 'package:flutter/material.dart';
import 'package:gelengelsintt/screens/home.dart';
import 'package:gelengelsintt/screens/loading.dart';
import 'package:gelengelsintt/screens/login.dart';
import 'package:gelengelsintt/screens/register.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Debug Banner',
      debugShowCheckedModeBanner: false,
      routes: {
        '/login': (context) => LoginScreen(),
        '/register': (context) => RegisterScreen(),
        '/home': (context) => HomeScreen(),
        '/loading': (context) => LoadingScreen(),
      },
      initialRoute: '/loading',
    );
  }
}
