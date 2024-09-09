import 'package:flutter/material.dart';
import 'package:movies_app/screens/tabs/browse_tap/browse.dart';
import 'package:movies_app/screens/tabs/home_tab/home.dart';
import 'package:movies_app/screens/tabs/search_tap/search.dart';
import 'package:movies_app/screens/tabs/watchlist_tap/watchlist.dart';

import '../themeing/app_theme.dart';

class MainScreen extends StatefulWidget {
   MainScreen({super.key});
   static const String routeName = 'MainScreen';

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectedIndex = 0;

  List<Widget> tabs = [
    HomeScreen(),
    SearchScreen(),
    BrowseScreen(),
    WatchListScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold( resizeToAvoidBottomInset: false,
      bottomNavigationBar: Theme(
        data: AppTheme.appTheme.copyWith(canvasColor: AppTheme.lightBlack),
        child: BottomNavigationBar(
          showUnselectedLabels: true,
          selectedFontSize: 13,
          unselectedFontSize: 11,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
            BottomNavigationBarItem(icon: Icon(Icons.movie), label: 'Browse'),
            BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Watchlist'),
          ],
          currentIndex: selectedIndex,
          onTap: (newIndex) {
            selectedIndex = newIndex;
            setState(() {});
          },
        ),
      ),
      body: tabs[selectedIndex],
    );;
  }
}
