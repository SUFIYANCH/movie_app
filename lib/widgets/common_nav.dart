import 'package:flutter/material.dart';
import 'package:movie_app/screens/home_page.dart';

class CommonNav extends StatefulWidget {
  const CommonNav({super.key});

  @override
  State<CommonNav> createState() => _CommonNavState();
}

class _CommonNavState extends State<CommonNav> {
  int selectedTabIndex = 0;

  List<Widget> navPage = [
    const HomePage(),
    const Center(
        child: Text(
      "Second Page",
    )),
    const Center(
        child: Text(
      "Third Page",
    )),
    const Center(
        child: Text(
      "Third Page",
    ))
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navPage[selectedTabIndex],
      extendBody: true,
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.black26,
          unselectedItemColor: Colors.grey[400],
          selectedItemColor: Colors.white,
          selectedIconTheme: const IconThemeData(color: Colors.white),
          currentIndex: selectedTabIndex,
          onTap: (value) {
            setState(() {
              selectedTabIndex = value;
            });
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
                Icons.api_rounded,
                size: 28,
              ),
              label: 'Api',
            ),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.downloading_rounded,
                  size: 28,
                ),
                label: 'Download'),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.movie,
                size: 28,
              ),
              label: 'Movie',
            ),
          ]),
    );
  }
}
