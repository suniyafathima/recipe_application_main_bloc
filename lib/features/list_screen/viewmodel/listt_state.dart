import 'package:recipe_application_main/features/list_screen/model/ingredient_model.dart';

sealed class ListState {}

class InitialState extends ListState {}

class LoadedState extends ListState {
  final List<IngredientModel> ingredients;
  final List<String> addedItems;

  LoadedState({
    required this.ingredients,
    required this.addedItems,
  });
}
