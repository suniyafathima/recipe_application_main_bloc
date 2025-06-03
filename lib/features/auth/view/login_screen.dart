import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_application_main/features/auth/view/registration_screen.dart';
import 'package:recipe_application_main/features/auth/viewmodel/bloc/login_bloc/login_bloc.dart';
import 'package:recipe_application_main/features/bottom_nav_bar/view/bottom_navbar.dart';
import 'package:recipe_application_main/global_widget/reusable_button.dart';
import 'package:recipe_application_main/utils/constants/color_constants.dart';
import 'package:social_media_buttons/social_media_icons.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginBloc(),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Center(
              child: SingleChildScrollView(
                child: BlocConsumer<LoginBloc, LoginState>(
                  listener: (context, state) {
                    if (state.isSuccess) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => BottomNavbar()),
                      );
                    }
                    if (state.errorMessage != null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(state.errorMessage!)),
                      );
                    }
                  },
                  builder: (context, state) {
                    return Column(
                      children: [
                        const Text(
                          "Welcome Back!",
                          style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 30),
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 10,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextField(
                                controller: emailController,
                                onChanged: (value) {
                                  context.read<LoginBloc>().add(LoginEmailChanged(value));
                                },
                                decoration: InputDecoration(
                                  prefixIcon: const Icon(Icons.email),
                                  hintText: "Email",
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: const BorderSide(color: Colors.grey),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: const BorderSide(color: Colors.grey),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: const BorderSide(color: Colors.red),
                                  ),
                                  filled: true,
                                  fillColor: ColorConstants.white,
                                ),
                              ),
                              const SizedBox(height: 16),
                              TextField(
                                controller: passwordController,
                                obscureText: true,
                                onChanged: (value) {
                                  context.read<LoginBloc>().add(LoginPasswordChanged(value));
                                },
                                decoration: InputDecoration(
                                  prefixIcon: const Icon(Icons.lock),
                                  hintText: "Password",
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: const BorderSide(color: Colors.grey),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: const BorderSide(color: Colors.grey),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: const BorderSide(color: Colors.red),
                                  ),
                                  filled: true,
                                  fillColor: ColorConstants.white,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  "Forgot password?",
                                  style: TextStyle(
                                    color: Colors.black45,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 30),
                              state.isSubmitting
                                  ? const Center(child: CircularProgressIndicator())
                                  : ReusableButton(
                                      buttonPressed: () {
                                        context.read<LoginBloc>().add(LoginSubmitted());
                                      },
                                      textname: "Login",
                                      backgroundColor: ColorConstants.red,
                                      textColor: ColorConstants.white,
                                    ),
                              const SizedBox(height: 20),
                              const Center(child: Text("or login with")),
                              const SizedBox(height: 16),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ClipRRect(
                                    child: Container(
                                      width: 38,
                                      height: 35,
                                      color: ColorConstants.black,
                                      child: const Icon(
                                        Icons.apple_outlined,
                                        size: 22,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                  ClipRRect(
                                    child: Container(
                                      width: 38,
                                      height: 35,
                                      decoration: BoxDecoration(
                                        color: Colors.blueAccent,
                                        borderRadius: BorderRadius.circular(2),
                                      ),
                                      child: Icon(
                                        SocialMediaIcons.facebook,
                                        color: ColorConstants.white,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                  ClipRRect(
                                    child: Container(
                                      width: 38,
                                      height: 35,
                                      padding: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        color: ColorConstants.red,
                                        borderRadius: BorderRadius.circular(2),
                                      ),
                                      child: Icon(
                                        SocialMediaIcons.google,
                                        color: ColorConstants.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => RegistrationScreen()),
                            );
                          },
                          child: Text(
                            "Don't have an account? Sign up",
                            style: TextStyle(
                              color: Colors.grey[700],
                              fontWeight: FontWeight.w500,
                            ),
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
      ),
    );
  }
}
