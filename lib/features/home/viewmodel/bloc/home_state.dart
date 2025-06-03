part of 'home_bloc.dart';

sealed class HomeState {
  const HomeState();
}

class HomeInitial extends HomeState {
  const HomeInitial();
}

class HomeLoading extends HomeState {
  const HomeLoading();
}

class HomeLoaded extends HomeState {
  final List<Recipemodel> recipes;
  const HomeLoaded({required this.recipes});
}

class HomeError extends HomeState {
  final String message;
  const HomeError(this.message);
}
