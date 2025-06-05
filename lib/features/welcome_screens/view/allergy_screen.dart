import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_application_main/features/bottom_nav_bar/view/bottom_navbar.dart';
import 'package:recipe_application_main/features/welcome_screens/viewmodel/bloc/welcomebloc/welcome_bloc.dart';
import 'package:recipe_application_main/global_widget/reusable_button.dart';
import 'package:recipe_application_main/utils/constants/color_constants.dart';


class AllergyScreen extends StatefulWidget {
  final PageController controller;

  const AllergyScreen({super.key, required this.controller});

  @override
  State<AllergyScreen> createState() => _AllergyScreenState();
}

class _AllergyScreenState extends State<AllergyScreen> {
  final List<String> allergyIngre = [
    'Wheat',
    'Dairy',
    'Tree Nuts',
    'Tomatoes',
    'Egg',
    'Chicken',
    'Beef',
    'Vegan',
    'Gluten',
  ];
  final TextEditingController allergyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => WelcomeBloc(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          systemOverlayStyle: SystemUiOverlayStyle.dark,
          leading: IconButton(
            onPressed: () {
              widget.controller.jumpToPage(1);
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
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Column(
              children: [
                Text(
                  "Any Ingredient allergies?",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 15),
                BlocBuilder<WelcomeBloc, WelcomeState>(
                  builder: (context, state) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Radio(
                          value: false,
                          groupValue: state.hasAllergy,
                          activeColor: ColorConstants.red,
                          onChanged: (value) {
                            context.read<WelcomeBloc>().add(ToggleHasAllergy(value!));
                          },
                        ),
                        Text("No"),
                        Radio(
                          value: true,
                          groupValue: state.hasAllergy,
                          activeColor: ColorConstants.red,
                          onChanged: (value) {
                            context.read<WelcomeBloc>().add(ToggleHasAllergy(value!));
                          },
                        ),
                        Text("Yes"),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: BlocBuilder<WelcomeBloc, WelcomeState>(
                    builder: (context, state) {
                      return Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: allergyIngre.map((item) {
                          final isSelected = state.selectedAllergies.contains(item);
                          return ChoiceChip(
                            label: Text(item),
                            selected: isSelected,
                            selectedColor: ColorConstants.red,
                            labelStyle: TextStyle(
                              color: isSelected ? Colors.white : Colors.black,
                            ),
                            onSelected: (_) {
                              context.read<WelcomeBloc>().add(ToggleSelectedAllergy(item));
                            },
                          );
                        }).toList(),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text("Add Allergy", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: allergyController,
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: ColorConstants.lightGrey1),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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
                                final input = allergyController.text.trim();
                                if (input.isNotEmpty) {
                                  context.read<WelcomeBloc>().add(AddNewAllergy(input));
                                  allergyController.clear();
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      BlocBuilder<WelcomeBloc, WelcomeState>(
                        builder: (context, state) {
                          return Wrap(
                            spacing: 8,
                            children: state.addedAllergies.map((item) {
                              return Chip(
                                label: Text(item),
                                onDeleted: () {
                                  context.read<WelcomeBloc>().add(RemoveAddedAllergy(item));
                                },
                              );
                            }).toList(),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 135),
                SizedBox(
                  width: double.infinity,
                  child: ReusableButton(
                    textColor: ColorConstants.white,
                    backgroundColor: ColorConstants.red,
                    textname: "Next",
                    buttonPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text(
                            "Welcome to Tasty",
                            style: TextStyle(fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                          content: const Text(
                            "Cooking based on the food recipes you find and the food you love.",
                            style: TextStyle(fontWeight: FontWeight.normal, fontSize: 20, color: Colors.black45),
                            textAlign: TextAlign.center,
                          ),
                          actions: [
                            ReusableButton(
                              buttonPressed: () {
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(builder: (context) => BottomNavbar()),
                                  (route) => false,
                                );
                              },
                              textname: "Get Started",
                              backgroundColor: ColorConstants.red,
                              textColor: ColorConstants.white,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
