import 'package:flutter/material.dart';
import 'package:scholar_personal_tutor/HomePage.dart';
import 'package:scholar_personal_tutor/LoginScreen.dart';
import 'package:scholar_personal_tutor/OTPVerificationScreen.dart';
import 'package:scholar_personal_tutor/PaymentPage.dart';
import 'package:scholar_personal_tutor/SignUp.dart';
import 'package:scholar_personal_tutor/VideoPlayerScreen.dart';
import 'ForgetPaswordScreen.dart';
import 'dart:ui' show lerpDouble;
// Replace 'main_screen.dart' with the name of your main screen file

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowMaterialGrid: false,
      title: 'My App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
      // initialRoute: '/', // Set initial route to the login screen
      // routes: {
      //   '/': (context) => SplashScreen(), // Splash screen route
      //   '/login': (context) => LoginScreen(), // Login screen route
      //   '/main': (context) => MainScreen(), // Main screen route
      // },
    );
  }
}


class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Main Screen'),
      ),
      body: Center(
        child: Text(
          'Welcome to the Main Screen!',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
