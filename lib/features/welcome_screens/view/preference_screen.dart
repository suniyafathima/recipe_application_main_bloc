import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_application_main/features/welcome_screens/viewmodel/bloc/welcomebloc/welcome_bloc.dart';
import 'package:recipe_application_main/utils/constants/color_constants.dart';
import 'package:recipe_application_main/global_widget/reusable_button.dart';

class PreferenceScreen extends StatelessWidget {
  final PageController controller;
  final List<String> prefDiets = [
    'Vegetarian', 'Spicy Junk Food', 'Sweets', 'Keto',
    'Raw Foodist', 'Beaf', 'Vegan', 'Gluten'
  ];
  final TextEditingController dietController = TextEditingController();

  PreferenceScreen({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => WelcomeBloc(),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          systemOverlayStyle: SystemUiOverlayStyle.dark,
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Skip", style: TextStyle(color: ColorConstants.red)),
            ),
          ],
        ),
        body: SafeArea(
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: BlocBuilder<WelcomeBloc, WelcomeState>(
                builder: (context, state) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Do you follow any diets?",
                          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                      SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Radio<bool>(
                            activeColor: ColorConstants.red,
                            value: false,
                            groupValue: state.hasDiet,
                            onChanged: (val) =>
                                context.read<WelcomeBloc>().add(ToggleHasDiet(val!)),
                          ),
                          Text("No"),
                          Radio<bool>(
                            activeColor: ColorConstants.red,
                            value: true,
                            groupValue: state.hasDiet,
                            onChanged: (val) =>
                                context.read<WelcomeBloc>().add(ToggleHasDiet(val!)),
                          ),
                          Text("Yes"),
                        ],
                      ),
                      SizedBox(height: 15),
                      buildChipSection(context, state),
                      SizedBox(height: 20),
                      buildAddDietSection(context, state),
                      SizedBox(height: 130),
                      SizedBox(
                        width: double.infinity,
                        child: ReusableButton(
                          textColor: ColorConstants.white,
                          backgroundColor: ColorConstants.red,
                          buttonPressed: () => controller.jumpToPage(2),
                          textname: "Next",
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildChipSection(BuildContext context, WelcomeState state) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
      child: Wrap(
        spacing: 8,
        children: prefDiets.map((diet) {
          final isSelected = state.selectedDiets.contains(diet);
          return ChoiceChip(
            label: Text(diet),
            selected: isSelected,
            selectedColor: Colors.red,
            labelStyle: TextStyle(color: isSelected ? Colors.white : Colors.black),
            onSelected: (_) =>
                context.read<WelcomeBloc>().add(ToggleDietSelection(diet)),
          );
        }).toList(),
      ),
    );
  }

  Widget buildAddDietSection(BuildContext context, WelcomeState state) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Add Diet", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: dietController,
                  decoration: InputDecoration(
                    hintText: "",
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: ColorConstants.lightGrey1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: ColorConstants.lightGrey1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  ),
                ),
              ),
              SizedBox(width: 8),
              Container(
                decoration: BoxDecoration(
                  color: ColorConstants.yellow,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    final input = dietController.text.trim();
                    if (input.isNotEmpty) {
                      context.read<WelcomeBloc>().add(AddCustomDiet(input));
                      dietController.clear();
                    }
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Wrap(
            spacing: 8,
            children: state.customDiets.map((diet) {
              return Chip(
                label: Text(diet),
                onDeleted: () =>
                    context.read<WelcomeBloc>().add(RemoveCustomDiet(diet)),
              );
            }).toList(),
          )
        ],
      ),
    );
  }
}
