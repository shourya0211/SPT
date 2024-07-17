import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'HomePage.dart';
import 'my_textfield.dart';

class OtherUserDataForGoogleAuth extends StatefulWidget {
  String email;
  OtherUserDataForGoogleAuth(this.email);
  @override
  State<OtherUserDataForGoogleAuth> createState() => _OtherUserDataForGoogleAuthState(email);
}

class _OtherUserDataForGoogleAuthState extends State<OtherUserDataForGoogleAuth> {
  String email;
  _OtherUserDataForGoogleAuthState(this.email);
  String _selectedOption="Select" ;
  final confirmPasswordController = TextEditingController();
  final phoneContoller = TextEditingController();
  final nameController = TextEditingController();
  var db = FirebaseFirestore.instance;
  Future<void>saveData()async{
    if(phoneContoller.text==""){
      Fluttertoast.showToast(msg: "Enter Phone Number");
    }
    else if(phoneContoller.text.length!=10){
      Fluttertoast.showToast(msg: "Enter Correct Phone Number");
    }
    else if(nameController.text==""){
      Fluttertoast.showToast(msg: "Enter Name");
    }else if(_selectedOption=="Select"){
      Fluttertoast.showToast(msg: "Select Course");
    }
    else{
      final data = <String, String>{
        "email": email,
        "name": nameController.text,
        "password": "Sign in with Google Account",
        "course": _selectedOption,
        "profilepic":"",
        "phone":phoneContoller.text
      };
      db.collection("users").doc(email).set(data)
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
                  controller: phoneContoller,
                  hintText: 'Phone Number',
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
                            child: Text("Select Course",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.grey)),
                          ),
                          Padding(

                            padding: const EdgeInsets.all(5),
                            child: DropdownButton<String>(
                              style: TextStyle(color: Colors.white,),
                              dropdownColor: Colors.grey.shade900,
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
