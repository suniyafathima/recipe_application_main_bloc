part of 'recipedetail_bloc.dart';
class RecipeDetailsState {
  final List<int> selectedIngredients;

  const RecipeDetailsState({this.selectedIngredients = const []});

  RecipeDetailsState copyWith({List<int>? selectedIngredients}) {
    return RecipeDetailsState(
      selectedIngredients: selectedIngredients ?? this.selectedIngredients,
    );
  }
}
