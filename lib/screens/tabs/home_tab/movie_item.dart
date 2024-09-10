import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../../../themeing/app_theme.dart';
import '../watchlist_tap/MovieAdapter.dart';
import '../watchlist_tap/movie.dart';
import 'image.dart';

class MovieItem extends StatefulWidget {
  var movie;

  MovieItem({required this.movie});

  @override
  State<MovieItem> createState() => _MovieItemState();
}

class _MovieItemState extends State<MovieItem> {
  bool isBookmarked = false;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: CachedNetworkImage(
          imageUrl: FixImage.fixImage(widget.movie.posterPath ?? 'No Image'),
          errorWidget: (context, url, error) => const Center(
              child: Icon(
            Icons.error,
            size: 50,
          )),
          // Changed to BoxFit.cover for aspect ratio
        ),
      ),
      isBookmarked
          ? Icon(
              Icons.bookmark_sharp,
              size: 30,
              color: AppTheme.lightGold,
            )
          : Icon(
              Icons.bookmark_sharp,
              size: 30,
              color: AppTheme.lightGrey,
            ),
      InkWell(
        onTap: () {
          addMovie();
          if (isBookmarked) {
            isBookmarked = false;
          } else {
            isBookmarked = true;
          }
          setState(() {});
        },
        child: Padding(
          padding: const EdgeInsets.all(7),
          child: isBookmarked
              ? const Icon(
                  Icons.check,
                  size: 15,
                  color: Colors.white,
                )
              : const Icon(
                  Icons.add,
                  size: 15,
                  color: Colors.white,
                ),
        ),
      ),
    ]);
  }
  void addMovie() async {
    final movieBox = Hive.box<Movie>('movies');

    // Create a movie instance from the widget data
    Movie movie = Movie(
      id: widget.movie.id,
      title: widget.movie.title,
      posterUrl: widget.movie.posterUrl,
      releaseDate: widget.movie.releaseDate,
    );

    try {
      // Check if the movie already exists in the watchlist
      bool movieExists = movieBox.values.any((existingMovie) => existingMovie.id == movie.id);

      if (movieExists) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${movie.title} is already in your watchlist.'),
          ),
        );
        return;
      }

      // Add the movie to Hive box
      await movieBox.add(movie);

      // Provide feedback to the user
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${movie.title} added to watchlist.'),
        ),
      );

      print('${movie.id} added to watchlist');

      // Optionally update the bookmark status if needed
      setState(() {
        isBookmarked = true;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to add movie to watchlist: $e'),
        ),
      );
      print('Error adding movie to watchlist: $e');
    }
  }








}
