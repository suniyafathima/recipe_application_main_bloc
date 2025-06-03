import 'package:flutter_bloc/flutter_bloc.dart';

part 'welcome_event.dart';
part 'welcome_state.dart';

class WelcomeBloc extends Bloc<WelcomeEvent, WelcomeState> {
  WelcomeBloc() : super(WelcomeState.initial()) {
    // Navigation
    on<WelcomeButtonPressed>((event, emit) {
      emit(state.copyWith(navigate: true));
    });

    on<ResetNavigate>((event, emit) {
      emit(state.copyWith(navigate: false));
    });

    // Preferences
    on<ToggleHasDiet>((event, emit) {
      emit(state.copyWith(hasDiet: event.hasDiet));
    });

    on<ToggleDietSelection>((event, emit) {
      final updated = List<String>.from(state.selectedDiets);
      if (updated.contains(event.dietName)) {
        updated.remove(event.dietName);
      } else {
        updated.add(event.dietName);
      }
      emit(state.copyWith(selectedDiets: updated));
    });

    on<AddCustomDiet>((event, emit) {
      if (event.dietName.isNotEmpty && !state.customDiets.contains(event.dietName)) {
        final updated = List<String>.from(state.customDiets)..add(event.dietName);
        emit(state.copyWith(customDiets: updated));
      }
    });

    on<RemoveCustomDiet>((event, emit) {
      final updated = List<String>.from(state.customDiets)..remove(event.dietName);
      emit(state.copyWith(customDiets: updated));
    });

    // Allergies
    on<ToggleHasAllergy>((event, emit) {
      emit(state.copyWith(hasAllergy: event.value));
    });

    on<ToggleSelectedAllergy>((event, emit) {
      final selected = List<String>.from(state.selectedAllergies);
      if (selected.contains(event.allergy)) {
        selected.remove(event.allergy);
      } else {
        selected.add(event.allergy);
      }
      emit(state.copyWith(selectedAllergies: selected));
    });

    on<AddNewAllergy>((event, emit) {
      final added = List<String>.from(state.addedAllergies);
      if (!added.contains(event.allergy)) {
        added.add(event.allergy);
        emit(state.copyWith(addedAllergies: added));
      }
    });

    on<RemoveAddedAllergy>((event, emit) {
      final added = List<String>.from(state.addedAllergies)..remove(event.allergy);
      emit(state.copyWith(addedAllergies: added));
    });
  }
}
