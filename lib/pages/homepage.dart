import 'package:flutter/material.dart';
import 'package:pexels_clone_app/pages/favorites_page.dart';
import 'homepage_request.dart';
import 'package:http/http.dart' as http;
import 'dart:io' ;
import 'package:path_provider/path_provider.dart';

class HomePage extends StatefulWidget{
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State <HomePage> {
  List<bool> isFavoriteList = List.filled(20, false);
  List<String>favoriteImageUrls = [];

  Future<void> _downloadImage(String imageURL) async {
    final response = await http.get(Uri.parse(imageURL));

    if (response.statusCode == 200) {
      final directory = await getApplicationDocumentsDirectory();

      final unique_file_name = imageURL.split('/').last.split('.').first;

      final filePath = '${directory.path}/$unique_file_name.jpg';

      File file = File(filePath);
      await file.writeAsBytes(response.bodyBytes);
      
      _showDownloadSuccessDialog(filePath);
      print('Görsel başarıyla indirildi ve kaydedildi: $filePath');

    }
     
    else {
      // İndirme başarısız oldu.
      print('Görsel indirilemedi. HTTP Hata Kodu: ${response.statusCode}');
      _showErrorDialog();
    }
  }

  Future<void> _showDownloadSuccessDialog(String filePath) async {
    return showDialog(
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
          title: Text('Download Successful'),
          content: Text('The image was successfully downloaded and saved'),
          actions: <Widget>[
            TextButton(
              onPressed: (){
                Navigator.of(context).pop();
              },
              child: Text('Okay :)'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showErrorDialog() async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Download Error'),
          content: Text('The image could not be downloaded, please try again!'),
          actions: <Widget>[
            TextButton(
              onPressed: (){
                Navigator.of(context).pop();
              },
              child: Text('Okay :('),
            ),
          ],
        );
      },
    );
  }

  void _navigateToFavoritePage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FavoritesPage(
          favoriteImageUrls: favoriteImageUrls,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade200,
      body: FutureBuilder(
        future: fetchData(),
        builder: (context, snapshot){
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          else if(snapshot.hasError){
            return Text('Hata: $snapshot.error');
          }
          else{
            final Map<String, dynamic> data = snapshot.data!;
            
            return ListView.builder(
                itemCount: data['photos'].length + 1,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return Center(
                      child: Container(
                        width: 400,
                        height: 600,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8)
                        ),
                        padding: EdgeInsets.only(top:50),
                        child: Column(
                          children:[
                            Image.asset('assets/images/black_logo.png', scale:8),

                            SizedBox(height: 50),

                            Text(
                              'Welcome to Pixels',
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: Colors.black,
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            SizedBox(height: 50),

                            Text(
                              'The best free stock photos, royalty free images shared by creators.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 30,
                              ),
                            ),

                            SizedBox(height: 100),

                            Text(
                              'scroll the page for the images',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20 
                              ),
                            ),

                            Icon(
                              Icons.arrow_downward,
                              size: 70,
                              color: Colors.black,
                            ),
                            
                          ],
                        ),
                      ),
                    );
                  }
                  
                  final imageURL = data['photos'][index - 1]['src']['large'];

          
                  return Column(
                    children: [
                      ListTile(
                          title: Container(
                            margin: EdgeInsets.only(top: 100, bottom:20),
                            child: Image.network(
                              imageURL,
                              fit: BoxFit.cover,
                            ),
                          ),
                          subtitle: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                icon: isFavoriteList[index - 1]
                                ? Icon(Icons.favorite, color: Colors.red, size: 40)
                                : Icon(Icons.favorite_border, color: Colors.grey.shade600, size: 40),
                                onPressed: () {
                                  setState(() {
                                    isFavoriteList[index - 1] = !isFavoriteList[index -1];
                                    if (isFavoriteList[index - 1]) {
                                      favoriteImageUrls.add(imageURL);
                                    }
                                    else{
                                      favoriteImageUrls.remove(imageURL);
                                    }
                                  });
                                },
                              ),

                              Container(
                                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 30),
                                //margin: EdgeInsets.symmetric(horizontal: ),
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade600,
                                  borderRadius: BorderRadius.circular(10)  
                                ),
                                child: InkWell(
                                  onTap: () {
                                    _downloadImage(imageURL);
                                  },
                                  child: Text(
                                    'Download',
                                    style: TextStyle(
                                      color: Colors.white, 
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold
                                    ),
                                  )
                                )
                              )
                            ],
                          ),
                      ),
                      SizedBox(height: 300,)
                    ],
                  );
                },
            );
          }
        },
      ),
    );
  }
}