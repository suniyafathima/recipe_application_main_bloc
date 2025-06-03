part of 'favorite_bloc.dart';

sealed class FavoriteState {}

class FavoriteInitial extends FavoriteState {}
class FavoriteLoading extends FavoriteState {}

class FavoriteLoaded extends FavoriteState {
  final List<Recipemodel> items;
  final bool showAlert;

  FavoriteLoaded({required this.items, required this.showAlert});
}

class FavoriteError extends FavoriteState {
  final String message;
  FavoriteError(this.message);
}
