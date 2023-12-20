import 'package:flutter/material.dart';
import 'package:pexels_clone_app/pages/overview.dart';

class LoginButton extends StatelessWidget{
  final Function()? onTap;

  const LoginButton ({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.grey.shade600,
        borderRadius: BorderRadius.circular(10)  ),
      child: MaterialButton(
        onPressed: (()  {
          Navigator.push(context, 
          MaterialPageRoute(builder: (context) => Overview())
          );
        }),
        child: Text(
          "Log In",
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

}