import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_application_main/features/search_results/view/searchresult_screen.dart';
import 'package:recipe_application_main/features/search_screen/viewmodel/search_bloc.dart';
import 'package:recipe_application_main/global_widget/column_catg_container.dart';
import 'package:recipe_application_main/global_widget/row_ingred_container.dart';
import 'package:recipe_application_main/utils/constants/color_constants.dart';


class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SearchBloc(),
      child: const SearchScreenView(),
    );
  }
}

class SearchScreenView extends StatefulWidget {
  const SearchScreenView({super.key});

  @override
  State<SearchScreenView> createState() => _SearchScreenViewState();
}

class _SearchScreenViewState extends State<SearchScreenView> {
  final TextEditingController searchc = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(statusBarIconBrightness: Brightness.dark),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocBuilder<SearchBloc, SearchState>(
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Search", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28)),
                  const SizedBox(height: 10),
                  TextField(
                    controller: searchc,
                    cursorWidth: 2,
                    cursorColor: ColorConstants.black,
                    onChanged: (value) {
                      context.read<SearchBloc>().add(SearchQueryChanged(value));
                    },
                    decoration: InputDecoration(
                      hintText: "Recipe, ingredient or keyword",
                      hintStyle: TextStyle(color: ColorConstants.grey),
                      prefixIcon: Icon(Icons.search, size: 25, color: ColorConstants.black),
                      fillColor: ColorConstants.white,
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: ColorConstants.white, width: 1),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: ColorConstants.white, width: 1),
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text("Categories", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 6,
                    runSpacing: 4,
                    children: [
                      InkWell(
                        onTap: () {
                          context.read<SearchBloc>().add(CategorySelected("Breakfast"));
                          Navigator.push(context, MaterialPageRoute(builder: (_) => SearchResults()));
                        },
                        child: const ColumnCatgContainer(imagePath: "assets/images/breakfast.png", catgName: "Breakfast"),
                      ),
                      const ColumnCatgContainer(imagePath: "assets/images/lunch.png", catgName: "Lunch"),
                      const ColumnCatgContainer(imagePath: "assets/images/dinner.png", catgName: "Dinner"),
                      const ColumnCatgContainer(imagePath: "assets/images/supper.png", catgName: "Supper"),
                    ],
                  ),
                  const SizedBox(height: 30),
                  pinkLine(),
                  const SizedBox(height: 30),
                  const Text("Ingredients", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                  const SizedBox(height: 20),
                  Wrap(
                    spacing: 2,
                    runSpacing: 4,
                    children: const [
                      RowIngredContainer(imagePath1: "assets/images/chicken.jpg", ingName: "Chicken"),
                      RowIngredContainer(imagePath1: "assets/images/beef.jpg", ingName: "Beef"),
                      RowIngredContainer(imagePath1: "assets/images/lamb.jpg", ingName: "Lamb"),
                      RowIngredContainer(imagePath1: "assets/images/pork.jpg", ingName: "Pork"),
                      RowIngredContainer(imagePath1: "assets/images/seafood.jpg", ingName: "Seafood"),
                      RowIngredContainer(imagePath1: "assets/images/tofu.jpg", ingName: "Tofu"),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Container pinkLine() {
    return Container(
      color: ColorConstants.bottpink,
      height: 1.0,
    );
  }
}
