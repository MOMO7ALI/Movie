import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:movies_app/screens/tabs/watchlist_tap/hiveUtils.dart';
import '../../../model/by_id_movies_response.dart';
import '../search_tap/movie_search_item.dart';
import 'movie.dart';

class WatchListMovies extends StatelessWidget {
  final String id;

  WatchListMovies({required this.id});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<MoviesById?>(
      future: getMoviesData(id),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data == null) {
          return Center(child: Text('Movie not found.'));
        } else {
          final movie = snapshot.data!;
          return MovieSearchItem(movie: movie);
        }
      },
    );
  }

  static Future<MoviesById?> getMoviesData(String id) async {
    // Open the Hive box if it is not already opened
    var box = await Hive.openBox<MoviesById>('moviesBox');

    // Retrieve the movie from Hive by its ID
    return box.get(id);
  }
}
