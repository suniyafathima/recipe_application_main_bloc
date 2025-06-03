import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_application_main/features/onboarding_screen/viewmodel/onboarding_bloc.dart';
import 'package:recipe_application_main/features/onboarding_screen/viewmodel/onboarding_state.dart';
import 'package:recipe_application_main/features/onboarding_screen/viewmodel/onboarding_event.dart';
import 'package:recipe_application_main/features/welcome_screens/view/allergy_screen.dart';
import 'package:recipe_application_main/features/welcome_screens/view/preference_screen.dart';
import 'package:recipe_application_main/features/welcome_screens/view/welcome_screen.dart';
import 'package:recipe_application_main/utils/constants/color_constants.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      final page = _controller.page?.round() ?? 0;
      context.read<OnboardingBloc>().add(OnboardingPageChanged(page));
    });
  }

  @override
  Widget build(BuildContext context) {
    final isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;

    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              WelcomeScreen(controller: _controller),
              PreferenceScreen(controller: _controller),
              AllergyScreen(controller: _controller),
            ],
          ),
          if (!isKeyboardOpen)
            Positioned(
              bottom: 30,
              left: 0,
              right: 0,
              child: BlocBuilder<OnboardingBloc, OnboardingState>(
                builder: (context, state) {
                  return Center(
                    child: SmoothPageIndicator(
                      controller: _controller,
                      count: 3,
                      effect: ExpandingDotsEffect(
                        dotColor: ColorConstants.lightGrey1,
                        activeDotColor: ColorConstants.red,
                        dotHeight: 6.0,
                        dotWidth: 6.0,
                        spacing: 4.0,
                      ),
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
