part of 'home_bloc.dart';

sealed class HomeEvent {}

class LoadRecipesEvent extends HomeEvent {}

class ToggleLikeRecipeEvent extends HomeEvent {
  final int index;
  ToggleLikeRecipeEvent(this.index);
}
