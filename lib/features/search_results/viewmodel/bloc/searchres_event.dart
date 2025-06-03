part of 'searchres_bloc.dart';

sealed class SearchResultsEvent {}

class UpdateSearchQuery extends SearchResultsEvent {
  final String query;
  UpdateSearchQuery(this.query);
}

class ToggleLike extends SearchResultsEvent {
  final Recipemodel item;
  ToggleLike(this.item);
}
