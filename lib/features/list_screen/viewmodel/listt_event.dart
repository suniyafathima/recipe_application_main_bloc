import 'package:recipe_application_main/features/list_screen/model/ingredient_model.dart';

sealed class ListEvent {}

class LoadList extends ListEvent {
  final List<IngredientModel> ingredients;

  LoadList(this.ingredients);
}

class AddToList extends ListEvent {
  final String newItem;

  AddToList(this.newItem);
}

class RemoveFromList extends ListEvent {
  final int index;

  RemoveFromList(this.index);
}

class ClearList extends ListEvent {}
