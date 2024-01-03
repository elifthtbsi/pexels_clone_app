import 'package:flutter/material.dart';
import 'package:pexels_clone_app/pages/favorites_page.dart';
import 'package:pexels_clone_app/pages/homepage.dart';
import 'package:pexels_clone_app/pages/profile.dart';
import 'package:pexels_clone_app/pages/search_page.dart';


class Overview extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState ();
}

class _MyAppState extends State <Overview> {
  int _selectedIndex = 0 ;

  List<Widget> _pages = [
    HomePage(),
    SearchPage(),
    FavoritesPage(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _pages[_selectedIndex],
          bottomNavigationBar: BottomNavigationBar(
            items: <BottomNavigationBarItem> [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home Page',
                ),

              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: 'Search',
                ),

              BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                label: 'Favorites',
                ),

              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
                ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.blue.shade200,
            unselectedItemColor: Colors.grey.shade600,
            onTap: _onItemTapped,
            ),
        );
  }
}











