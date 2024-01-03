
import 'package:flutter/foundation.dart';

class Photo {
  final String imageUrl;

  Photo({required this.imageUrl});
}

class PhotoProvider extends ChangeNotifier {
  List<Photo> _favoritePhotos = [];

  List<Photo> get favoritePhotos => _favoritePhotos;

  bool isPhotoFavorite(String imageUrl) {
    return _favoritePhotos.any((photo) => photo.imageUrl == imageUrl);
  }

  void addFavoritePhoto(Photo photo) {
    _favoritePhotos.add(photo);
    notifyListeners();
  }

  void removeFavoritePhoto(String imageUrl) {
    _favoritePhotos.removeWhere((photo) => photo.imageUrl == imageUrl);
    notifyListeners();
  }
}
