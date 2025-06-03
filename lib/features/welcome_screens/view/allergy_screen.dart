import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_application_main/features/welcome_screens/viewmodel/bloc/welcomebloc/welcome_bloc.dart';

class AllergyScreen extends StatefulWidget {
  const AllergyScreen({super.key, required PageController controller});

  @override
  State<AllergyScreen> createState() => _AllergyScreenState();
}

class _AllergyScreenState extends State<AllergyScreen> {
  final List<String> prefAllergies = [
    'Peanuts', 'Dairy', 'Gluten', 'Seafood', 'Eggs', 'Soy', 'Tree Nuts'
  ];

  final TextEditingController allergyController = TextEditingController();

  @override
  void dispose() {
    allergyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => WelcomeBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Allergy Preferences"),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: BlocBuilder<WelcomeBloc, WelcomeState>(
              builder: (context, state) {
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Select your allergies:",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: prefAllergies.map((allergy) {
                          final isSelected = state.selectedAllergies.contains(allergy);
                          return ChoiceChip(
                            label: Text(allergy),
                            selected: isSelected,
                            selectedColor: Colors.red,
                            onSelected: (_) {
                              context.read<WelcomeBloc>().add(ToggleSelectedAllergy(allergy));
                            },
                            labelStyle: TextStyle(
                              color: isSelected ? Colors.white : Colors.black,
                            ),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        "Add custom allergy:",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: allergyController,
                              decoration: InputDecoration(
                                hintText: "Type allergy name",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          ElevatedButton(
                            onPressed: () {
                              final input = allergyController.text.trim();
                              if (input.isNotEmpty && !state.addedAllergies.contains(input)) {
                                context.read<WelcomeBloc>().add(AddNewAllergy(input));
                                allergyController.clear();
                              }
                            },
                            child: const Icon(Icons.add),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Wrap(
                        spacing: 8,
                        children: state.addedAllergies.map((customAllergy) {
                          return Chip(
                            label: Text(customAllergy),
                            onDeleted: () {
                              context.read<WelcomeBloc>().add(RemoveAddedAllergy(customAllergy));
                            },
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
