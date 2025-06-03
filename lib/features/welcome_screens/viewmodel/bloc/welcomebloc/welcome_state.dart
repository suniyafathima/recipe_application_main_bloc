part of 'welcome_bloc.dart';

class WelcomeState {
  final bool hasDiet;
  final List<String> selectedDiets;
  final List<String> customDiets;

  final bool hasAllergy;
  final List<String> selectedAllergies;
  final List<String> addedAllergies;

  final bool navigate;

  const WelcomeState({
    required this.hasDiet,
    required this.selectedDiets,
    required this.customDiets,
    required this.hasAllergy,
    required this.selectedAllergies,
    required this.addedAllergies,
    this.navigate = false,
  });

  factory WelcomeState.initial() => const WelcomeState(
        hasDiet: true,
        selectedDiets: [],
        customDiets: [],
        hasAllergy: false,
        selectedAllergies: [],
        addedAllergies: [],
        navigate: false,
      );

  WelcomeState copyWith({
    bool? hasDiet,
    List<String>? selectedDiets,
    List<String>? customDiets,
    bool? hasAllergy,
    List<String>? selectedAllergies,
    List<String>? addedAllergies,
    bool? navigate,
  }) {
    return WelcomeState(
      hasDiet: hasDiet ?? this.hasDiet,
      selectedDiets: selectedDiets ?? this.selectedDiets,
      customDiets: customDiets ?? this.customDiets,
      hasAllergy: hasAllergy ?? this.hasAllergy,
      selectedAllergies: selectedAllergies ?? this.selectedAllergies,
      addedAllergies: addedAllergies ?? this.addedAllergies,
      navigate: navigate ?? this.navigate,
    );
  }
}
