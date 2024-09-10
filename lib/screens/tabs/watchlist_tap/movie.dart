import 'package:hive/hive.dart';

part 'movie.g.dart'; // Ensure this is correctly linked

@HiveType(typeId: 0) // Ensure this typeId is unique
class Movie {
  @HiveField(0)
  String? id;

  @HiveField(1)
  String? title;

  @HiveField(2)
  String? posterUrl;

  @HiveField(3)
  String? releaseDate;

  Movie({
    required this.id,
    this.title,
    this.posterUrl,
    this.releaseDate,
  });
}

