import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/screens/tabs/browse_tap/browse.dart';
import 'package:movies_app/screens/tabs/browse_tap/browse_cubit.dart';
import 'package:movies_app/screens/tabs/browse_tap/movie_genre_item.dart';
import 'package:movies_app/screens/tabs/home_tab/movie_screen.dart';
import 'package:movies_app/themeing/app_theme.dart';
import 'package:movies_app/screens/main_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseFirestore.instance.enableNetwork();
  FirebaseFirestore.instance.settings =
      Settings(cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED);


  runApp(
    BlocProvider(
      create: (context) => BrowseCubit(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: MainScreen.routeName,
      routes: {
        MainScreen.routeName: (context) => MainScreen(),
        MovieName.routeName: (context) => MovieName(),
        BrowseScreen.routeName: (context) => BrowseScreen(),
        MovieGenreItem.routeName: (context) =>  MovieGenreItem(),
      },
      theme: AppTheme.appTheme,
    );
  }
}
