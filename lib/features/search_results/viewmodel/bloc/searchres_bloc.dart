import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_application_main/features/home/model/recipe_model.dart';

part 'searchres_event.dart';
part 'searchres_state.dart';

class SearchResultsBloc extends Bloc<SearchResultsEvent, SearchResultsState> {
  SearchResultsBloc()
      : super(SearchResultsState(
          allItems: items,
          filteredItems: items,
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

final List<Recipemodel> items = [
  Recipemodel(imagePath: "assets/images/chickenzuccini.jpg", name: "Chicken zuccini", rating: 4.5, time: "25m"),
  Recipemodel(imagePath: "assets/images/easybourboncake.jpg", name: "Easy bourbon cake", rating: 4, time: "20m"),
  Recipemodel(imagePath: "assets/images/noodles.jpg", name: "Chilly Egg noodles", rating: 3.5, time: "30m"),
  Recipemodel(imagePath: "assets/images/Potatofry.jpg", name: "Crispy Potato fry", rating: 5, time: "25m"),
  Recipemodel(imagePath: "assets/images/Sourcreamfried.jpg", name: "Sourcream fried chicken", rating: 5, time: "32m"),
  Recipemodel(imagePath: "assets/images/vegopesto.jpg", name: "Sego pesto pasta", rating: 1, time: "15m"),
  Recipemodel(imagePath: "assets/images/butterchicken.jpg", name: "Butter chicken", rating: 4.9, time: "20m", isLiked: false),
];
