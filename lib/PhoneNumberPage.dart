import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:scholar_personal_tutor/OTPVerificationScreen.dart';

class PhoneNumberPage extends StatefulWidget {
  @override
  _PhoneNumberPageState createState() => _PhoneNumberPageState();
}

class _PhoneNumberPageState extends State<PhoneNumberPage> {
  final TextEditingController phoneNumberController = TextEditingController();
  Future<void> phoneNumber() async {
    var phoneNumber = phoneNumberController.text;
    if(phoneNumber==""){
      Fluttertoast.showToast(msg: "Enter Phone Number");
    }
    else if(phoneNumber.length!=10){
      Fluttertoast.showToast(msg: "Enter Correct Phone Number");
    }
    else{
      FirebaseAuth.instance.verifyPhoneNumber(
          verificationCompleted: (PhoneAuthCredential credential) {},
          verificationFailed: (FirebaseException ex) {print(ex.message);},
          codeSent: (String verificationid, int? resendtoken) {
            print("object");
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => OTPVerificationScreen(verificationid,phoneNumber)));
          },
          codeAutoRetrievalTimeout: (String verificationId) {},
          phoneNumber: "+91$phoneNumber");
    }


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enter Phone Number',
            style: TextStyle(color: Colors.white)), // Change app bar text color
        backgroundColor: Colors.black, // Change app bar background color
      ),
      body: Container(
        color: Colors.black, // Set background color for the body
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 60,
              child: TextField(
                controller: phoneNumberController,
                keyboardType: TextInputType.number,
                style: TextStyle(
                    color: Colors.white), // Change text color of text field
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                  labelStyle:
                      TextStyle(color: Colors.white), // Change label color
                  hintText: 'Enter your phone number',
                  hintStyle:
                      TextStyle(color: Colors.grey), // Change hint text color
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.white), // Change border color
                    borderRadius:
                        BorderRadius.circular(10.0), // Set border radius
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.white), // Change focused border color
                    borderRadius:
                        BorderRadius.circular(10.0), // Set border radius
                  ),
                  filled: true,
                  fillColor: Colors.grey[900], // Set background color to grey900
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                phoneNumber();
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    Colors.white), // Set button background color
              ),
              child: Text('Submit',
                  style: TextStyle(
                      color: Colors.black)), // Change button text color
            ),
          ],
        ),
      ),
    );
  }
}
