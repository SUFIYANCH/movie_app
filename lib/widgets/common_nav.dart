import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app/providers/provider.dart';
import 'package:movie_app/screens/home_page.dart';
import 'package:movie_app/screens/language_screen.dart';
import 'package:movie_app/screens/profile_page.dart';
import 'package:movie_app/screens/search_page.dart';

class CommonNav extends ConsumerStatefulWidget {
  const CommonNav({super.key});

  @override
  ConsumerState<CommonNav> createState() => _CommonNavState();
}

class _CommonNavState extends ConsumerState<CommonNav> {
  List<Widget> navPage = [
    const HomePage(),
    const SearchPage(),
    const LanguageScreen(),
    const ProfilePage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navPage[ref.watch(navigationIndexProvider)],
      extendBody: true,
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.black26,
          unselectedItemColor: Colors.grey[400],
          selectedItemColor: Colors.white,
          selectedIconTheme: const IconThemeData(color: Colors.white),
          currentIndex: ref.watch(navigationIndexProvider),
          onTap: (value) {
            ref.read(navigationIndexProvider.notifier).state = value;
          },
          items: const [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                  size: 28,
                ),
                label: 'Home',
                backgroundColor: Colors.black26),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.search,
                size: 28,
              ),
              label: 'Search',
            ),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.language,
                  size: 28,
                ),
                label: 'Language'),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
                size: 28,
              ),
              label: 'Profile',
            ),
          ]),
    );
  }
}
