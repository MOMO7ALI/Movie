import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:movies_app/themeing/app_theme.dart';
import '../watchlist_tap/FirerBase_Utils.dart';
import 'image.dart';

class MovieItem extends StatefulWidget {
  final dynamic movie;

  MovieItem({required this.movie});

  @override
  State<MovieItem> createState() => _MovieItemState();
}

class _MovieItemState extends State<MovieItem> {
  bool isBookmarked = false;

  @override
  void initState() {
    super.initState();
    checkIfBookmarked(); // Check bookmark status from Firebase
  }

  // Check if the movie is already bookmarked in Firebase
  void checkIfBookmarked() async {
    bool bookmarked = await FirebaseUtils.isMovieBookmarked(widget.movie.id.toString());
    setState(() {
      isBookmarked = bookmarked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: CachedNetworkImage(
            imageUrl: FixImage.fixImage(widget.movie.posterPath ?? 'No Image'),
            errorWidget: (context, url, error) => const Center(
              child: Icon(
                Icons.error,
                size: 50,
              ),
            ),
            fit: BoxFit.cover,
          ),
        ),
        InkWell(
          onTap: toggleBookmark, // Toggle bookmark on tap
          child: Icon(
            Icons.bookmark_sharp,
            size: 30,
            color: isBookmarked ? AppTheme.lightGold : AppTheme.lightGrey,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(7),
          child: InkWell(
            onTap: toggleBookmark,
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
      ],
    );
  }


  void toggleBookmark() async {
    setState(() {
      isBookmarked = !isBookmarked;
    });

    if (isBookmarked) {
      await FirebaseUtils.addMovieToFirebase(widget.movie.id.toString());
    } else {
      await FirebaseUtils.removeMovieFromFirebase(widget.movie.id.toString());
    }
  }
}
