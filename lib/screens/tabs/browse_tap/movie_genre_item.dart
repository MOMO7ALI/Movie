import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/screens/tabs/home_tab/image.dart';

import '../../../model/movies_by_genre_response.dart';
import '../home_tab/movie_carousel_item.dart';
import '../home_tab/movie_screen.dart';

class MovieGenreItem extends StatelessWidget {
  final Results? movie; // Make movie parameter optional

  MovieGenreItem({this.movie}); // Constructor with optional parameter
  static const String routeName = 'movieGenre';

  @override
  Widget build(BuildContext context) {
    // If movie is null, use default values
    final Results movieData = movie ??
        Results(
          title: 'No Title',
          releaseDate: 'No Release Date',
          originalLanguage: 'No Language',
          posterPath: '',
        );

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        child: Column(
          children: [
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, MovieName.routeName,
                    arguments: MovieData(
                      id: movie!.id.toString(),
                    ));
              },
              child: Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.3,
                    height: MediaQuery.of(context).size.height * 0.2,
                    child: CachedNetworkImage(
                      imageUrl: FixImage.fixImage(movieData.posterPath ?? ""),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: 15.0),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Text(
                            movieData.title ?? "",
                            style: Theme.of(context).textTheme.titleLarge,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Text(
                            movieData.releaseDate ?? "",
                            style: Theme.of(context).textTheme.titleMedium,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Text(
                            movieData.originalLanguage ?? "",
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(fontSize: 16),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
