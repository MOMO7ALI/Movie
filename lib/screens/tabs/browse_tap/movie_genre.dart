import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/apis/api_manager.dart';
import 'package:movies_app/screens/tabs/browse_tap/browse.dart';
import 'package:movies_app/themeing/app_theme.dart';

import '../../../model/browse_genre_response.dart';
import '../../../model/movies_by_genre_response.dart';
import 'browse_cubit.dart';
import 'movie_genre_item.dart';

class MoviesByGenre extends StatefulWidget {
  final Genres? genre;

  MoviesByGenre({required this.genre});

  @override
  State<MoviesByGenre> createState() => _MoviesByGenreState();
}

class _MoviesByGenreState extends State<MoviesByGenre> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BrowseCubit, BrowseState>(
      listener: (context, state) {
        if (state is BrowseBackToCategories) {
          Navigator.pop;
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppTheme.black,
          appBar: AppBar(
            backgroundColor: AppTheme.black,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: AppTheme.lighterGrey),
              onPressed: () {
                context.read<BrowseCubit>().navigateBackToCategories();
              },
            ),
            title: Text(
              widget.genre?.name ?? 'Movies',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          body: FutureBuilder<MoviesByGenreResponse>(
            future: ApiManager.getMoviesByGenre(widget.genre?.id.toString() ?? ''),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(color: AppTheme.gold),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text(
                    'Error: ${snapshot.error}',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                );
              } else if (snapshot.hasData) {
                final movies = snapshot.data!.results ?? [];
                return ListView.separated(
                  itemBuilder: (context, index) {
                    return MovieGenreItem(movie: movies[index]);
                  },
                  itemCount: movies.length,
                  separatorBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Divider(
                        color: AppTheme.darkGrey,
                        thickness: 1,
                      ),
                    );
                  },
                );
              } else {
                return Center(
                  child: Text('No movies found', style: Theme.of(context).textTheme.bodyMedium),
                );
              }
            },
          ),
        );
      },
    );
  }
}
