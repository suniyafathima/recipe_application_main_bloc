part of 'recipedetail_bloc.dart';
sealed class RecipeDetailsEvent {}

class ToggleIngredientSelection extends RecipeDetailsEvent {
  final int index;
  ToggleIngredientSelection(this.index);
}
