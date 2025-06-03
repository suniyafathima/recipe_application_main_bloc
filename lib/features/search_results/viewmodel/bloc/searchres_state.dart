part of 'searchres_bloc.dart';

class SearchResultsState {
  final List<Recipemodel> allItems;
  final List<Recipemodel> filteredItems;
  final String searchQuery;

  SearchResultsState({
    required this.allItems,
    required this.filteredItems,
    this.searchQuery = '',
  });

  SearchResultsState copyWith({
    List<Recipemodel>? allItems,
    List<Recipemodel>? filteredItems,
    String? searchQuery,
  }) {
    return SearchResultsState(
      allItems: allItems ?? this.allItems,
      filteredItems: filteredItems ?? this.filteredItems,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }
}
