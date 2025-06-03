import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

@immutable
sealed class OnboardingState {
  final int currentPage;

  const OnboardingState({required this.currentPage});

  OnboardingState copyWith({int? currentPage});
}

class OnboardingInitialState extends OnboardingState {
  const OnboardingInitialState({required super.currentPage});

  @override
  OnboardingInitialState copyWith({int? currentPage}) {
    return OnboardingInitialState(currentPage: currentPage ?? this.currentPage);
  }
}
