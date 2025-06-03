import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_application_main/data/dummydb.dart';
import 'package:recipe_application_main/features/recipe_details/viewmodel/bloc/recipedetail_bloc.dart';
import 'package:recipe_application_main/utils/constants/color_constants.dart';

class Ingtab extends StatelessWidget {
  const Ingtab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecipeDetailsBloc, RecipeDetailsState>(
      builder: (context, state) {
        return Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: Dummydb.ingredients.length,
              itemBuilder: (context, index) {
                final isSelected = state.selectedIngredients.contains(index);

                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          context.read<RecipeDetailsBloc>().add(ToggleIngredientSelection(index));
                        },
                        icon: Icon(
                          isSelected ? Icons.check_circle : Icons.add_circle_outline,
                          color: isSelected ? ColorConstants.red : ColorConstants.lightGrey1,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                          decoration: BoxDecoration(
                            border: Border.all(color: ColorConstants.lightGrey1),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(Dummydb.ingredients[index].name, style: const TextStyle(fontSize: 18)),
                              Text(Dummydb.ingredients[index].quantity, style: const TextStyle(color: Colors.grey)),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: TextButton(
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add, color: ColorConstants.red),
                    const SizedBox(width: 10),
                    Text(
                      "Add all to shopping list",
                      style: TextStyle(color: ColorConstants.red, fontSize: 20),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
