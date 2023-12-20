import 'package:flutter/material.dart';
import 'package:pexels_clone_app/components/signup_button.dart';
import 'package:pexels_clone_app/components/my_textfield.dart';
import 'package:pexels_clone_app/pages/login_page.dart';


class SignupPage extends StatelessWidget{
  SignupPage({super.key});

  //text editing controllers
  final emailController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmpasswordController = TextEditingController();

  void signUserUp() {}



  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.blue.shade200,
      body: SafeArea(
        child: Center(
          child: Column (
            children: [
              
              const SizedBox(height: 50,),
              
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                //logo
                Image.asset('assets/images/white_logo.png', scale: 8,),
                

                //title
                const Text(
                  'Pixels',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                  )
                ),

                ],
              ),

              

              const SizedBox(height: 15,),
              //slogan
              const Text(
                'The best stock photos and royalty-free images shared by creators',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                ),
              ),

              const SizedBox(height: 40,),
              //email
              MyTextField(
                controller: emailController,
                hintText: 'Email',
                obscureText: false,
                ),

              const SizedBox(height :10,),
              //username
              MyTextField(
                controller: usernameController,
                hintText: 'Username',
                obscureText: false
                ),

              const SizedBox(height: 10,),
              //password
              MyTextField(
                controller: passwordController,
                hintText: 'Password',
                obscureText: true
                ),

              const SizedBox(height: 10,),
              //confirm password
              MyTextField(
                controller: confirmpasswordController,
                hintText: 'Confirm Password',
                obscureText: true
                ),

              
              const SizedBox(height: 25,),
              //sign up button
              SignupButton(
                onTap: signUserUp,
              ),


              const SizedBox(height: 25,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  //have an account
                  const Text(
                    'Have an account?',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),

                  const SizedBox(width: 10,),

                  //for log in page
                  
                  InkWell(
                    onTap: (){
                      Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    },
                    child: Text(
                      'Log In',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                        decorationColor: Colors.white,
                        fontSize: 25
                      )
                    ),
                  )
                  
                  
                  
                  
                  
                  
                  

                  
                
                ],
              )
        
            


              

              
            ]

          ),
        )
      ),
    );
  }
}