import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_application_main/features/home/model/recipe_model.dart';

part 'favorite_event.dart';
part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  FavoriteBloc() : super(FavoriteInitial()) {
    on<LoadFavorites>(_onLoadFavorites);
    on<RemoveFavorite>(_onRemoveFavorite);
    on<DismissAlert>(_onDismissAlert);
  }

  Future<void> _onLoadFavorites(
    LoadFavorites event,
    Emitter<FavoriteState> emit,
  ) async {
    emit(FavoriteLoading());
    await Future.delayed(Duration(milliseconds: 500)); // simulate delay

    final items = <Recipemodel>[
      Recipemodel(imagePath: "assets/images/chickenzuccini.jpg", name: "Chicken zuccini", rating: 4.5, time: "25m"),
      Recipemodel(imagePath: "assets/images/easybourboncake.jpg", name: "Easy bourbon cake", rating: 4, time: "20m"),
      Recipemodel(imagePath: "assets/images/noodles.jpg", name: "Chilly Egg noodles", rating: 3.5, time: "30m"),
      Recipemodel(imagePath: "assets/images/Potatofry.jpg", name: "Crispy Potato fry", rating: 5, time: "25m"),
      Recipemodel(imagePath: "assets/images/Sourcreamfried.jpg", name: "Sourcream chicken", rating: 5, time: "32m"),
      Recipemodel(imagePath: "assets/images/vegopesto.jpg", name: "Sego pesto pasta", rating: 1, time: "15m"),
      Recipemodel(imagePath: "assets/images/butterchicken.jpg", name: "Butter chicken", rating: 4.9, time: "20m"),
    ];

    emit(FavoriteLoaded(items: items, showAlert: true));
  }

  void _onRemoveFavorite(RemoveFavorite event, Emitter<FavoriteState> emit) {
    if (state is FavoriteLoaded) {
      final current = state as FavoriteLoaded;
      final updatedItems = List<Recipemodel>.from(current.items)..removeAt(event.index);
      emit(FavoriteLoaded(items: updatedItems, showAlert: current.showAlert));
    }
  }

  void _onDismissAlert(DismissAlert event, Emitter<FavoriteState> emit) {
    if (state is FavoriteLoaded) {
      final current = state as FavoriteLoaded;
      emit(FavoriteLoaded(items: current.items, showAlert: false));
    }
  }
}
