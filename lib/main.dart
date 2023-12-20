import 'package:flutter/material.dart';
//import 'package:firebase_core/firebase_core.dart';
//import 'package:pexels_clone_app/pages/auth_page.dart';
import 'package:pexels_clone_app/pages/login_page.dart';
//import 'firebase_options.dart';

void main() async{
  //WidgetsFlutterBinding.ensureInitialized();
  //await Firebase.initializeApp(
  //  options: DefaultFirebaseOptions.currentPlatform,
  //);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage()
      );
      
  }
}