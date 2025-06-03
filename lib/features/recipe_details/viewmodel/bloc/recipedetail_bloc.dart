import 'package:flutter_bloc/flutter_bloc.dart';
part 'recipedetail_event.dart';
part 'recipedetail_state.dart';


class RecipeDetailsBloc extends Bloc<RecipeDetailsEvent, RecipeDetailsState> {
  RecipeDetailsBloc() : super(RecipeDetailsState()) {
    on<ToggleIngredientSelection>((event, emit) {
      final updatedList = List<int>.from(state.selectedIngredients);
      if (updatedList.contains(event.index)) {
        updatedList.remove(event.index);
      } else {
        updatedList.add(event.index); 
      }
      emit(state.copyWith(selectedIngredients: updatedList));
    });
  }
}
