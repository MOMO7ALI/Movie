import 'dart:io';

import 'package:hive/hive.dart';
import 'package:movies_app/screens/tabs/watchlist_tap/movie.dart';
import 'package:path_provider/path_provider.dart';

import '../../../model/by_id_movies_response.dart';

class Hiveutils{

  static Future<void> saveMovies(MoviesById save)async{
    final Directory appDocumentsDir = await getApplicationDocumentsDirectory();
    final collection = await BoxCollection.open(
      'MovieBox',
      {'movies'},
      path: appDocumentsDir.path,

    );
    final movieBox = await collection.openBox<Map>('MovieBox');
    await movieBox.put("movieData",save.toJson());
  }


  static Future<MoviesById> getMovieData()async{
    final Directory appDocumentsDir = await getApplicationDocumentsDirectory();

    final collection = await BoxCollection.open(
      'MovieBox',
      {'movies'},
      path: appDocumentsDir.path,

    );
    final movieBox = await collection.openBox<Map>('MovieBox');
    final movies = await movieBox.get('movieData');

    MoviesById moviesById=MoviesById.fromJson(movies);
    return moviesById;
  }

}








// void addMovie() async {
// final movieBox = Hive.box<Movie>('movies');
//
// // Create a movie instance from the widget data
// Movie movie = Movie(
// id: widget.movie.id,
// title: widget.movie.title,
// posterUrl: widget.movie.posterUrl,
// releaseDate: widget.movie.releaseDate,
// );
//
// try {
// // Check if the movie already exists in the watchlist
// bool movieExists = movieBox.values.any((existingMovie) => existingMovie.id == movie.id);
//
// if (movieExists) {
// ScaffoldMessenger.of(context).showSnackBar(
// SnackBar(
// content: Text('${movie.title} is already in your watchlist.'),
// ),
// );
// return;
// }
//
// // Add the movie to Hive box
// await movieBox.add(movie);
//
// // Provide feedback to the user
// ScaffoldMessenger.of(context).showSnackBar(
// SnackBar(
// content: Text('${movie.title} added to watchlist.'),
// ),
// );
//
// print('${movie.id} added to watchlist');
//
// // Optionally update the bookmark status if needed
// setState(() {
// isBookmarked = true;
// });
// } catch (e) {
// ScaffoldMessenger.of(context).showSnackBar(
// SnackBar(
// content: Text('Failed to add movie to watchlist: $e'),
// ),
// );
// print('Error adding movie to watchlist: $e');
// }
// }