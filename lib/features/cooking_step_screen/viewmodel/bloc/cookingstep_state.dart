part of 'cookingstep_bloc.dart';

class CookingStepState {
  final int currentStep;
  final int secondsRemaining;
  final bool isPaused;
  final bool isCompleted;

  CookingStepState({
    required this.currentStep,
    required this.secondsRemaining,
    required this.isPaused,
    required this.isCompleted,
  });

  CookingStepState copyWith({
    int? currentStep,
    int? secondsRemaining,
    bool? isPaused,
    bool? isCompleted,
  }) {
    return CookingStepState(
      currentStep: currentStep ?? this.currentStep,
      secondsRemaining: secondsRemaining ?? this.secondsRemaining,
      isPaused: isPaused ?? this.isPaused,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
