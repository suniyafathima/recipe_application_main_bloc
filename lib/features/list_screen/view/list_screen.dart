import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_application_main/Repository/data/dummydb.dart';
import 'package:recipe_application_main/features/list_screen/viewmodel/listt_bloc.dart';
import 'package:recipe_application_main/features/list_screen/viewmodel/listt_event.dart';
import 'package:recipe_application_main/features/list_screen/viewmodel/listt_state.dart';
import 'package:recipe_application_main/features/search_screen/view/search_screen.dart';
import 'package:recipe_application_main/global_widget/reusable_button.dart';
import 'package:recipe_application_main/utils/constants/color_constants.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({super.key});

  @override
  State<ListScreen> createState() => ListScreenState();
}

class ListScreenState extends State<ListScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ListBloc>().add(LoadList(Dummydb.ingredients));
  }

  void showAddDialog() {
    String newItem = '';
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add Item', style: TextStyle(fontWeight: FontWeight.bold)),
          content: TextField(
            autofocus: true,
            decoration: InputDecoration(
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: ColorConstants.lightGrey1),
              ),
              hintText: 'Enter item (e.g: 1 item Egg)',
            ),
            onChanged: (value) => newItem = value,
          ),
          actions: [
            ReusableButton(
              backgroundColor: ColorConstants.red,
              textColor: ColorConstants.white,
              textname: 'Add',
              buttonPressed: () {
                if (newItem.isNotEmpty) {
                  context.read<ListBloc>().add(AddToList(newItem));
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: showAddDialog,
        backgroundColor: ColorConstants.red,
        shape: const CircleBorder(),
        child: const Icon(Icons.add, color: Colors.white),
      ),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: const Text(
          "Shopping List",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        leading: Icon(Icons.arrow_back_ios_new, color: ColorConstants.red),
      ),
      body: BlocBuilder<ListBloc, ListState>(
        builder: (context, state) {
          if (state is LoadedState) {
            final addedItems = List<String>.from(state.addedItems);
            final ingredients = state.ingredients;

            if (!addedItems.contains("1 item Onion")) {
              addedItems.insert(0, "1 item Onion");
            }

            if (addedItems.isEmpty && ingredients.isEmpty) {
              return Center(
                child: Column(
                  children: [
                    const SizedBox(height: 100),
                    Image.asset("assets/images/list.jpg", width: 200, height: 100),
                    const Text(
                      "Your shopping list is empty",
                      style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
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
                            MaterialPageRoute(builder: (context) => const SearchScreen()),
                          );
                        },
                        child: const Text("Search Recipes", style: TextStyle(color: Colors.white, fontSize: 20)),
                      ),
                    ),
                  ],
                ),
              );
            }

            return SingleChildScrollView(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  const SizedBox(height: 25),

                  // Add Items Section
                  Container(
                    decoration: BoxDecoration(
                      color: ColorConstants.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(12),
                          child: Row(
                            children: [
                              const SizedBox(width: 10),
                              const Text("Add Items", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                              const Spacer(),
                           PopupMenuButton(
                              icon: Icon(Icons.more_vert, color: ColorConstants.red),
                               color: ColorConstants.bottpink,
                               shape: RoundedRectangleBorder(
                               borderRadius: BorderRadius.circular(10),
                                ),
                              onSelected: (result) {
                              if (result == 'clear') {
                              context.read<ListBloc>().add(ClearList());
                             }
                            },
                             itemBuilder: (context) => [
                                 PopupMenuItem(
                                    value: 'clear',
                                    child: Text(
                                    'Clear All',
                                     style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black,
                                    ),
                                   ),
                                  ),
                                ],
                              ),
                           ],
                          ),
                        ),
                      Padding(
                           padding: const EdgeInsets.only(left: 10,right: 10),
                           child: Divider(
                           thickness: 1,
                           color: ColorConstants.lightGrey1,
                            ),
                         ),
                       ListTile(
                         title: Text(
                          "Onion",
                          style: TextStyle(fontSize: 18),
                          textAlign: TextAlign.start,
                           ),
                         trailing: GestureDetector(
                          onTap: () {
      
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
                    ) ,],
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Ingredients Section
                  if (ingredients.isNotEmpty)
                    Container(
                      decoration: BoxDecoration(
                        color: ColorConstants.white,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(12),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 20,
                                  backgroundColor: ColorConstants.lightred,
                                  backgroundImage: const AssetImage("assets/images/noodlessp.png"),
                                ),
                                const SizedBox(width: 10),
                                const Text("Prawn noodles", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                                const Spacer(),
                                Icon(Icons.more_vert, color: ColorConstants.red),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Divider(thickness: 1, color: ColorConstants.lightGrey1),
                          ),
                          Column(
                            children: [
                              for (var ingredient in ingredients)
                                ListTile(
                                  title: Row(
                                    children: [
                                      Text(
                                        ingredient.quantity,
                                        style: const TextStyle(color: Colors.grey, fontSize: 18),
                                      ),
                                      const SizedBox(width: 10),
                                      Text(
                                        ingredient.name,
                                        style: const TextStyle(fontSize: 18),
                                      ),
                                    ],
                                  ),
                                  trailing: Container(
                                    width: 30,
                                    height: 30,
                                    decoration: BoxDecoration(
                                      color: ColorConstants.bottpink,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(Icons.remove, color: ColorConstants.red),
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            );
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
