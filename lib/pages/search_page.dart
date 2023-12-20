import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'photo_detail_page.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController _searchController = TextEditingController();
  List<String> photoUrls = [];
  bool isSearching = true;

  void _navigateToPhotoDetailPage(String imageURL) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PhotoDetailPage(imageUrl : imageURL),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade200,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: "search for free photos",
                hintStyle: TextStyle(color: Colors.grey.shade600),
                prefixIcon: Icon(Icons.search),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 2),
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade600, width: 2),
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
              ),
              onSubmitted: (value) {
                setState(() {
                  isSearching = true;
                });
                _searchPhotos(value);
              },
            ),

            SizedBox(height: 30),

            Text(
              isSearching
              ?'type something to search'
              : '',
              style: TextStyle(
                color: Colors.grey.shade700,
                fontSize: 20,
              ),
            ),

            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                ),
                itemCount: photoUrls.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: (){
                      _navigateToPhotoDetailPage(photoUrls[index]);
                    },
                    child: Image.network(
                      photoUrls[index],
                      fit: BoxFit.cover,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _searchPhotos(String query, {int page = 1, int perPage = 52}) async {
    final String apiKey = "XxfVKnIPRMGUsiObkSBRh99tbO6xPEtDbtOWq4733lxsfCfRIh7eersO";
    final String apiUrl = "https://api.pexels.com/v1/search";

    try {
      setState(() {
        isSearching = true;
      });
      final response = await http.get(
        Uri.parse("$apiUrl?query=$query&page=$page&per_page=$perPage"),
        headers: {
          "Authorization": apiKey,
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> photos = jsonDecode(response.body)['photos'];
        List<String> urls = [];

        for (var photo in photos) {
          String url = photo['src']['large'];
          urls.add(url);
        }
        
        setState(() {
          photoUrls = urls;
          isSearching = false;
        });
      } else {
        print("Failed to load photos. Status Code: ${response.statusCode}");
      }
    } catch (e) {
      print("An error occurred: $e");
      setState(() {
        isSearching = false;
      });
    }
  }
}
