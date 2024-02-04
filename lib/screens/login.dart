import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gelengelsintt/core/storage.dart';
import 'package:gelengelsintt/services/api.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool loading = false;
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  bool showPassword = false;
  bool showError = false;
  int countdownSeconds = 3;

  login() async {
    setState(() {
      loading = true;
      showError = false; // Reset error state when trying to login again
    });

    API api = API();

    try {
      final response = await api.login(
        username: emailController.text,
        password: passwordController.text,
      );

      Storage storage = Storage();

      await storage.saveUser(
        id: response["data"]["user"]["id"],
        name: response["data"]["user"]["name"],
        email: response["data"]["user"]["email"],
        phone: response["data"]["user"]["phone_number"],
      );

      await storage.saveToken(response["data"]["token"]);

      Navigator.of(context).pushReplacementNamed("/home");
    } catch (e) {
      setState(() {
        showError = true;
      });

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Girdiğiniz bilgiler yanlış"),
        backgroundColor: Colors.red,
      ));

      // Start the countdown
      startCountdown();
    } finally {
      setState(() {
        loading = false;
      });
    }
  }

  void startCountdown() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        countdownSeconds--;

        if (countdownSeconds == 0) {
          // Reset error and countdown
          showError = false;
          countdownSeconds = 3;
          timer.cancel();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isLargeScreen = MediaQuery.of(context).size.width > 1200;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              "assets/icons/twitter-color-icon.svg",
              height: 30,
              color: Colors.deepOrange,
            ),
            SizedBox(width: 8),
            Text(
              "Giriş Yapınız",
              style: TextStyle(
                color: Colors.deepOrange,
                fontWeight: FontWeight.bold,
                fontSize: isLargeScreen ? 24 : 18,
              ),
            ),
          ],
        ),
      ),
      body: Container(
        color: showError ? Colors.red : Colors.white,
        child: SafeArea(
          child: loading
              ? Center(child: CircularProgressIndicator())
              : Padding(
                  padding: EdgeInsets.all(
                    isLargeScreen ? 128.0 : 16.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextField(
                        controller: emailController,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          hintText: 'example@example.com',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 16),
                      TextField(
                        controller: passwordController,
                        obscureText: !showPassword,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          hintText: '********',
                          suffixIcon: IconButton(
                            icon: Icon(
                              showPassword
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              setState(() {
                                showPassword = !showPassword;
                              });
                            },
                          ),
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: login,
                        style: ElevatedButton.styleFrom(
                          primary: Colors.deepOrange,
                          onPrimary: Colors.white,
                        ),
                        child: Text(
                          "Giriş Yap",
                          style: TextStyle(
                            fontSize: isLargeScreen ? 20 : 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                      TextButton(
                        onPressed: () =>
                            Navigator.of(context).pushNamed("/register"),
                        style: TextButton.styleFrom(
                          primary: Colors.deepOrange,
                        ),
                        child: Text(
                          "Hesap Oluşturunuz",
                          style: TextStyle(
                            fontSize: isLargeScreen ? 18 : 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                      if (showError)
                        Text(
                          "Tekrar deneyin, hata: $countdownSeconds saniye içinde tekrar deneyiniz.",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
