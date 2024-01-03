import 'package:flutter/material.dart';
import 'package:pexels_clone_app/providers/photo_provider.dart';
import 'package:provider/provider.dart';

class FavoritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Photo> favoritePhotos = Provider.of<PhotoProvider>(context).favoritePhotos;

    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite Photos'),
        backgroundColor: Colors.grey.shade500,
      ),
      backgroundColor: Colors.blue.shade200,
      body: favoritePhotos.isEmpty
          ? Center(
              child: Text(
                'No favorite photos yet!',
                style: TextStyle(fontSize: 20),
              ),
            )
          : ListView.builder(
              itemCount: favoritePhotos.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Container(
                    margin: EdgeInsets.only(top: 100, bottom: 20),
                    child: Image.network(
                      favoritePhotos[index].imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                  subtitle: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: Icon(Icons.favorite, color: Colors.red, size: 40),
                        onPressed: () {
                          // Favori fotoğrafı kaldırmak istediğinizde
                          Provider.of<PhotoProvider>(context, listen: false)
                              .removeFavoritePhoto(favoritePhotos[index].imageUrl);
                        },
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 30),
                        decoration: BoxDecoration(
                            color: Colors.grey.shade600,
                            borderRadius: BorderRadius.circular(10)),
                        child: Text(
                          'Download',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
    );
  }
}
