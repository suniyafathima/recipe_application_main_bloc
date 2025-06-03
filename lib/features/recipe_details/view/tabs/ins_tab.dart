import 'package:flutter/material.dart';
import 'package:recipe_application_main/global_widget/reusable_button.dart';
import 'package:recipe_application_main/utils/constants/color_constants.dart';
import 'package:recipe_application_main/features/cooking_step_screen/view/cooking_step_screen.dart';

class Instab extends StatelessWidget {
  const Instab({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> steps = [
      {
        "instruction": "Place noodles in a heatproof bowl. Cover with boiling water. Set aside for 5 mins or until noodles separate. Drain.",
        "duration": 60
      },
      {
        "instruction": "Heat oil in a wok. Add curry powder and stir-fry for 1 min. Add oyster sauce, soy sauce, noodles, and ½ cup (125ml) water. Stir-fry for 2 mins until combined.",
        "duration": 90
      },
      {
        "instruction": "Add peas, choy sum, wombok, and spring onion. Stir-fry for 1-2 mins until wombok wilts. Serve hot.",
        "duration": 30
      }
    ];

    return Column(
      children: [
        Column(
          children: List.generate(steps.length, (index) {
            return buildStepItem("Step ${index + 1}", steps[index]["instruction"], isLast: index == steps.length - 1);
          }),
        ),
        ReusableButton(
          buttonPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CookingStepScreen(steps: steps),
              ),
            );
          },
          backgroundColor: ColorConstants.red,
          textColor: ColorConstants.white,
          textname: "Start cooking",
        )
      ],
    );
  }

  Widget buildStepItem(String title, String description, {bool isLast = false}) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 8),
                width: 16,
                height: 16,
                decoration: BoxDecoration(
                  color: ColorConstants.red,
                  shape: BoxShape.circle,
                ),
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    color: ColorConstants.red,
                    margin: const EdgeInsets.symmetric(vertical: 4),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: ColorConstants.red)),
                const SizedBox(height: 8),
                Text(description, style: const TextStyle(fontSize: 16), textAlign: TextAlign.justify),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
