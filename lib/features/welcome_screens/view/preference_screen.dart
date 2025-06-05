import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_application_main/features/welcome_screens/viewmodel/bloc/welcomebloc/welcome_bloc.dart';
import 'package:recipe_application_main/global_widget/reusable_button.dart';
import 'package:recipe_application_main/utils/constants/color_constants.dart';

class PreferenceScreen extends StatelessWidget {
  final PageController controller;

  const PreferenceScreen({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: context.read<WelcomeBloc>(),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          systemOverlayStyle: SystemUiOverlayStyle.dark,
          leading: IconButton(
            onPressed: () {
              controller.jumpToPage(0);
            },
            icon: Icon(Icons.arrow_back_ios, color: ColorConstants.red),
          ),
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Do you follow any diets?",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 15),
                  BlocBuilder<WelcomeBloc, WelcomeState>(
                    builder: (context, state) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Radio(
                            activeColor: ColorConstants.red,
                            value: false,
                            groupValue: state.hasDiet,
                            onChanged: (value) {
                              context
                                  .read<WelcomeBloc>()
                                  .add(ToggleHasDiet(value!));
                            },
                          ),
                          Text("No"),
                          Radio(
                            activeColor: ColorConstants.red,
                            value: true,
                            groupValue: state.hasDiet,
                            onChanged: (value) {
                              context
                                  .read<WelcomeBloc>()
                                  .add(ToggleHasDiet(value!));
                            },
                          ),
                          Text("Yes"),
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 15),
                  buildDietChips(),
                  const SizedBox(height: 20),
                  buildAddDietSection(),
                  const SizedBox(height: 130),
                  SizedBox(
                    width: double.infinity,
                    child: ReusableButton(
                      textColor: ColorConstants.white,
                      backgroundColor: ColorConstants.red,
                      buttonPressed: () {
                        controller.jumpToPage(2);
                      },
                      textname: "Next",
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildDietChips() {
    return BlocBuilder<WelcomeBloc, WelcomeState>(
      builder: (context, state) {
        final prefDiets = [
          'Vegetarian',
          'Spicy Junk Food',
          'Sweets',
          'Keto',
          'Raw Foodist',
          'Beaf',
          'Vegan',
          'Gluten'
        ];

        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: prefDiets.map((item) {
              final isSelected = state.selectedDiets.contains(item);
              return ChoiceChip(
                label: Text(item),
                selected: isSelected,
                selectedColor: Colors.red,
                labelStyle: TextStyle(
                    color: isSelected ? Colors.white : Colors.black),
                onSelected: (_) {
                  context
                      .read<WelcomeBloc>()
                      .add(ToggleDietSelection(item));
                },
              );
            }).toList(),
          ),
        );
      },
    );
  }

  Widget buildAddDietSection() {
    final controller = TextEditingController();
    return BlocBuilder<WelcomeBloc, WelcomeState>(
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text("Add Diet",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: controller,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: ColorConstants.lightGrey1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: ColorConstants.lightGrey1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    decoration: BoxDecoration(
                      color: ColorConstants.yellow,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () {
                        final input = controller.text.trim();
                        if (input.isNotEmpty &&
                            !state.customDiets.contains(input)) {
                          context
                              .read<WelcomeBloc>()
                              .add(AddCustomDiet(input));
                          controller.clear();
                        }
                      },
                    ),
                  )
                ],
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                children: state.customDiets.map((item) {
                  return Chip(
                    label: Text(item),
                    onDeleted: () {
                      context
                          .read<WelcomeBloc>()
                          .add(RemoveCustomDiet(item));
                    },
                  );
                }).toList(),
              ),
            ],
          ),
        );
      },
    );
  }
}
