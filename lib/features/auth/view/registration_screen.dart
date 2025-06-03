import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_application_main/features/auth/view/login_screen.dart';
import 'package:recipe_application_main/features/auth/viewmodel/bloc/registration_bloc/bloc/register_bloc.dart';
import 'package:recipe_application_main/global_widget/reusable_button.dart';
import 'package:recipe_application_main/utils/constants/color_constants.dart';


class RegistrationScreen extends StatelessWidget {
  RegistrationScreen({super.key});

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => RegisterBloc(),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Center(
              child: SingleChildScrollView(
                child: BlocConsumer<RegisterBloc, RegisterState>(
                  listener: (context, state) {
                    if (state.isSuccess) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
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
                        Text(
                          "Create Account",
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 30),
                        Container(
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 10,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              // Name field
                              TextFormField(
                                controller: nameController,
                                onChanged: (value) {
                                  context
                                      .read<RegisterBloc>()
                                      .add(RegisterNameChanged(value));
                                },
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.person),
                                  hintText: "Display Name",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  filled: true,
                                  fillColor: ColorConstants.white,
                                ),
                              ),
                              SizedBox(height: 16),

                              // Email field
                              TextFormField(
                                controller: emailController,
                                onChanged: (value) {
                                  context
                                      .read<RegisterBloc>()
                                      .add(RegisterEmailChanged(value));
                                },
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.email),
                                  hintText: "Email",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  filled: true,
                                  fillColor: ColorConstants.white,
                                ),
                              ),
                              SizedBox(height: 16),

                              // Password field
                              TextFormField(
                                controller: passwordController,
                                obscureText: true,
                                onChanged: (value) {
                                  context
                                      .read<RegisterBloc>()
                                      .add(RegisterPasswordChanged(value));
                                },
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.lock),
                                  hintText: "Password",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  filled: true,
                                  fillColor: ColorConstants.white,
                                ),
                              ),
                              SizedBox(height: 30),

                              // Register button or loader
                              state.isSubmitting
                                  ? CircularProgressIndicator()
                                  : ReusableButton(
                                      buttonPressed: () {
                                        context
                                            .read<RegisterBloc>()
                                            .add(RegisterSubmitted());
                                      },
                                      textname: "Register",
                                      backgroundColor: ColorConstants.red,
                                      textColor: ColorConstants.white,
                                    ),
                            ],
                          ),
                        ),
                        SizedBox(height: 16),

                        // Already have account
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginScreen()),
                            );
                          },
                          child: Text(
                            "Already have an account? Login",
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
