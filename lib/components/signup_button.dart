import 'package:flutter/material.dart';
import 'package:pexels_clone_app/pages/login_page.dart';


class SignupButton extends StatelessWidget{
  final Function()? onTap;

  const SignupButton ({Key? key, required this.onTap}): super(key: key); 

  @override
  Widget build(BuildContext context){
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
      margin: const EdgeInsets.symmetric(horizontal: 120),
      decoration: BoxDecoration(
        color: Colors.grey.shade600,
        borderRadius: BorderRadius.circular(10)  
        ),
      child: MaterialButton(
        onPressed: (() {
          Navigator.push(context,
          MaterialPageRoute(builder: (context) => LoginScreen())
          );
        }),
        child: Text(
          "Sign Up",
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

}