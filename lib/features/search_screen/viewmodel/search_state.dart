part of 'search_bloc.dart';

class SearchState {
  final String query;
  final String? selectedCategory;

  SearchState({
    this.query = '',
    this.selectedCategory,
  });

  SearchState copyWith({String? query, String? selectedCategory}) {
    return SearchState(
      query: query ?? this.query,
      selectedCategory: selectedCategory ?? this.selectedCategory,
    );
  }
}
