import 'package:flutter/material.dart';
import 'package:pexels_clone_app/pages/signup_page.dart';
import 'forgot_password.dart';
import 'package:pexels_clone_app/components/login_button.dart';
import 'package:pexels_clone_app/components/my_textfield.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  //text editing controllers
  final emailController = TextEditingController();
  final passwordContoller = TextEditingController();

  // sign user in method

  void signUserIn () {}


  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.blue.shade200,
      body: SafeArea(
        child:Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              const SizedBox(height:50,),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  //logo
                  Image.asset('assets/images/white_logo.png', scale:8),

                  //title
                  const Text(
                    'Pixels',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 60,
                    )
                  )
                  

                ],
              ),


 
              const SizedBox(height: 50),
              //email textfield

              MyTextField(
                controller: emailController,
                hintText: 'Email',
                obscureText: false,
              ),

              const SizedBox(height: 10),
              //password textfield

              MyTextField(
                controller: passwordContoller,
                hintText: 'Password',
                obscureText: true,
              ),

              const SizedBox(height: 10),
              //forgot password?

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 100.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: (){
                        Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ForgotPasswordPage()),
                        );
                      },
                      child: Text(
                        'Forgot Password?',
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 15
                        )
                      ),
                    )
                  ],
                ),
              ),

              const SizedBox(height: 25),
              //log in button

              LoginButton(
                onTap: signUserIn,
              ),



              const SizedBox(height: 150), 
              //sign up button

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                
                children: [
                  //don't have an account?

                  const Text(
                    "Don't have an account?" ,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20
                    ),
                  ),

                  const SizedBox(width:10,),

                  //for sign up page
                  

                  InkWell(
                    onTap: (){
                      Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SignupPage()),
                      );
                    },
                    child: Text(
                      'Sign Up',
                      style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.white,
                      fontSize: 25,
                      ),
                    ),
                  )  
                ],
              ),
            

        ]
        ),
      )
      ),

    );
  }

}