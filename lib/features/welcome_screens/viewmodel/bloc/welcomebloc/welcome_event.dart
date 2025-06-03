part of 'welcome_bloc.dart';

sealed class WelcomeEvent {
  const WelcomeEvent();
}

// Navigation
class WelcomeButtonPressed extends WelcomeEvent {
  const WelcomeButtonPressed();
}

class ResetNavigate extends WelcomeEvent {
  const ResetNavigate();
}

// Preferences
class ToggleHasDiet extends WelcomeEvent {
  final bool hasDiet;
  const ToggleHasDiet(this.hasDiet);
}

class ToggleDietSelection extends WelcomeEvent {
  final String dietName;
  const ToggleDietSelection(this.dietName);
}

class AddCustomDiet extends WelcomeEvent {
  final String dietName;
  const AddCustomDiet(this.dietName);
}

class RemoveCustomDiet extends WelcomeEvent {
  final String dietName;
  const RemoveCustomDiet(this.dietName);
}

// Allergies
class ToggleHasAllergy extends WelcomeEvent {
  final bool value;
  const ToggleHasAllergy(this.value);
}

class ToggleSelectedAllergy extends WelcomeEvent {
  final String allergy;
  const ToggleSelectedAllergy(this.allergy);
}

class AddNewAllergy extends WelcomeEvent {
  final String allergy;
  const AddNewAllergy(this.allergy);
}

class RemoveAddedAllergy extends WelcomeEvent {
  final String allergy;
  const RemoveAddedAllergy(this.allergy);
}
