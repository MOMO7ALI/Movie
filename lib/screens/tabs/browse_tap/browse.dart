import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/apis/api_manager.dart';
import 'package:movies_app/model/browse_genre_response.dart';
import 'package:movies_app/themeing/app_theme.dart';

import 'browse_cubit.dart';
import 'category_fragments.dart';
import 'movie_genre.dart';

class BrowseScreen extends StatefulWidget {
  static const String routeName = 'browsTap';

  @override
  State<BrowseScreen> createState() => _BrowseScreenState();
}

class _BrowseScreenState extends State<BrowseScreen> {
  @override
  Widget build(BuildContext context) {
    String language = 'en';
    return Scaffold(
      backgroundColor: AppTheme.black,
      body: SafeArea(
        child: Stack(
          children: [
            FutureBuilder<BrowseGenreResponse>(
              future: ApiManager.getBrowseGenre(language),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: AppTheme.gold,
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  var genreResult = snapshot.data!.genres!;
                  return BlocBuilder<BrowseCubit, BrowseState>(
                    builder: (context, state) {
                      if (state is BrowseGenreSelected) {
                        // If a genre is selected, show the MoviesByGenre screen
                        return MoviesByGenre(genre: state.genre);
                      } else {
                        // If no genre is selected, show the category fragments
                        return CategoryFragments(
                          genresList: genreResult,
                          imagePaths: const [
                            "assets/images/action.jpg",
                            "assets/images/adventure.jpg",
                            "assets/images/animation.jpg",
                            "assets/images/comdey.jpg",
                            "assets/images/crime.png",
                            "assets/images/documentary.jpg",
                            "assets/images/drama.jpg",
                            "assets/images/family.png",
                            "assets/images/fantasy.png",
                            "assets/images/history.jpg",
                            "assets/images/horror.webp",
                            "assets/images/music.png",
                            "assets/images/mystery.webp",
                            "assets/images/romance.jpg",
                            "assets/images/science-fiction.webp",
                            "assets/images/tv-movies.jpg",
                            "assets/images/thriller.jpeg",
                            "assets/images/war.jpg",
                            "assets/images/western.webp",
                          ],
                          onTap: (selectedGenre) {
                            context.read<BrowseCubit>().setSelectedGenre(selectedGenre);
                          },
                        );
                      }
                    },
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
