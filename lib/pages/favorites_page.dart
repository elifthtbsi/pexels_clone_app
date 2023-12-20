import 'package:flutter/material.dart';

class FavoritesPage extends StatefulWidget {
  final List<String> favoriteImageUrls;

  FavoritesPage({required this.favoriteImageUrls});

  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade200,
      body: ListView.builder(
        itemCount: widget.favoriteImageUrls.length,
        itemBuilder: (context, index) {
          final imageURL = widget.favoriteImageUrls[index];
          return ListTile(
            title: Image.network(
              imageURL,
              fit: BoxFit.cover,
            ),
          );
        },
      ),
    );
  }
}
