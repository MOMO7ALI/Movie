import 'package:flutter/material.dart';
import '../../../apis/api_manager.dart';
import '../../../model/search_movies_response.dart';
import '../../../themeing/app_theme.dart';
import '../home_tab/movie_carousel_item.dart';
import '../home_tab/movie_screen.dart';
import 'movie_search_item.dart';

class SearchScreen extends StatefulWidget {
  @override
  State<SearchScreen> createState() => _SearchScreenState();
  var searchResults = [];
}

class _SearchScreenState extends State<SearchScreen> {
  String query = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.black,
      child: SafeArea(
        child: Container(
          height: double.infinity,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextField(
                  onChanged: (value) {
                    query = value;
                    setState(() {});
                  },
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: AppTheme.darkGrey,
                    hintText: 'Search',
                    hintStyle: TextStyle(color: AppTheme.lightGrey),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    prefixIcon: Icon(
                      Icons.search,
                      color: AppTheme.lighterGrey,
                    ),
                  ),
                ),
              ),
              query.isEmpty
                  ? Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.27),
                child: Column(
                  children: [
                    Icon(Icons.local_movies,
                        color: AppTheme.lighterGrey,
                        size: MediaQuery.of(context).size.width * 0.35),
                    Text(
                      'No Movies Found',
                      style: Theme.of(context).textTheme.titleLarge,
                    )
                  ],
                ),
              )
                  : FutureBuilder<SearchMoviesResponse>(
                future: ApiManager.getSearchMovies(query),
                builder: (context, snapshot) {
                  if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: AppTheme.gold,
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  } else if (snapshot.hasData) {
                    widget.searchResults = snapshot.data!.results ?? [];

                    if (widget.searchResults.isEmpty) {
                      // If no search results found, show "No Movies Found"
                      return Container(
                        margin: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.27),
                        child: Column(
                          children: [
                            Icon(Icons.local_movies,
                                color: AppTheme.lighterGrey,
                                size: MediaQuery.of(context).size.width * 0.35),
                            Text(
                              'No Movies Found',
                              style: Theme.of(context).textTheme.titleLarge,
                            )
                          ],
                        ),
                      );
                    }

                    // If search results are found, display them
                    return Expanded(
                      child: ListView.separated(
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                MovieName.routeName,
                                arguments: MovieData(
                                  id: widget.searchResults[index]
                                      .id
                                      .toString(),
                                ),
                              );
                            },
                            child: MovieSearchItem(
                              movie: widget.searchResults[index],
                            ),
                          );
                        },
                        itemCount: widget.searchResults.length,
                        separatorBuilder:
                            (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Divider(
                              color: AppTheme.darkGrey,
                              thickness: 1,
                              height: 1,
                            ),
                          );
                        },
                      ),
                    );
                  } else {
                    return Container(
                      margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.27),
                      child: Column(
                        children: [
                          Icon(Icons.local_movies,
                              color: AppTheme.lighterGrey,
                              size: MediaQuery.of(context).size.width * 0.35),
                          Text(
                            'No Movies Found',
                            style: Theme.of(context).textTheme.titleLarge,
                          )
                        ],
                      ),
                    );
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
