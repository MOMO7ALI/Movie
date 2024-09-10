import 'package:flutter/material.dart';
import 'package:movies_app/model/by_id_movies_response.dart';
import 'package:movies_app/screens/tabs/watchlist_tap/watchlist_movies.dart';
import 'package:movies_app/themeing/app_theme.dart';
import 'hiveUtils.dart';
import 'movie.dart';

class WatchListScreen extends StatefulWidget {
  @override
  State<WatchListScreen> createState() => _WatchListScreenState();
}

class _WatchListScreenState extends State<WatchListScreen> {
  late Future<MoviesById?> _movieFuture;

  @override
  void initState() {
    super.initState();
    _movieFuture = Hiveutils.getMovieData(); // Expecting a single movie
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.black,
      child: FutureBuilder<MoviesById?>(
        future: _movieFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator(color: AppTheme.gold));
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}', style: TextStyle(color: Colors.red)));
          } else if (!snapshot.hasData || snapshot.data==null) {
            return Center(child: Text('No movies found.'));
          } else {
            final movie = snapshot.data!;


            return  WatchListMovies(id: movie.id.toString());
          }
        },
      ),
    );
  }
}
