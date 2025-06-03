import 'package:flutter/material.dart';
import 'package:recipe_application_main/features/favorite_screen/view/favorite_screen.dart';
import 'package:recipe_application_main/features/home/view/home_screen.dart';
import 'package:recipe_application_main/features/list_screen/view/list_screen.dart';
import 'package:recipe_application_main/features/profile_screen/view/profile_screen.dart';

class BottomNavModel {
  static const List<Widget> screens = [
    HomeScreen(),
    FavoriteScreen(),
    ListScreen(),
    ProfileScreen(),
  ];
}
