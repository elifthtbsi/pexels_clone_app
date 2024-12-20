import 'package:flutter/material.dart';
import 'package:pexels_clone_app/pages/login_page.dart';
import 'package:pexels_clone_app/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';


class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String username = 'kullanıcı adı';
  String password = 'şifre';

  

  void logOut() {
    setState(() {
      username = '';
      password = '';
    });

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  void navigateToPixelsAbout() {
    launch('https://www.pexels.com/');
  }

  @override
  Widget build(BuildContext context) {

    String? username = Provider.of<UserProvider>(context).username;
    String? password= Provider.of<UserProvider>(context).password;

    return Scaffold(
      backgroundColor: Colors.blue.shade200,
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 100),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                   Image.asset(
                    "/home/elifthtbsi/Desktop/projects_for_school/flutter_project/pexels_clone_app/assets/images/black_logo.png",
                    width:100,
                  ),
                   SizedBox(width: 20,),
                  Text('Pixels',
                    style: TextStyle( 
                    color: Colors.black,
                    fontSize: 60,
                    fontWeight: FontWeight.bold,
                    )
                  ),
                ],
              ),
              SizedBox(height: 70),
              Text(
                'Username: $username',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Password: $password',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height:60),
              ElevatedButton(
                onPressed: logOut,
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.grey.shade600),
                ),
                child: Text(
                  'Log Out',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16),
                ),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: navigateToPixelsAbout,
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.grey.shade600),
                ),
                child: Text(
                  'About',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
