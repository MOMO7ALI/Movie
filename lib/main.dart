import 'package:flutter/material.dart';
import 'package:movies_app/themeing/app_theme.dart';
import 'package:movies_app/screens/main_screen.dart';

void main(){
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
      },

      theme: AppTheme.appTheme,

    );
  }
}

