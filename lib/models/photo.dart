class Photo {
  final int id;
  final String title;
  final String imageUrl;
  bool isFavorite;

  Photo({
    required this.id,
    required this.title,
    required this.imageUrl,
    this.isFavorite = false,
  });
}
