import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:recipe_application_main/features/search_results/viewmodel/bloc/searchres_bloc.dart';
import 'package:recipe_application_main/features/recipe_details/view/recipe_details.dart';
import 'package:recipe_application_main/utils/constants/color_constants.dart';

class SearchResults extends StatelessWidget {
  const SearchResults({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SearchResultsBloc(),
      child: const SearchResultsView(),
    );
  }
}

class SearchResultsView extends StatelessWidget {
  const SearchResultsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: const Text("Search results", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        leadingWidth: 100,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Row(
            children: [
              const SizedBox(width: 20),
              Icon(Icons.arrow_back_ios, color: ColorConstants.red),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<SearchResultsBloc, SearchResultsState>(
          builder: (context, state) {
            return Column(
              children: [
                const SizedBox(height: 10),
                TextField(
                  cursorColor: ColorConstants.black,
                  onChanged: (value) {
                    context.read<SearchResultsBloc>().add(UpdateSearchQuery(value));
                  },
                  decoration: InputDecoration(
                    hintText: "Recipe, ingredient or keyword",
                    hintStyle: TextStyle(color: ColorConstants.grey),
                    prefixIcon: Icon(Icons.search, color: ColorConstants.black),
                    suffixIcon: Icon(Icons.cancel, color: ColorConstants.black),
                    fillColor: ColorConstants.white,
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: ColorConstants.white),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: ColorConstants.white),
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "${state.filteredItems.length} recipes",
                    style: const TextStyle(color: Colors.black38, fontSize: 20),
                  ),
                ),
                const SizedBox(height: 15),
                pinkLine(),
                const SizedBox(height: 10),
                Expanded(
                  child: AlignedGridView.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: 30,
                    crossAxisSpacing: 10,
                    itemCount: state.filteredItems.length,
                    itemBuilder: (context, index) {
                      final item = state.filteredItems[index];
                      return Stack(
                        clipBehavior: Clip.none,
                        children: [
                          InkWell(
                            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const RecipeDetails())),
                            child: Container(
                              margin: const EdgeInsets.only(top: 40),
                              padding: const EdgeInsets.only(top: 60, left: 10, right: 10, bottom: 30),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: const [
                                  BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(2, 2)),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const SizedBox(height: 40),
                                  SizedBox(
                                    height: 35,
                                    child: Text(
                                      item.name,
                                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                                      textAlign: TextAlign.center,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: List.generate(5, (i) {
                                      return Icon(
                                        i < item.rating!.floor() ? Icons.star : Icons.star_border,
                                        size: 14,
                                        color: ColorConstants.yellow,
                                      );
                                    }),
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.access_time, size: 14, color: ColorConstants.red),
                                      const SizedBox(width: 4),
                                      Text(item.time, style: const TextStyle(fontSize: 12)),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: -12,
                            left: 0,
                            right: 0,
                            child: GestureDetector(
                              onTap: () {
                                context.read<SearchResultsBloc>().add(ToggleLike(item));
                              },
                              child: Container(
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: ColorConstants.yellow,
                                ),
                                child: Icon(
                                  item.isLiked ? Icons.favorite : Icons.favorite_border,
                                  color: item.isLiked ? Colors.red : Colors.yellow,
                                  size: 17,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 0,
                            left: 0,
                            right: 0,
                            child: Align(
                              alignment: Alignment.topCenter,
                              child: CircleAvatar(
                                radius: 60,
                                backgroundColor: Colors.white,
                                backgroundImage: AssetImage(item.imagePath),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            );
          },
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
