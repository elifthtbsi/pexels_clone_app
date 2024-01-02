import 'package:flutter/material.dart';
import 'package:pexels_clone_app/pages/login_page.dart';
import 'package:url_launcher/url_launcher.dart';


class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String username = 'kullanıcı adı';
  String password = 'şifre';

  // Simüle edilmiş bir çıkış işlemi
  void logOut() {
    // Burada gerçek bir oturum kapatma işlemi gerçekleştirilebilir.
    // Örneğin, kullanıcı bilgilerini temsil eden değişkenleri sıfırlayabilir veya bir oturum yöneticisi kullanabilirsiniz.
    // Bu örnekte, sadece örnek verileri sıfırlıyoruz.
    setState(() {
      username = '';
      password = '';
    });

    // Çıkış işlemi tamamlandığında giriş sayfasına yönlendirme yapılır
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  // Pixels Hakkında sayfasına yönlendirme işlemi
  void navigateToPixelsAbout() {
    // Pexels web sitesine yönlendirme yapılır
    // ignore: deprecated_member_use
    launch('https://www.pexels.com/');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade200,
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 100),
              CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/profile_image.jpg'),
              ),
              SizedBox(height: 70),
              Text(
                'Username: $username',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Password: $password',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
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
                  'Hakkında',
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
