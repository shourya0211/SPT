import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:scholar_personal_tutor/HomePage.dart';
import 'package:scholar_personal_tutor/square_tile.dart';

import 'LoginScreen.dart';
import 'my_button.dart';
import 'my_textfield.dart';

class OtherUserDataForPhoneAuth extends StatefulWidget {
  String phoneNumber;
  OtherUserDataForPhoneAuth(this.phoneNumber);

  @override
  State<OtherUserDataForPhoneAuth> createState() => _OtherUserDataForPhoneAuthState(phoneNumber);
}

class _OtherUserDataForPhoneAuthState extends State<OtherUserDataForPhoneAuth> {
  _OtherUserDataForPhoneAuthState(this.phoneNumber);
  String _selectedOption="Select" ;
  String phoneNumber;
  final confirmPasswordController = TextEditingController();
  final emailContoller = TextEditingController();
  final nameController = TextEditingController();
  var db = FirebaseFirestore.instance;
  Future<void>saveData()async{
    if(emailContoller.text==""){
      Fluttertoast.showToast(msg: "Enter Email");
    }
    else if(!emailContoller.text.contains("@")){
      Fluttertoast.showToast(msg: "Enter Correct Email");
    }
    else if(nameController.text==""){
      Fluttertoast.showToast(msg: "Enter Name");
    }else if(_selectedOption=="Select"){
      Fluttertoast.showToast(msg: "Select Course");
    }
    else{
      final data = <String, dynamic>{
        "email": emailContoller.text,
        "name": nameController.text,
        "password": "Sign in with Phone Number",
        "course": _selectedOption,
        "profilepic":"",
        "phone":phoneNumber,
        "items":[],
      };
      db.collection("users").doc("+91$phoneNumber").set(data)
          .onError((e, _) => print("Error writing document: $e"));
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomePage(0)));
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
                    'Fill this form',
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
                MyTextField(
                  controller: emailContoller,
                  hintText: 'E-mail',
                  obscureText: false,
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
                            child: Text("Course",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.grey)),
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
                GestureDetector(
                  onTap: (){
                    saveData();
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Center(
                        child: Text(
                          "Submit",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
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
