import 'package:flutter/material.dart';
import 'package:pexels_clone_app/components/my_textfield.dart';

final emailController = TextEditingController();

class ForgotPasswordPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Forgot Password?'),
        backgroundColor: Colors.grey.shade600,
        ),
      backgroundColor: Colors.blue.shade200,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 15),
            const Text(
              "Let's send you a new password!",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
              ),
            ),
            const SizedBox(height: 55),
  
            Padding(
              padding: const EdgeInsets.symmetric(horizontal:100.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text(
                    "What' your email?",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 5),

            MyTextField(
              controller: emailController, 
              hintText: "name@email.com", 
              obscureText: false
              ),
            const SizedBox(height: 16.0,),
                Container(
                  padding: const EdgeInsets.all(15),
                  margin:const EdgeInsets.symmetric(horizontal: 120),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade600,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Center(
                    child: Text(
                      "Reset Password",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                )
          ],
        ),
      ),
    );
  }
}