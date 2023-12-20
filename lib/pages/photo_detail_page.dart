import 'package:flutter/material.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class PhotoDetailPage extends StatelessWidget {
  final String imageUrl;

  PhotoDetailPage({required this.imageUrl});

  Future<void> _downloadImage(BuildContext context, String imageURL) async {
    try {
      final response = await http.get(Uri.parse(imageURL));

      if (response.statusCode == 200) {
        final directory = await getApplicationDocumentsDirectory();
        final uniqueFileName =
            imageURL.split('/').last.split('.').first;
        final filePath = '${directory.path}/$uniqueFileName.jpg';
        File file = File(filePath);
        await file.writeAsBytes(response.bodyBytes);

        _showDownloadSuccessDialog(context, filePath);
        print('Görsel başarıyla indirildi ve kaydedildi: $filePath');
      } else {
        print('Görsel indirilemedi. HTTP Hata Kodu: ${response.statusCode}');
        _showErrorDialog(context);
      }
    } catch (e) {
      print('Görsel indirilirken hata oluştu: $e');
      _showErrorDialog(context);
    }
  }

  Future<void> _showDownloadSuccessDialog(
      BuildContext context, String filePath) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Download Successful'),
          content: Text('The image was successfully downloaded and saved'),
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

  Future<void> _showErrorDialog(BuildContext context) async {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade200,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Photo Detail',
          style: TextStyle(
            color: Colors.grey.shade600,
            fontSize: 20,
          ),
        ),
        iconTheme: IconThemeData (color: Colors.grey.shade600),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              title: Container(
                margin: EdgeInsets.only(top: 50, bottom: 20 ),
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                    ),
              ),
            subtitle: Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              margin: EdgeInsets.symmetric(vertical:10, horizontal: 120),
              decoration: BoxDecoration(
                color: Colors.grey.shade600,
                borderRadius: BorderRadius.circular(10)  
              ),
              child: InkWell(
                onTap: () {
                  _downloadImage(context, imageUrl);
                },
                child: Text(
                  'Download',
                  style: TextStyle(
                    color: Colors.white, 
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                  ),
                  textAlign: TextAlign.center,
                )
              )
            )
            ),
          ],
        ),
      )
    );
  }
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
}
