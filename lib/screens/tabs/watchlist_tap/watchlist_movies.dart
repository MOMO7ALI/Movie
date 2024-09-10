import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../search_tap/movie_search_item.dart';
import 'movie.dart';

class WatchListMovies extends StatelessWidget {
  final String id;

  WatchListMovies({required this.id});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Movie>(
      future: getMovieById(id), // Implement this function to retrieve movie from Hive
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData) {
          return Center(child: Text('Movie not found.'));
        } else {
          final movie = snapshot.data!;
          return MovieSearchItem(movie: movie);
        }
      },
    );
  }

  Future<Movie> getMovieById(String id) async {
    var box = Hive.box<Movie>('movies');
    return box.values.firstWhere((movie) => movie.id == id, orElse: () => throw Exception('Movie not found'));
  }
}
