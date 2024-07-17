import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:ui' show lerpDouble;
import 'package:pinput/pinput.dart';
import 'package:scholar_personal_tutor/HomePage.dart';
import 'package:scholar_personal_tutor/OtherUserDataForPhoneAuth.dart';

class OTPVerificationScreen extends StatefulWidget {
  String verificationId;
  String phoneNumber;
  OTPVerificationScreen(this.verificationId,this.phoneNumber);
  @override
  _OTPVerificationScreenState createState() =>
      _OTPVerificationScreenState(verificationId,phoneNumber);
}

class _OTPVerificationScreenState extends State<OTPVerificationScreen> {
  String phoneNumber;
  String verificationId;
  _OTPVerificationScreenState(this.verificationId,this.phoneNumber);
  final TextEditingController otpController = TextEditingController();
  Future<void> optVerification(OTP) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: OTP);
      UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection('users') // Replace 'your_collection' with your collection name
          .doc("+91$phoneNumber") // Specify the document ID
          .get();
      if(!documentSnapshot.exists){
        Navigator.push(context, MaterialPageRoute(builder: (context) => OtherUserDataForPhoneAuth(phoneNumber)));
      }
      else{
        Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(0)));
      }

    } on FirebaseAuthException catch (ex) {
      print("FirebaseAuthException: ${ex.code} - ${ex.message}");
      // Ensure that the error message is not null or empty before displaying the toast.
      if (ex.message != null && ex.message!.isNotEmpty) {
        if(ex.message=="The verification code from SMS/TOTP is invalid. Please check and enter the correct verification code"){
          Fluttertoast.showToast(msg: "Enter Correct OTP");
        }
        Fluttertoast.showToast(msg: ex.message!);
      } else {
        Fluttertoast.showToast(msg: "An error occurred while verifying OTP.");
      }
    } catch (ex, stackTrace) {
      // Catch generic exceptions and print the stack trace for debugging purposes.
      print("Exception: $ex");
      print("StackTrace: $stackTrace");
      Fluttertoast.showToast(msg: "An unexpected error occurred. Please try again.");
    }
  }
  bool btnEnable=false;
  String OTP="";
  @override
  Widget build(BuildContext context) {

    final defaulrPinTheme= PinTheme(
      width: 56,
      height: 60,
      textStyle: TextStyle(fontSize: 22,color: Colors.white),
      decoration: BoxDecoration(
        color: Colors.grey.shade900,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.transparent)
      )
    );
    return Scaffold(
      body: Center(
        child: Container(
          color: Colors.black,
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0),
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
                'Please enter the OTP sent to your Phone Number',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 20.0),
              Container(
                height: 70, // Specify the desired height
                child: Pinput(
                  length: 6,
                  defaultPinTheme: defaulrPinTheme,
                  focusedPinTheme: defaulrPinTheme.copyWith(
                    decoration: defaulrPinTheme.decoration!.copyWith(
                      border: Border.all(color: Colors.grey.shade900)
                    )
                  ),
                  onCompleted: (pin){
                    setState(() {
                      btnEnable=true;
                      OTP=pin;
                    });
                  },
                ),

              ),
              SizedBox(height: 20.0),
              SizedBox(
                width: double.infinity,
                height: 45,
                child: ElevatedButton(
                  onPressed: btnEnable?(){
                    optVerification(OTP);
                  }:null,
                  child: Text(
                    'Verify OTP',
                    style: TextStyle(color: Colors.black),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
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
      ),
    );
  }
}
