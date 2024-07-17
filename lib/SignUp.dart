import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:scholar_personal_tutor/HomePage.dart';
import 'my_button.dart';
import 'my_textfield.dart';
import 'dart:ui' show lerpDouble;

class SignUpPage extends StatefulWidget {


  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String _selectedOption="Select" ;
  var db = FirebaseFirestore.instance;
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final emailContoller = TextEditingController();
  final nameController = TextEditingController();
  final phoneContoller = TextEditingController();
  var OPTVerification=false;
  var OTPBox=false;
  Future<void> createAccount(String email,String password,String name,String phoneNumber)async{
    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final data = <String, dynamic>{
        "email": email,
        "name": name,
        "password": password,
        "course": _selectedOption,
        "profilepic":"",
        "phone":phoneNumber,
        "items":[],
      };

      db.collection("users").doc(email).set(data)
          .onError((e, _) => print("Error writing document: $e"));
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomePage(0)));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Fluttertoast.showToast(msg: "The password provided is too weak.");
      } else if (e.code == 'email-already-in-use') {
        Fluttertoast.showToast(msg: "The account already exists for that email.");
      }
    } catch (e) {
      print(e);
    }
  }
  void sendOTP(){
    String email= emailContoller.text.toString();
    if(email.isEmpty){
      Fluttertoast.showToast(msg: "Enter Email");
    }
    else if(!email.contains("@")){
      Fluttertoast.showToast(msg: "Enter Correct Email");
    }else{

    }
  }

  void signUpUser() {
    String email= emailContoller.text.toString();
    String password=passwordController.text.toString();
    String name=nameController.text.toString();
    String phoneNumber=phoneContoller.text.toString();
    String conformPassword=confirmPasswordController.text.toString();
    if(name==""){
      Fluttertoast.showToast(msg: "Enter Name");
    }
    else if(email==""){
      Fluttertoast.showToast(msg: "Enter Email");
    }
    else if(phoneNumber==""){
      Fluttertoast.showToast(msg: "Enter Phone Number");
    }
    else if(phoneNumber.length!=10){
      Fluttertoast.showToast(msg:"Enter Correct Phone Number");
    }
    else if(!email.contains("@")){
      Fluttertoast.showToast(msg: "Enter Correct Email");
    }
    else if(password==""){
      Fluttertoast.showToast(msg: "Enter Password");
    }
    else if(conformPassword==""){
      Fluttertoast.showToast(msg: "Enter Conform Password");
    }
    else if(password!=conformPassword){
      Fluttertoast.showToast(msg: "Password not matched");
    }
    else if(_selectedOption=="Select"){
      Fluttertoast.showToast(msg: "Select Course");
    }
    else{
      createAccount(email,password,name,phoneNumber);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(

          child: Center(

            child: SingleChildScrollView(
              child: Column(

                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: Text(
                      'Create an Account',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  MyTextField(
                    controller: nameController,
                    hintText: 'Name',
                    obscureText: false,
                  ),
                  const SizedBox(height: 10),
                  // MyTextField(
                  //   controller: emailContoller,
                  //   hintText: 'E-mail',
                  //   obscureText: false,
                  // ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: TextField(

                      style: TextStyle(color: Colors.white),
                      controller: emailContoller,
                      obscureText: false,
                      decoration: InputDecoration(
                        suffixIcon: TextButton(
                            onPressed: (){
                              sendOTP();
                            },
                            child: Text("Send OTP")),
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
                    ),
                  ),
                  const SizedBox(height: 10),
                  MyTextField(
                    controller: phoneContoller,
                    hintText: 'Phone Number',
                    obscureText: false,
                  ),
                  const SizedBox(height: 10),
                  MyTextField(
                    controller: passwordController,
                    hintText: 'Password',
                    obscureText: true,
                  ),
                  const SizedBox(height: 10),
                  MyTextField(
                    controller: confirmPasswordController,
                    hintText: 'Confirm Password',
                    obscureText: true,
                  ),
                  const SizedBox(height: 10),


                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Container(
                      height: 46,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey.shade900,
                        border: Border.all(
                          color: Colors.white, // Set the color of the border
                          width: 1.0, // Set the width of the border
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Text("Select Course",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.grey)),
                          ),
                          Padding(

                            padding: const EdgeInsets.all(5),
                            child: DropdownButton<String>(
                              dropdownColor: Colors.grey.shade900,
                              style: TextStyle(color: Colors.white),
                              value: _selectedOption,
                              onChanged: (String? newValue) {
                                setState(() {
                                  _selectedOption = newValue!;
                                });
                              },
                              items: <String>['Select', 'IIT JEE', 'NEET', 'AI & ML','Competitve Programming','Website Development','French Language']
                                  .map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                  const SizedBox(height: 20),
                  MyButton(
                    onTap: signUpUser,
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      );

  }
}



