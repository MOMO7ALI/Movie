import 'package:hive/hive.dart';

import 'movie.dart';

class HiveUtils {
  static Box<Movie> getMovieBox() {
    return Hive.box<Movie>('movies'); // Ensure this matches the box name
  }

  static Future<void> addMovieToHive(String id) async {
    var box = getMovieBox();
    var movie = Movie(id: id);
    await box.add(movie); // Or use box.put(id, movie) for specific keys
  }

  static Future<List<Movie>> getMoviesFromHive() async {
    var box = getMovieBox();
    return box.values.toList();
  }
}
