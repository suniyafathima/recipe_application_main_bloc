import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_application_main/features/bottom_nav_bar/view/bottom_navbar.dart';
import 'package:recipe_application_main/features/cooking_step_screen/viewmodel/bloc/cookingstep_bloc.dart';
import 'package:recipe_application_main/global_widget/reusable_button.dart';
import 'package:recipe_application_main/utils/constants/color_constants.dart';

class CookingStepScreen extends StatelessWidget {
  final List<Map<String, dynamic>> steps;

  const CookingStepScreen({super.key, required this.steps});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CookingStepBloc(steps),
      child: Scaffold(
        backgroundColor: ColorConstants.lightred,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(40),
            child: BlocBuilder<CookingStepBloc, CookingStepState>(
              builder: (context, state) {
                final bloc = context.read<CookingStepBloc>();
                final progress = steps[state.currentStep]['duration'] > 0
                    ? (steps[state.currentStep]['duration'] - state.secondsRemaining) /
                        steps[state.currentStep]['duration']
                    : 0.0;

                return Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                            icon: Icon(
                              state.isPaused ? Icons.play_circle_outlined : Icons.pause_circle_outlined,
                              color: ColorConstants.yellow,
                            ),
                            onPressed: () => bloc.add(PauseResumeCooking()),
                          ),
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              SizedBox(
                                height: 90,
                                width: 100,
                                child: CircularProgressIndicator(
                                  value: progress,
                                  strokeWidth: 8,
                                  backgroundColor: ColorConstants.lightred,
                                  valueColor: AlwaysStoppedAnimation(ColorConstants.red),
                                ),
                              ),
                              Text(
                                "${(state.secondsRemaining ~/ 60).toString().padLeft(2, '0')}:${(state.secondsRemaining % 60).toString().padLeft(2, '0')}",
                                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          IconButton(
                            icon: Icon(Icons.refresh, color: ColorConstants.yellow),
                            onPressed: () => bloc.add(ResetStep()),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        steps.length,
                        (index) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: CircleAvatar(
                            radius: 6,
                            backgroundColor:
                                index == state.currentStep ? ColorConstants.red : ColorConstants.lightGrey1,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "Step ${state.currentStep + 1}",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: ColorConstants.red),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      steps[state.currentStep]['instruction'],
                      textAlign: TextAlign.justify,
                      style: const TextStyle(fontSize: 16),
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton.icon(
                          onPressed: () => bloc.add(PreviousStep()),
                          icon: const Icon(Icons.arrow_back_ios),
                          label: const Text("Previous Step", style: TextStyle(color: Colors.black87)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ColorConstants.white,
                            foregroundColor: ColorConstants.red,
                          ),
                        ),
                        ElevatedButton.icon(
                          onPressed: state.currentStep < steps.length - 1 ? () => bloc.add(NextStep()) : null,
                          label: Row(
                            children: const [
                              Text("Next Step", style: TextStyle(color: Colors.black87)),
                              SizedBox(width: 10),
                              Icon(Icons.arrow_forward_ios),
                            ],
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ColorConstants.white,
                            foregroundColor: ColorConstants.red,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    ReusableButton(
                      buttonPressed: () {
                        if (state.isCompleted) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => const BottomNavbar()),
                          );
                        }
                      },
                      textColor: ColorConstants.white,
                      backgroundColor:
                          state.isCompleted ? ColorConstants.red : ColorConstants.lightGrey1,
                      textname: "Done",
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
