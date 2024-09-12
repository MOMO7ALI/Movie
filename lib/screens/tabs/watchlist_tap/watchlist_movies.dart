import 'package:flutter/material.dart';
import 'package:movies_app/apis/api_manager.dart';
import 'package:movies_app/screens/tabs/home_tab/movie_screen.dart';
import 'package:movies_app/themeing/app_theme.dart';

import '../home_tab/movie_carousel_item.dart';
import '../search_tap/movie_search_item.dart';

class WatchListMovies extends StatefulWidget {
String id;
WatchListMovies({required this.id});

  @override
  State<WatchListMovies> createState() => _WatchListMoviesState();
}

class _WatchListMoviesState extends State<WatchListMovies> {
  @override

  Widget build(BuildContext context) {
    return
      FutureBuilder(builder:(context, snapshot) {
      if(snapshot.connectionState==ConnectionState.waiting){
        return Center(child: CircularProgressIndicator(color: AppTheme.gold,));
      }else if(snapshot.hasError){
        return Text('Error: ${snapshot.error}');
      }else{
        var response=snapshot.data;
        return InkWell(
          onTap: () {

            Navigator.pushNamed(context, MovieName.routeName,arguments: MovieData(id: widget.id)
            );
          },

            child: MovieSearchItem(movie: response!));
      }
    },future: ApiManager.getMoviesById(widget.id), );
  }
}
