import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_application_main/Repository/data/dummydb.dart';
import 'package:recipe_application_main/features/home/model/recipe_model.dart';

part 'searchres_event.dart';
part 'searchres_state.dart';

class SearchResultsBloc extends Bloc<SearchResultsEvent, SearchResultsState> {
  SearchResultsBloc()
      : super(SearchResultsState(
          allItems: Dummydb.items,
          filteredItems: Dummydb.items,
        )) {
    on<UpdateSearchQuery>((event, emit) {
      final filtered = state.allItems
          .where((item) =>
              item.name.toLowerCase().contains(event.query.toLowerCase()))
          .toList();

      emit(state.copyWith(
        searchQuery: event.query,
        filteredItems: filtered,
      ));
    });

    on<ToggleLike>((event, emit) {
      final updatedList = state.filteredItems.map((item) {
        if (item.name == event.item.name) {
          return item.copyWith(isLiked: !item.isLiked);
        }
        return item;
      }).toList();

      final updatedAllItems = state.allItems.map((item) {
        if (item.name == event.item.name) {
          return item.copyWith(isLiked: !item.isLiked);
        }
        return item;
      }).toList();

      emit(state.copyWith(
        allItems: updatedAllItems,
        filteredItems: updatedList,
      ));
    });
  }
}


