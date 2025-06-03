import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_application_main/features/auth/viewmodel/bloc/login_bloc/login_bloc.dart';
import 'package:recipe_application_main/features/auth/viewmodel/bloc/registration_bloc/bloc/register_bloc.dart';
import 'package:recipe_application_main/features/bottom_nav_bar/viewmodel/bloc/bottom_navbar_bloc.dart';
import 'package:recipe_application_main/features/favorite_screen/viewmodel/bloc/favorite_bloc.dart';
import 'package:recipe_application_main/features/home/viewmodel/bloc/home_bloc.dart';
import 'package:recipe_application_main/features/list_screen/viewmodel/listt_bloc.dart';
import 'package:recipe_application_main/features/onboarding_screen/view/onboarding_screen.dart';
import 'package:recipe_application_main/features/onboarding_screen/viewmodel/onboarding_bloc.dart';
import 'package:recipe_application_main/features/profile_screen/viewmodel/bloc/profile_bloc.dart';
import 'package:recipe_application_main/features/recipe_details/viewmodel/bloc/recipedetail_bloc.dart';
import 'package:recipe_application_main/features/search_results/viewmodel/bloc/searchres_bloc.dart';
import 'package:recipe_application_main/features/search_screen/viewmodel/search_bloc.dart';
import 'package:recipe_application_main/features/welcome_screens/viewmodel/bloc/welcomebloc/welcome_bloc.dart'; 
import 'package:recipe_application_main/utils/constants/color_constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget { 
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
       return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => BottomNavBloc()),
        BlocProvider(create: (_) => OnboardingBloc()),
        BlocProvider(create: (_) => WelcomeBloc()),
        BlocProvider(create: (_) => RegisterBloc()),
        BlocProvider(create: (_) => LoginBloc()),
        BlocProvider(create: (_) => ProfileBloc()),
        BlocProvider(create: (_) => HomeBloc()),
        BlocProvider(create: (_) => FavoriteBloc()),
        BlocProvider(create: (_) => RecipeDetailsBloc()),
        BlocProvider(create: (_) => SearchBloc()),
        BlocProvider(create: (_) => SearchResultsBloc()),
        BlocProvider(create: (_) => ListtBloc()),
       
  
      ],
    child: MaterialApp(
      theme: ThemeData(scaffoldBackgroundColor: ColorConstants.lightred),
      debugShowCheckedModeBanner: false,
     home: OnboardingScreen()
        ) );
  }
}
