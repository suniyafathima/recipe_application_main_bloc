import 'package:flutter/material.dart';
import 'package:recipe_application_main/global_widget/reusable_button.dart';
import 'package:recipe_application_main/utils/constants/color_constants.dart';

class Reviewtab extends StatelessWidget {
  const Reviewtab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        Row(
          children: [
            const CircleAvatar(child: Icon(Icons.person, color: Colors.black)),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Suniya", style: TextStyle(fontSize: 18)),
                Row(
                  children: List.generate(
                    5,
                    (index) => Icon(Icons.star, size: 14, color: ColorConstants.yellow),
                  ),
                ),
              ],
            ),
            const Spacer(),
            const Text("30 min ago", style: TextStyle(color: Colors.grey)),
          ],
        ),
        const SizedBox(height: 10),
        const Text("Tasty!", style: TextStyle(color: Colors.black54)),
        const SizedBox(height: 20),
        const Text("Add Your Review", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            5,
            (index) => Icon(Icons.star_border_outlined, color: ColorConstants.yellow, size: 40),
          ),
        ),
        const SizedBox(height: 10),
        const TextField(
          maxLines: 4,
          maxLength: 500,
          decoration: InputDecoration(
            hintText: "Write a review...",
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 10),
        ReusableButton(
          buttonPressed: () {
           
          },
          textname: "Submit Review",
          backgroundColor: ColorConstants.red,
        ),
      ],
    );
  }
}
