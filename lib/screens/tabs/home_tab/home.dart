import 'package:flutter/material.dart';
import 'package:movies_app/screens/tabs/home_tab/new_realeses.dart';
import 'package:movies_app/screens/tabs/home_tab/popular_slider.dart';
import 'package:movies_app/screens/tabs/home_tab/recommended.dart';
import 'package:movies_app/themeing/app_theme.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: AppTheme.black,
        child: Column(
          children: [
            SafeArea(child:Container() ),
            PopularSlider(),
            Padding(padding: EdgeInsets.only(top: 20),
              
              child: NewRealeses(),
            ),
            Padding(padding: EdgeInsets.only(top: 20,bottom: 20),
        
              child: Recomended(),
            ),
            
        
        
        
        
          ],
        ),
      ),
    );
  }
}
