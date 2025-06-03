import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_application_main/features/home/model/recipe_model.dart';
part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final List<Recipemodel> _items = [
    Recipemodel(imagePath: "assets/images/chickenzuccini.jpg", name: "Chicken zuccini", rating: 4.5, time: "25m"),
    Recipemodel(imagePath: "assets/images/easybourboncake.jpg", name: "bourbon cake", rating: 4, time: "20m"),
    Recipemodel(imagePath: "assets/images/noodlessp.png", name: "Chilly Egg noodles", rating: 3.5, time: "30m"),
    Recipemodel(imagePath: "assets/images/Potatofry.jpg", name: "Crispy Potato fry", rating: 5, time: "25m"),
    Recipemodel(imagePath: "assets/images/Sourcreamfried.jpg", name: "Sourcream fried chicken", rating: 5, time: "32m"),
    Recipemodel(imagePath: "assets/images/vegopesto.jpg", name: "Sego pesto pasta", rating: 1, time: "15m"),
    Recipemodel(imagePath: "assets/images/butterchicken.jpg", name: "Butter chicken", rating: 4.9, time: "20m", isLiked: false),
  ];

  HomeBloc() : super(const HomeInitial()) {
    on<LoadRecipesEvent>((event, emit) async {
      emit(const HomeLoading());
      await Future.delayed(Duration(seconds: 1));
      emit(HomeLoaded(recipes: List.from(_items)));
    });

    on<ToggleLikeRecipeEvent>((event, emit) {
      _items[event.index].isLiked = !_items[event.index].isLiked;
      emit(HomeLoaded(recipes: List.from(_items)));
    });
  }
}
