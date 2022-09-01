import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movie_app/src/core/assets/icons.dart';
import 'package:movie_app/src/core/styles/color.dart';
import 'package:movie_app/src/ui/screens/movies/screens/movies_screens_copy.dart';
import 'package:movie_app/src/ui/screens/scoket_screen.dart';

final numberProvider = Provider<int>((ref) => 24);

class DashboardView extends StatefulWidget {
  const DashboardView({Key? key}) : super(key: key);

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  int _selectedIndex = 0;

  static const List<Widget> _screens = <Widget>[
    MoviesScreenCopy(),
    MoviesScreenCopy(),
    SocketScreen(),
    MoviesScreenCopy(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _labelIcon(String icon, {bool isActive = false}) {
    if (isActive) {
      return SvgPicture.asset(icon, color: AppColors.blue);
    }

    return SvgPicture.asset(
      icon,
      color: Colors.white,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppColors.primary,
        selectedItemColor: AppColors.blue,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: _labelIcon(AppIcons.home),
            activeIcon: _labelIcon(AppIcons.home, isActive: true),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: _labelIcon(AppIcons.cup),
            activeIcon: _labelIcon(AppIcons.cup, isActive: true),
            label: 'Movies',
          ),
          BottomNavigationBarItem(
            icon: _labelIcon(AppIcons.boxOffice),
            activeIcon: _labelIcon(AppIcons.boxOffice, isActive: true),
            label: 'Box Office',
          ),
          BottomNavigationBarItem(
            icon: _labelIcon(AppIcons.chart),
            activeIcon: _labelIcon(AppIcons.chart, isActive: true),
            label: 'Chart',
          ),
        ],
      ),
    );
  }
}
