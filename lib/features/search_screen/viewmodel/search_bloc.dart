import 'package:flutter_bloc/flutter_bloc.dart';
part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchState()) {
    on<SearchQueryChanged>((event, emit) {
      emit(state.copyWith(query: event.query));
    });

    on<CategorySelected>((event, emit) {
      emit(state.copyWith(selectedCategory: event.category));
    });
  }
}
