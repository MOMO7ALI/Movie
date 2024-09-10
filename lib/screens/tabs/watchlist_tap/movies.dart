class Movie {
  static const String collectionName = 'Movie';
  String? id;
  String? title;
  String? posterUrl;
  String? releaseDate;

  Movie({
    required this.id,
    this.title,
    this.posterUrl,
    this.releaseDate,
  });

  Movie.fromFireStore(Map<String, dynamic> data) {
    id = data['id'];
    title = data['title'];
    posterUrl = data['posterUrl'];
    releaseDate = data['releaseDate'];
  }

  Map<String, dynamic> toFireStore() {
    return {
      'id': id,
      'title': title,
      'posterUrl': posterUrl,
      'releaseDate': releaseDate,
    };
  }
}
