import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> fetchData()async {

  final String apiKey = 'XxfVKnIPRMGUsiObkSBRh99tbO6xPEtDbtOWq4733lxsfCfRIh7eersO'; // Kendi Pexels API anahtarınızı buraya ekleyin
  final String baseUrl = 'https://api.pexels.com/v1';
  final String endpoint = '/curated?page=5&per_page=20';
  final String apiUrl = '$baseUrl$endpoint';

  final http.Response response = await http.get(
    Uri.parse(apiUrl),
    headers: {'Authorization': apiKey},
  );


  print('Rate Limit Limit: ${response.headers['x-ratelimit-limit']}');
  print('Rate Limit Remaining: ${response.headers['x-ratelimit-remaining']}');
  print('Rate Limit Reset: ${response.headers['x-ratelimit-reset']}');


  if (response.statusCode == 200) {
    // Başarılı bir şekilde API'den veri alındı.
    return json.decode(response.body);
    
  } else {
    // Hata durumunda

    throw Exception('API isteği başarısız : $response.statusCode');

    
  }
}
