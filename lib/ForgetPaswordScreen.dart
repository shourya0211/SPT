import 'package:flutter/material.dart';
import 'dart:ui' show lerpDouble;

class ForgotPasswordScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        color: Colors.black,
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 150),
            Text(
              "Forgot Your Password?",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 30),


            Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
                  hintText: "Email",
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                ),
                keyboardType: TextInputType.emailAddress,
              ),
            ),
            SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              height: 45,
              child: ElevatedButton(
                onPressed: () {
                  // Placeholder for sending verification email
                  // UI-only implementation
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Verification email sent to ${emailController.text}"),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                ),
                child: Text("Submit",style: TextStyle(color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,),),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
