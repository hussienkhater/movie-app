import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movie_app/core/utils/app_assets.dart';
import 'package:movie_app/core/utils/app_colors.dart';
import 'package:movie_app/feature/test_feature/view/screens/tabs/home_tab.dart';
import 'package:movie_app/feature/test_feature/view/screens/tabs/search_tab.dart';
import 'package:movie_app/feature/test_feature/view/screens/tabs/watch_list_tab.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const routeName = 'HomeScreen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final List<Widget> _tabs = [
    HomeTab(),
    SearchTab(),
    WatchListTab(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _tabs[_currentIndex],
      bottomNavigationBar: Container(
        height: 80,
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(
              color: AppColors.secondary,
              width: 1,
            ),
          ),
        ),
        child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            onTap: (value) {
              _currentIndex = value;
              setState(() {});
            },
            currentIndex: _currentIndex,
            items: [
              BottomNavigationBarItem(
                icon: _currentIndex == 0
                    ? SvgPicture.asset(AppIcons.selectedHome)
                    : SvgPicture.asset(AppIcons.unselectedHome),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: _currentIndex == 1
                    ? SvgPicture.asset(AppIcons.selectedSearch)
                    : SvgPicture.asset(AppIcons.unselectedSearch),
                label: 'Search',
              ),
              BottomNavigationBarItem(
                icon: _currentIndex == 2
                    ? SvgPicture.asset(AppIcons.selectedSave)
                    : SvgPicture.asset(AppIcons.unselectedSave),
                label: 'Watchlist',
              ),
            ]),
      ),
    );
  }
}
