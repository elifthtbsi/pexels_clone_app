import 'package:flutter/material.dart';
import 'package:pexels_clone_app/pages/login_page.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
void main() async{
  sqfliteFfiInit();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen()
      );
      
  }
}