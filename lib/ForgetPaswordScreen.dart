import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:ui' show lerpDouble;

import 'package:scholar_personal_tutor/LoginScreen.dart';

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
                    contentPadding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: Colors.grey.shade400),
                    ),
                    fillColor: Colors.grey.shade900,
                    filled: true,
                    hintText: "Email",
                    hintStyle: TextStyle(color: Colors.grey[500])
                ),
                keyboardType: TextInputType.emailAddress,
              ),
            ),
            SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              height: 45,
              child: ElevatedButton(
                onPressed: () async{
                  String email=emailController.text;
                  try{
                    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
                        .collection('users') // Replace with your collection name
                        .doc(email)
                        .get();
                    if(documentSnapshot.exists){
                      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.success,
                        animType: AnimType.rightSlide,
                        title: 'Success',
                        desc: "Forgot Password link successfully send on your email id",
                        btnOkOnPress: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                        },
                      )..show();
                    }
                    else{
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.error,
                        animType: AnimType.rightSlide,
                        title: 'Error',
                        desc: "This email doesn't exist",
                        btnOkOnPress: () {

                        },
                      )..show();
                    }

                  }
                  catch (error) {
                    print(error.toString());
                  }


                  //print(a);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white
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
