part of 'search_bloc.dart';

sealed class SearchEvent {}

class SearchQueryChanged extends SearchEvent {
  final String query;
  SearchQueryChanged(this.query);
}

class CategorySelected extends SearchEvent {
  final String category;
  CategorySelected(this.category);
}
