import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:scholar_personal_tutor/ForgetPaswordScreen.dart';
import 'package:scholar_personal_tutor/HomePage.dart';
import 'package:scholar_personal_tutor/OtherUserDataForGoogleAuth.dart';
import 'package:scholar_personal_tutor/PhoneNumberPage.dart';
import 'package:scholar_personal_tutor/SignUp.dart';

import 'SigninButton.dart';
import 'my_textfield.dart';
import 'square_tile.dart';
import 'dart:ui' show lerpDouble;

class LoginScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return LoginScreenState();
  }
}
 class LoginScreenState extends State<LoginScreen>{
// text editing controllers
final emailController = TextEditingController();
final passwordController = TextEditingController();
// sign user in method
Future<void> signUserIn() async{
  try {
    final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.toString(),
        password: passwordController.text.toString()
    );
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomePage(0)));
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      Fluttertoast.showToast(msg: "Enter correct email");
    } else if (e.code == 'wrong-password') {
      Fluttertoast.showToast(msg: "Enter Correct password");
    }
    else if(e.message.toString()=="The supplied auth credential is incorrect, malformed or has expired."){
      Fluttertoast.showToast(msg: "Enter correct email and password");
    }
  }
}
GoogleSignIn googleSignIn=GoogleSignIn();
Future<void> continueWithGoogle()async{
  try{
    var result=await googleSignIn.signIn();
    if(result==null){
      return;
    }
    final userData=await result.authentication;
    final credential=GoogleAuthProvider.credential(
      accessToken: userData.accessToken,idToken: userData.idToken
    );
    var finalResult=await FirebaseAuth.instance.signInWithCredential(credential);
    if(finalResult!=null){
      try {
        DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
            .collection('users') // Replace 'your_collection' with your collection name
            .doc(finalResult.additionalUserInfo!.profile!['email']) // Specify the document ID
            .get();
        if(!documentSnapshot.exists){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>OtherUserDataForGoogleAuth(finalResult.additionalUserInfo!.profile!['email'])));
        }
        else{
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomePage(0)));
        }
      } catch (e) {
        print(e.toString());
      }

    }
  }
  catch(error){
    print(error.toString());
  }
}

@override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
      body:Center(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 40),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Text(
                    'Login',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ),

                // welcome back, you've been missed!

                const SizedBox(height:10 ),

                // username textfield
                MyTextField(
                  controller: emailController,
                  hintText: 'Email',
                  obscureText: false,
                ),

                const SizedBox(height: 10),

                // password textfield
                MyTextField(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true,
                ),

                const SizedBox(height: 10),
                // forgot password?
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap:(){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>ForgotPasswordScreen()));
                        },
                        child: Text(
                          'Forgot Password?',
                          style: TextStyle(color: Colors.blue),

                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 25),

                // sign in button
                MyButtonTwo(
                  onTap: signUserIn,
                ),

                const SizedBox(height: 20),

                // or continue with
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.white,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          'Or',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                // google + apple sign in buttons
                Center(
                  child: Container(
                    width: 170,
                    child: Row(
                      //mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children:  [
                        // google button
                        InkWell(
                          onTap: (){
                            continueWithGoogle();
                          },
                          child: Container(
                            width: 70,
                            height: 70,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: Image.asset("assets/images/google.png"),
                            ),
                          ),
                        ),
                        SizedBox(width: 30,),
                        InkWell(
                          onTap: (){
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>PhoneNumberPage()));
                          },
                          child: Container(
                            width: 70,
                            height: 70,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: Image.asset('assets/images/call.png'),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // not a member? register now
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Not a member?',
                      style: TextStyle(color: Colors.white),
                    ),

                    TextButton(onPressed: (){
                      Navigator.push(context,MaterialPageRoute(builder: (context)=>SignUpPage()));
                    }, child: Text("Register Now",style: TextStyle(color: Colors.blue),))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}