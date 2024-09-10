import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:movies_app/screens/tabs/home_tab/movie_screen.dart';
import 'package:movies_app/themeing/app_theme.dart';
import 'package:movies_app/screens/main_screen.dart';

import 'screens/tabs/watchlist_tap/movie.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(MovieAdapter());
  await Hive.openBox<Movie>('movies');

  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,

      initialRoute: MainScreen.routeName,
      routes: {
        MainScreen.routeName: (context) => MainScreen(),
        MovieName.routeName:(context)=>MovieName(),
      },

      theme: AppTheme.appTheme,

    );
  }
}

