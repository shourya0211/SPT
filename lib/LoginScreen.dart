import 'package:flutter/material.dart';
import 'package:scholar_personal_tutor/SignUp.dart';

import 'SigninButton.dart';
import 'my_button.dart';
import 'my_textfield.dart';
import 'square_tile.dart';



class LoginScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return LoginScreenState();


  }
}
 class LoginScreenState extends State<LoginScreen>{
  //LoginScreenState({super.key});

// text editing controllers
final usernameController = TextEditingController();
final passwordController = TextEditingController();

// sign user in method
void signUserIn() {}

@override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
      body:SingleChildScrollView(
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
                controller: usernameController,
                hintText: 'Username',
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
                    Text(
                      'Forgot Password?',
                      style: TextStyle(color: Colors.blue),

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
              Column(

                children: const [
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
    );
  }
}