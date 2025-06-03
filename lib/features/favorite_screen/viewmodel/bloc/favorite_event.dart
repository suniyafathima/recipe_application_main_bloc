part of 'favorite_bloc.dart';

sealed class FavoriteEvent {}

class LoadFavorites extends FavoriteEvent {}

class RemoveFavorite extends FavoriteEvent {
  final int index;
  RemoveFavorite(this.index);
}

class DismissAlert extends FavoriteEvent {}
