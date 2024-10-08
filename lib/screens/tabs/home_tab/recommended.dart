import 'package:flutter/material.dart';
import 'package:movies_app/screens/tabs/home_tab/movie_screen.dart';
import '../../../apis/api_manager.dart';
import '../../../model/top_rated_movies_response.dart';
import '../../../themeing/app_theme.dart';
import 'movie_carousel_item.dart';
import 'movie_item.dart';

class Recomended extends StatelessWidget {
  var results;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      height: MediaQuery.of(context).size.height * 0.25,
      width: double.infinity,
      color: AppTheme.darkGrey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Recommended',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          SizedBox(
            height: 10,
          ),
          FutureBuilder<TopRatedMoviesResponse>(
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                    child: CircularProgressIndicator(color: AppTheme.gold));
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                results = snapshot.data!.results;
                return Expanded(
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 5, right: 5),
                        child: InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, MovieName.routeName,
                                arguments: MovieData(
                                  id: results![index].id.toString(),
                                ));

                          },

                          child: MovieItem(
                            movie: results![index],
                          ),
                        ),
                      );
                    },
                    itemCount: results!.length,
                    scrollDirection: Axis.horizontal,
                  ),
                );
              }
            },
            future: ApiManager.getTopRatedMovies(),
          )
        ],
      ),
    );
  }
}
