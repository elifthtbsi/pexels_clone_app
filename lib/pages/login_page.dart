import 'package:flutter/material.dart';
import 'package:pexels_clone_app/JsonModels/users.dart';
import 'package:pexels_clone_app/pages/overview.dart';
import 'package:pexels_clone_app/pages/profile.dart';
import 'package:pexels_clone_app/pages/signup_page.dart';
import 'package:pexels_clone_app/SQLite/sqlite.dart';
import 'package:pexels_clone_app/providers/user_provider.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen();

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  late Users loggedInUser;
  //We need two text editing controller

  //TextEditing controller to control the text when we enter into it
  final username = TextEditingController();
  final password = TextEditingController();
  

  //A bool variable for show and hide password
  bool isVisible = false;

  //Here is our bool variable
  bool isLoginTrue = false;

  final db = DatabaseHelper();

  //Now we should call this function in login button
  login() async {
    var response = await db
        .login(Users(usrName: username.text, usrPassword: password.text));
    if (response == true) {
      // Giriş başarılıysa, kullanıcı bilgilerini loggedInUser değişkenine atayın
      loggedInUser = Users(usrName: username.text, usrPassword: password.text);

      if (!mounted) return;

     Provider.of<UserProvider>(context, listen: false).setUser(username.text, password.text);


      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) =>  Overview()
          
          ));
    } else {
      setState(() {
        isLoginTrue = true;
      });
    }
  }
              
  //We have to create global key for our form
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade200,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            //We put all our textfield to a form to be controlled and not allow as empty
            child: Form(
              key: formKey,
              child: Column(
                children: [

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                       Image.asset(
                        "/home/elifthtbsi/Desktop/flutter_project/pexels_clone_app/assets/images/white_logo.png",
                        width:100,
                      ),

                       SizedBox(width: 20,),

                      Text('Pixels',
                        style: TextStyle( 
                        color: Colors.white,
                        fontSize: 60,
                        fontWeight: FontWeight.bold,
                        )
                      ),
                    ],
                  ),
                
                  //Username field

                  const SizedBox(height: 15),
                  Container(
                    margin: const EdgeInsets.all(8),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white),
                    child: TextFormField(
                      controller: username,
                      cursorColor: Colors.black,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "username is required";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        icon: Icon(Icons.person),
                        border: InputBorder.none,
                        hintText: "Username",
                      ),
                    ),
                  ),

                  //Password field
                  Container(
                    margin: const EdgeInsets.all(8),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white),
                    child: TextFormField(
                      controller: password,
                      cursorColor: Colors.black,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "password is required";
                        }
                        return null;
                      },
                      obscureText: !isVisible,
                      decoration: InputDecoration(
                          icon: const Icon(Icons.lock),
                          border: InputBorder.none,
                          hintText: "Password",
                          suffixIcon: IconButton(
                              onPressed: () {
                                //In here we will create a click to show and hide the password a toggle button
                                setState(() {
                                  //toggle button
                                  isVisible = !isVisible;
                                });
                              },
                              icon: Icon(isVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off))),
                    ),
                  ),

                  const SizedBox(height: 10),
                  //Login button
                  Container(
                    height: 55,
                    width: MediaQuery.of(context).size.width * .9,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.grey.shade600),
                    child: TextButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            //Login method will be here
                            login();

                            //Now we have a response from our sqlite method
                            //We are going to create a user
                          }
                        },
                        child: const Text(
                          "LOGIN",
                          style: TextStyle(color: Colors.white),
                        )),
                  ),

                  SizedBox(height: 25,),

                  //Sign up button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account?",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                        ),
                      ),


                      TextButton(
                          onPressed: () {
                            //Navigate to sign up
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignUp()));
                          },
                          child: const Text("SIGN UP",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            decoration: TextDecoration.underline,
                            decorationColor: Colors.white,
                            decorationThickness: 7,
                          ),
                          )
                          )
                    ],
                  ),

                  // We will disable this message in default, when user and pass is incorrect we will trigger this message to user
                  isLoginTrue
                      ? const Text(
                          "Username or password is incorrect",
                          style: TextStyle(color: Colors.red),
                        )
                      : const SizedBox(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}