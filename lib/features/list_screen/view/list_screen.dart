import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_application_main/features/bottom_nav_bar/view/bottom_navbar.dart';
import 'package:recipe_application_main/features/list_screen/viewmodel/listt_bloc.dart';
import 'package:recipe_application_main/features/list_screen/viewmodel/listt_event.dart';
import 'package:recipe_application_main/features/list_screen/viewmodel/listt_state.dart';
import 'package:recipe_application_main/features/search_screen/view/search_screen.dart';
import 'package:recipe_application_main/global_widget/reusable_button.dart';
import 'package:recipe_application_main/utils/constants/color_constants.dart';

class ListScreen extends StatelessWidget {
  const ListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ListtBloc(),
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            String newItem = '';
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  backgroundColor: ColorConstants.bottpink,
                  title: const Text(
                    'Add Item',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  content: TextField(
                    autofocus: true,
                    decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: ColorConstants.lightGrey1),
                      ),
                      hintText: 'Enter item (eg: 1 item Egg)',
                    ),
                    onChanged: (value) {
                      newItem = value;
                    },
                  ),
                  actions: [
                    ReusableButton(
                      backgroundColor: ColorConstants.red,
                      textColor: ColorConstants.white,
                      buttonPressed: () {
                        if (newItem.isNotEmpty) {
                          context.read<ListtBloc>().add(AddItem(newItem));
                          Navigator.of(context).pop();
                        }
                      },
                      textname: 'Add',
                    ),
                  ],
                );
              },
            );
          },
          backgroundColor: ColorConstants.red,
          shape: const CircleBorder(),
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
        appBar: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle.dark,
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title: const Text(
            "Shopping List",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          leading: TextButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => BottomNavbar()),
              );
            },
            child: Icon(Icons.arrow_back_ios_new, color: ColorConstants.red),
          ),
        ),
        body: BlocBuilder<ListtBloc, ListState>(
          builder: (context, state) {
            if (state is ListUpdated) {
              if (state.items.isEmpty) {
                return Center(
                  child: Column(
                    children: [
                      const SizedBox(height: 100),
                      Image.asset(
                        "assets/images/list.jpg",
                        width: 200,
                        height: 100,
                      ),
                      const Text(
                        "Your shopping list is empty",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 100,
                        width: 250,
                        child: Text(
                          "Select the ingredients you need from a recipe or add your own",
                          style: TextStyle(fontSize: 20),
                          maxLines: 3,
                          overflow: TextOverflow.visible,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        height: 50,
                        width: 180,
                        decoration: BoxDecoration(
                          color: ColorConstants.red,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SearchScreen(),
                              ),
                            );
                          },
                          child: const Text(
                            "Search Recipes",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }

              return ListView.separated(
                padding: const EdgeInsets.all(12),
                itemCount: state.items.length,
                separatorBuilder: (_, __) => const Divider(),
                itemBuilder: (context, index) {
                  final item = state.items[index];
                  return ListTile(
                    title: Text(
                      item,
                      style: const TextStyle(fontSize: 18),
                    ),
                    trailing: GestureDetector(
                      onTap: () {
                        context.read<ListtBloc>().add(RemoveItem(index));
                      },
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          color: ColorConstants.bottpink,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.remove, color: ColorConstants.red),
                      ),
                    ),
                  );
                },
              );
            }

            // Initial or loading state
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
