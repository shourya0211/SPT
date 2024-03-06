import 'package:flutter/material.dart';
import 'dart:ui' show lerpDouble;

class OTPVerificationScreen extends StatefulWidget {
  @override
  _OTPVerificationScreenState createState() => _OTPVerificationScreenState();
}

class _OTPVerificationScreenState extends State<OTPVerificationScreen> {
  final TextEditingController otpController = TextEditingController();


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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 66),
              child: Text(
                'OTP Verification',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              'Please enter the OTP sent to your Email',
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 20.0),
            Container(
              height: 70, // Specify the desired height
              child: TextFormField(
                controller: otpController,
                keyboardType: TextInputType.number,
                maxLength: 6,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(

                  hintText: 'Enter OTP',
                  hintStyle: TextStyle(color: Colors.grey),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),

            SizedBox(height: 20.0),
            SizedBox(
              width: double.infinity,
              height: 45,
              child: ElevatedButton(
                onPressed: () {
                  // Perform OTP verification here
                },
                child: Text(
                  'Verify OTP',
                  style: TextStyle(color: Colors.black),
                ),
                style: ElevatedButton.styleFrom(

                  backgroundColor: Colors.green,
                  padding: EdgeInsets.symmetric(vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
              ),
            ),


          ],
        ),
      ),
    );
  }
}


