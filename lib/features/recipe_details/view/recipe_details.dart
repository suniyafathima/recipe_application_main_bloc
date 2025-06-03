import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_application_main/features/recipe_details/view/tabs/ing_tab.dart';
import 'package:recipe_application_main/features/recipe_details/view/tabs/ins_tab.dart';
import 'package:recipe_application_main/features/recipe_details/view/tabs/review_tab.dart';
import 'package:recipe_application_main/features/recipe_details/viewmodel/bloc/recipedetail_bloc.dart';
import 'package:recipe_application_main/utils/constants/color_constants.dart';

class RecipeDetailsView extends StatelessWidget {
  const RecipeDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => RecipeDetailsBloc(),
      child: const RecipeDetails(),
    );
  }
}

class RecipeDetails extends StatelessWidget {
  const RecipeDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle.dark,
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: ColorConstants.red),
            onPressed: () => Navigator.pop(context),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.favorite_border_outlined, color: ColorConstants.red),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.share, color: ColorConstants.red),
              onPressed: () {},
            ),
          ],
        ),
        body: Stack(
          children: [
            // Background Image
            Container(
              height: screenHeight * 0.4,
              width: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/noodlessp.png"),
                  fit: BoxFit.contain,
                ),
              ),
            ),

            // Draggable Bottom Sheet
            DraggableScrollableSheet(
              initialChildSize: 0.6,
              minChildSize: 0.6,
              maxChildSize: 1.0,
              builder: (context, scrollController) {
                return Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                  ),
                  child: SingleChildScrollView(
                    controller: scrollController,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Container(
                              width: 50,
                              height: 5,
                              margin: const EdgeInsets.only(top: 10, bottom: 12),
                              decoration: BoxDecoration(
                                color: ColorConstants.lightGrey1,
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                          ),
                          const Center(
                            child: Text(
                              "Prawn Noodles",
                              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                children: [
                                  const Text("⭐", style: TextStyle(fontSize: 20)),
                                  Text("4.5", style: TextStyle(fontSize: 20, color: ColorConstants.red)),
                                ],
                              ),
                              Container(width: 2, height: 30, color: ColorConstants.lightGrey1),
                              Column(
                                children: [
                                  const Text("⏰", style: TextStyle(fontSize: 20)),
                                  Text("30 Min", style: TextStyle(fontSize: 20, color: ColorConstants.red)),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          TabBar(
                            indicatorColor: ColorConstants.black,
                            dividerHeight: 0,
                            labelColor: ColorConstants.black,
                            indicator: const UnderlineTabIndicator(
                              borderSide: BorderSide(width: 2),
                              insets: EdgeInsets.symmetric(horizontal: 1),
                            ),
                            labelStyle: const TextStyle(fontSize: 15),
                            tabs: const [
                              Tab(text: "Ingredients"),
                              Tab(text: "Instructions"),
                              Tab(text: "Reviews"),
                            ],
                          ),
                          const SizedBox(height: 16),
                          SizedBox(
                            height: 600,
                            child: TabBarView(
                              physics: const NeverScrollableScrollPhysics(),
                              children: const [
                                Ingtab(),
                                Instab(),
                                Reviewtab(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
