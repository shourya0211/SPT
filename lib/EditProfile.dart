import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:scholar_personal_tutor/HomePage.dart';

class EditProfile extends StatefulWidget {
  String userId;
  String type;
  String course;
  String data;
  EditProfile(this.userId,this.type,this.course,this.data);
  //const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  String _selectedOption="Select" ;
  final phoneController=TextEditingController();
  final emailController=TextEditingController();
  Future<void>profileUpdate()async{
    String email=emailController.text;
    String phoneNumber=phoneController.text;
    if(widget.type=="email"){
      if(phoneNumber.isEmpty){
        Fluttertoast.showToast(msg: "Enter Phone Number");
      }
      else if(phoneNumber.length!=10){
        Fluttertoast.showToast(msg: "Enter Correct Phone Number");
      }
      else if(_selectedOption=="Select"){
        Fluttertoast.showToast(msg: "Select Course");
      }
      else{
        // Get reference to the 'users' collection
        CollectionReference users = FirebaseFirestore.instance.collection('users');

        // Update data
        await users.doc(widget.userId).update({
          'phone': phoneNumber,
          'course': _selectedOption,
        });
        Navigator.pop(context);
      }
    }
    else{
      if(email.isEmpty){
        Fluttertoast.showToast(msg: "Enter Email");
      }
      else if(!email.contains("@")){
        Fluttertoast.showToast(msg: "Enter Correct Email");
      }
      else {
        // Get reference to the 'users' collection
        CollectionReference users = FirebaseFirestore.instance.collection('users');

        // Update data
        await users.doc(widget.userId).update({
          'email': email,
          'course': _selectedOption,
        });
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 80),
        child: Column(
          children: [
            Text(
              'Edit Profile',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: widget.type=="email"?Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      //borderRadius: BorderRadius.circular(15),
                      color: Colors.grey.shade900,
                    ),

                    child: TextField(
                      keyboardType: TextInputType.number,
                      controller: phoneController,
                      decoration: InputDecoration(
                        labelText: 'Phone',
                        enabled: true,
                        labelStyle: TextStyle(color: Colors.white),
                        border: OutlineInputBorder(),
                      ),
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    width: double.infinity,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade900
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20,right: 30),
                          child: Text("Select Course",style: TextStyle(color: Colors.white,fontSize: 15),),
                        ),
                        DropdownButton<String>(
                          style: TextStyle(color: Colors.white),
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
                        )
                      ],
                    ),
                  ),

                ],
              ):Column(
                children: [
                  Container(
                    height:60,
                    decoration: BoxDecoration(
                      //borderRadius: BorderRadius.circular(15),
                      color: Colors.grey.shade900,
                    ),

                    child: TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        enabled: true,
                        labelStyle: TextStyle(color: Colors.white),
                        border: OutlineInputBorder(),
                      ),
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    width: double.infinity,
                    height: 60,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade900
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20,right: 30),
                          child: Text("Course",style: TextStyle(color: Colors.white,fontSize: 15),),
                        ),
                        DropdownButton<String>(
                          style: TextStyle(color: Colors.white),
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
                        )
                      ],
                    ),
                  ),

                ],
              )
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    profileUpdate();
                  },
                  icon: Icon(Icons.arrow_circle_right_outlined,color: Colors.black,),
                  label: Text(
                    'Update',
                    style: TextStyle(color: Colors.black),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white, // Change button color to white
                  ),
                ),
              ],
            ),
          ],
        ),
      ),

    );
  }
}