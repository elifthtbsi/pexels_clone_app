import 'package:flutter/material.dart';
import 'package:pexels_clone_app/JsonModels/users.dart';
import 'package:pexels_clone_app/pages/overview.dart';
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

  final username = TextEditingController();
  final password = TextEditingController();
  

  bool isVisible = false;

  bool isLoginTrue = false;

  final db = DatabaseHelper();

  login() async {
    var response = await db
        .login(Users(usrName: username.text, usrPassword: password.text));
    if (response == true) {
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
              
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade200,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
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
                                setState(() {
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
                            login();
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