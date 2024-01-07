import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pexels_clone_app/providers/photo_provider.dart';
import 'package:provider/provider.dart';

class DownloadHelper {
  static Future<void> showDownloadSuccessDialog(BuildContext context, String filePath) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Download Successful'),
          content: Text('The image was successfully downloaded and saved!'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Okay :)'),
            ),
          ],
        );
      },
    );
  }

  static Future<void> showErrorDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Download Error'),
          content: Text('The image could not be downloaded, please try again!'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Okay :('),
            ),
          ],
        );
      },
    );
  }
}

class FavoritesPage extends StatelessWidget {
  Future<void> _downloadImage(BuildContext context, String imageURL) async {
  final response = await http.get(Uri.parse(imageURL));

  if (response.statusCode == 200) {
    final directory = await getApplicationDocumentsDirectory();

    final unique_file_name = imageURL.split('/').last.split('.').first;

    final filePath = '${directory.path}/$unique_file_name.jpg';

    File file = File(filePath);
    await file.writeAsBytes(response.bodyBytes);

    DownloadHelper.showDownloadSuccessDialog(context, filePath);
    print('Görsel başarıyla indirildi ve kaydedildi: $filePath');
  } else {
    // İndirme başarısız oldu.
    print('Görsel indirilemedi. HTTP Hata Kodu: ${response.statusCode}');
    DownloadHelper.showErrorDialog(context);
  }
}


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
                          Provider.of<PhotoProvider>(context, listen: false)
                              .removeFavoritePhoto(favoritePhotos[index].imageUrl);
                        },
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 30),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade600,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: InkWell(
                          onTap: () {
                            _downloadImage(context, favoritePhotos[index].imageUrl);
                          },
                          child: Text(
                            'Download',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
