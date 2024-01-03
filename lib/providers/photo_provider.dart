
import 'package:flutter/foundation.dart';

class Photo {
  final String imageUrl;

  Photo({required this.imageUrl});
}

class PhotoProvider extends ChangeNotifier {
  List<Photo> _favoritePhotos = [];

  List<Photo> get favoritePhotos => _favoritePhotos;

  // Favori bir fotoğraf olup olmadığını kontrol eden metod
  bool isPhotoFavorite(String imageUrl) {
    return _favoritePhotos.any((photo) => photo.imageUrl == imageUrl);
  }

  // Favori fotoğraf ekleyen metod
  void addFavoritePhoto(Photo photo) {
    _favoritePhotos.add(photo);
    notifyListeners();
  }

  // Favori fotoğrafı kaldıran metod
  void removeFavoritePhoto(String imageUrl) {
    _favoritePhotos.removeWhere((photo) => photo.imageUrl == imageUrl);
    notifyListeners();
  }
}
