import 'package:flutter/material.dart';
import 'package:gelengelsintt/core/storage.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  checkLogin() async {
    Storage storage = Storage();

    final user = await storage.loadUser();
    Navigator.pushReplacementNamed(context, '/home');
    if (user != null) {
    } else {
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
