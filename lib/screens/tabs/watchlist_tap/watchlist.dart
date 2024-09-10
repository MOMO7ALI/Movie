import 'package:flutter/material.dart';
import 'package:movies_app/screens/tabs/watchlist_tap/watchlist_movies.dart';
import 'package:movies_app/themeing/app_theme.dart';
import 'hiveUtils.dart';
import 'movie.dart';

class WatchListScreen extends StatefulWidget {
  @override
  State<WatchListScreen> createState() => _WatchListScreenState();
}

class _WatchListScreenState extends State<WatchListScreen> {
  late Future<List<Movie>> _movieListFuture;

  @override
  void initState() {
    super.initState();
    _movieListFuture = HiveUtils.getMoviesFromHive();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.black,
      child: FutureBuilder<List<Movie>>(
        future: _movieListFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator(color: AppTheme.gold));
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}', style: TextStyle(color: Colors.red)));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No movies found.'));
          } else {
            List<Movie> movieList = snapshot.data!;

            return ListView.separated(
              itemBuilder: (context, index) {
                return WatchListMovies(id: movieList[index].id.toString());
              },
              itemCount: movieList.length,
              separatorBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Divider(color: AppTheme.darkGrey, thickness: 1, height: 1),
                );
              },
            );
          }
        },
      ),
    );
  }
}
