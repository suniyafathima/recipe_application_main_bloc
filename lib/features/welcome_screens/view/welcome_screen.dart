import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_application_main/features/welcome_screens/viewmodel/bloc/welcomebloc/welcome_bloc.dart';
import 'package:recipe_application_main/global_widget/reusable_button.dart';
import 'package:recipe_application_main/utils/constants/color_constants.dart';

class WelcomeScreen extends StatelessWidget {
  final PageController controller;

  const WelcomeScreen({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => WelcomeBloc(),
      child: BlocListener<WelcomeBloc, WelcomeState>(
        listener: (context, state) {
          if (state.navigate) {
            controller.jumpToPage(1);
            context.read<WelcomeBloc>().add(const ResetNavigate());
          }
        },
        child: Scaffold(
          extendBodyBehindAppBar: true,
          body: Padding(
            padding: const EdgeInsets.all(25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    "Tasty",
                    style: TextStyle(
                      color: ColorConstants.red,
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: 340,
                  child: Stack(
                    alignment: Alignment.center,
                    clipBehavior: Clip.none,
                    children: [
                      Positioned(
                        bottom: 0,
                        left: 40,
                        child: Container(
                          width: 180,
                          height: 180,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.contain,
                              image: AssetImage("assets/images/bgi.png"),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 30,
                        left: 85,
                        child: Container(
                          width: 210,
                          height: 320,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.contain,
                              image: AssetImage("assets/images/floa.png"),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                Text(
                  "Recipes Picked just for you",
                  style: TextStyle(
                    color: ColorConstants.black,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),
                Text(
                  "Tell us a bit about your cooking so we can suggest recipes we think you'll enjoy.",
                  style: TextStyle(
                    color: ColorConstants.black,
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),
                ReusableButton(
                  textColor: ColorConstants.white,
                  backgroundColor: ColorConstants.red,
                  textname: "Let's get started!",
                  buttonPressed: () {
                    context.read<WelcomeBloc>().add(const WelcomeButtonPressed());
                  },
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
