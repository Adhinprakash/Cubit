import 'package:cubit/features/Home/view/screen_home.dart';
import 'package:cubit/features/profile/view/screen_profile.dart';
import 'package:flutter/material.dart';

class NavigationPages extends StatefulWidget {
  const NavigationPages({super.key});

  @override
  State<NavigationPages> createState() => _NavigationPagesState();
}

class _NavigationPagesState extends State<NavigationPages> {
int _currrentindex=0;


  List<Widget>_screens=[
    ScreenHome(),
    ScreenProfile()

  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(body:_screens[_currrentindex] ,bottomNavigationBar: BottomNavigationBar(
       currentIndex: _currrentindex,
       onTap: (value) {
        setState(() {
                   _currrentindex=value;

        });
       },
      items: [
      BottomNavigationBarItem(icon: Icon(Icons.home_outlined),label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.person,),label: "Profile")

    ]),);
  }
}