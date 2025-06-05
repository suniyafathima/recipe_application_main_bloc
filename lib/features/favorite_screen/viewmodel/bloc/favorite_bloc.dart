import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_application_main/Repository/data/dummydb.dart';
import 'package:recipe_application_main/features/home/model/recipe_model.dart';

part 'favorite_event.dart';
part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  FavoriteBloc() : super(FavoriteInitial()) {
    on<LoadFavorites>(onLoadFavorites);
    on<RemoveFavorite>(onRemoveFavorite);
    on<DismissAlert>(onDismissAlert);
  }

  Future<void> onLoadFavorites(
    LoadFavorites event,
    Emitter<FavoriteState> emit,
  ) async {
    emit(FavoriteLoading());
    await Future.delayed(Duration(milliseconds: 500)); 
    emit(FavoriteLoaded(items: Dummydb.items, showAlert: true));
  }

  void onRemoveFavorite(RemoveFavorite event, Emitter<FavoriteState> emit) {
    if (state is FavoriteLoaded) {
      final current = state as FavoriteLoaded;
      final updatedItems = List<Recipemodel>.from(current.items)..removeAt(event.index);
      emit(FavoriteLoaded(items: updatedItems, showAlert: current.showAlert));
    }
  }

  void onDismissAlert(DismissAlert event, Emitter<FavoriteState> emit) {
    if (state is FavoriteLoaded) {
      final current = state as FavoriteLoaded;
      emit(FavoriteLoaded(items: current.items, showAlert: false));
    }
  }
}
