import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_application_main/features/bottom_nav_bar/model/bottom_navmodel.dart';
import 'package:recipe_application_main/features/bottom_nav_bar/viewmodel/bloc/bottom_navbar_bloc.dart';
import 'package:recipe_application_main/features/bottom_nav_bar/viewmodel/bloc/bottom_navbar_event.dart';
import 'package:recipe_application_main/features/bottom_nav_bar/viewmodel/bloc/bottom_navbar_state.dart';
import 'package:recipe_application_main/utils/constants/color_constants.dart';

class BottomNavbar extends StatelessWidget {
  const BottomNavbar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => BottomNavBloc(),
      child: Scaffold(
        body: BlocBuilder<BottomNavBloc, BottomNavState>(
          builder: (context, state) {
            final currentIndex = state.selectedIndex;
            return BottomNavModel.screens[currentIndex];
          },
        ),
        bottomNavigationBar: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          child: BlocBuilder<BottomNavBloc, BottomNavState>(
            builder: (context, state) {
              final selectedIndex = state.selectedIndex;

              return BottomNavigationBar(
                elevation: 0,
                showSelectedLabels: false,
                showUnselectedLabels: false,
                type: BottomNavigationBarType.fixed,
                currentIndex: selectedIndex,
                onTap: (value) {
                  context.read<BottomNavBloc>().add(BottomNavItemSelected(value));
                },
                items: [
                  BottomNavigationBarItem(
                    icon: selectedIndex == 0
                        ? Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 8),
                            decoration: BoxDecoration(
                              color: ColorConstants.bottpink,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: const [
                                Icon(Icons.home, color: Colors.red),
                                SizedBox(width: 5),
                                Text("Home", style: TextStyle(color: Colors.red)),
                              ],
                            ),
                          )
                        : const Icon(Icons.home, color: Colors.grey),
                    label: '',
                  ),
                  BottomNavigationBarItem(
                    icon: selectedIndex == 1
                        ? Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 8),
                            decoration: BoxDecoration(
                              color: ColorConstants.bottpink,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: const [
                                Icon(Icons.favorite, color: Colors.red),
                                SizedBox(width: 5),
                                Text("Favorite", style: TextStyle(color: Colors.red)),
                              ],
                            ),
                          )
                        : const Icon(Icons.favorite, color: Colors.grey),
                    label: '',
                  ),
                  BottomNavigationBarItem(
                    icon: selectedIndex == 2
                        ? Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 8),
                            decoration: BoxDecoration(
                              color: ColorConstants.bottpink,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: const [
                                Icon(Icons.list, color: Colors.red),
                                SizedBox(width: 5),
                                Text("List", style: TextStyle(color: Colors.red)),
                              ],
                            ),
                          )
                        : const Icon(Icons.list, color: Colors.grey),
                    label: '',
                  ),
                  BottomNavigationBarItem(
                    icon: selectedIndex == 3
                        ? Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 8),
                            decoration: BoxDecoration(
                              color: ColorConstants.bottpink,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: const [
                                Icon(Icons.person, color: Colors.red),
                                SizedBox(width: 5),
                                Text("Profile", style: TextStyle(color: Colors.red)),
                              ],
                            ),
                          )
                        : const Icon(Icons.person, color: Colors.grey),
                    label: '',
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
