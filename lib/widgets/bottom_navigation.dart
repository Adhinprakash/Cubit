import 'package:cubit/features/Home/view/screen_home.dart';
import 'package:cubit/features/cart/view/screen_cart.dart';
import 'package:cubit/features/favorites/view/screen_fav.dart';
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
    ScreenFav(),
    ScreenProfile(),


  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(body:_screens[_currrentindex] ,bottomNavigationBar: BottomNavigationBar(
      unselectedItemColor: Colors.black,
    selectedItemColor: Colors.green,

       currentIndex: _currrentindex,
       onTap: (value) {
        setState(() {
                   _currrentindex=value;

        });
       },
      items: [
      BottomNavigationBarItem(icon: Icon(Icons.home_rounded),label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.favorite_border),label: "Favorites"),

            BottomNavigationBarItem(icon: Icon(Icons.person_outline_sharp,),label: "Profile",)

    ]),);
  }
}