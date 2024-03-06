import 'package:flutter/material.dart';
import 'package:scholar_personal_tutor/LoginScreen.dart';
import 'my_button.dart';
import 'my_textfield.dart';
import 'square_tile.dart';
import 'dart:ui' show lerpDouble;

//const List<String> list = <String>['IIT-JEE','NEET','Machine Learning'];
class SignUpPage extends StatefulWidget {


  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {



  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final emailContoller = TextEditingController();



  void signUpUser() {}
  String _selectedOption="Select" ;
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
                    controller: usernameController,
                    hintText: 'Username',
                    obscureText: false,
                  ),
                  const SizedBox(height: 10),
                  MyTextField(
                    controller: confirmPasswordController,
                    hintText: 'E-mail',
                    obscureText: true,
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
                  child: Container(

                    width: 310,
                    height: 46,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey.shade200,
                      border: Border(
                        left: BorderSide(

                          width: 0.1,
                        ),
                        right: BorderSide(
                          width: 0.1,
                        )
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

                            value: _selectedOption,
                            onChanged: (String? newValue) {
                              setState(() {
                                _selectedOption = newValue!;
                              });
                            },
                            items: <String>['Select', 'IIT JEE', 'NEET', 'Machine Learning']
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

                  const SizedBox(height: 20),
                  MyButton(
                    onTap: signUpUser,
                  ),
                  const SizedBox(height: 20),

                  Column(

                    children: const [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
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
                                style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500),
                              ),
                            ),
                            Expanded(
                              child: Divider(
                                thickness: 0.6,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      // google button
                      SquareTile(
                        imagePath: 'assets/images/google.png',
                        text: 'Continue with Google',
                      ),
                      const SizedBox(height: 10),
                      SquareTile(
                        imagePath: 'assets/images/facebook.png',
                        text: 'Continue with Facebook',
                      ),
                      const SizedBox(height: 10),
                      SquareTile(
                        imagePath: 'assets/images/call.png',
                        text: 'Continue with Phone',
                      ),


                    ],
                  ),
                  const SizedBox(height: 20),


                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already a member?',
                        style: TextStyle(color: Colors.white),
                      ),
                      TextButton(onPressed: (){
                        Navigator.push(context,MaterialPageRoute(builder: (context)=>LoginScreen()));
                      }, child: Text("Sign In",style: TextStyle(color: Colors.blue),))
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



