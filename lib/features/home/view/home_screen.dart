import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:recipe_application_main/features/home/viewmodel/bloc/home_bloc.dart';
import 'package:recipe_application_main/features/search_screen/view/search_screen.dart';
import 'package:recipe_application_main/global_widget/column_catg_container.dart';
import 'package:recipe_application_main/features/recipe_details/view/recipe_details.dart';
import 'package:recipe_application_main/utils/constants/color_constants.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:horizontal_list_view/horizontal_list_view.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController search = TextEditingController();
  int activeIndex = 0;

  @override
  void initState() {
    context.read<HomeBloc>().add(LoadRecipesEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is HomeLoaded) {
            final items = state.recipes;
            return SingleChildScrollView(
              child: Column(
                children: [
                  SafeArea(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Lottie.asset("assets/animations/tomato.json", height: 70, width: 50),
                        Text("Tasty", style: TextStyle(color: ColorConstants.red, fontSize: 35, fontWeight: FontWeight.bold)),
                        Padding(
                          padding: const EdgeInsets.only(right: 5),
                          child: Stack(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: ColorConstants.white,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: const Icon(Icons.notifications, color: Colors.amber, size: 30),
                              ),
                              Positioned(
                                right: 5,
                                top: 5,
                                child: Container(
                                  height: 20,
                                  width: 20,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.red,
                                    border: Border.all(color: Colors.white, width: 2),
                                  ),
                                  child: const Center(child: Text("2", style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold))),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 30, top: 10),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text("Hi Suniya!", style: TextStyle(fontSize: 20)),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25),
                    child: Text("What would you like to cook today?",
                      style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                  ),
                  const SizedBox(height: 20),
                  searchBar(context),
                  const SizedBox(height: 20),
                  buildCarousel(),
                  const SizedBox(height: 10),
                  carouseIndicator(),
                  const SizedBox(height: 20),
                  const Padding(
                    padding: EdgeInsets.only(left: 15),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text("Categories", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    ),
                  ),
                  categorySection(),
                  const SizedBox(height: 20),
                  sectionTitle("Picked for you"),
                  pickedForYouSection(items),
                  const SizedBox(height: 20),
                  sectionTitle("Popular recipes"),
                  popularRecipes(items),
                ],
              ),
            );
          }

          return const Center(child: Text("Something went wrong"));
        },
      ),
    );
  }

  Widget sectionTitle(String title) => Padding(
        padding: const EdgeInsets.only(left: 15),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        ),
      );

  Widget searchBar(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: InkWell(
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => SearchScreen())),
          child: Container(
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(color: ColorConstants.white, borderRadius: BorderRadius.circular(10)),
            child: const Row(children: [Icon(Icons.search), SizedBox(width: 8), Text("Recipe, ingredient or keyword")]),
          ),
        ),
      );

  Widget buildCarousel() => CarouselSlider(
        options: CarouselOptions(
          height: 170,
          autoPlay: true,
          enlargeCenterPage: true,
          viewportFraction: 0.96,
          onPageChanged: (index, reason) => setState(() => activeIndex = index),
        ),
        items: [
          buildCarousal("Special Summer Recipe", "Crispy Chicken", "30 Min", "assets/images/crispychicken.png"),
          buildCarousal("Noodles Recipe", "Egg noodles", "15 Min", "assets/images/noodless.png"),
          buildCarousal("Party punch ideas", "Red sangria", "45 Min", "assets/images/redsangria.png"),
          buildCarousal("Summer salads", "Ceaser salad", "30 Min", "assets/images/ceaserrsalad.png"),
        ],
      );

  Widget carouseIndicator() => AnimatedSmoothIndicator(
        activeIndex: activeIndex,
        count: 4,
        effect: ExpandingDotsEffect(
          dotColor: ColorConstants.lightGrey1,
          activeDotColor: ColorConstants.red,
          dotHeight: 6.0,
          dotWidth: 6.0,
        ),
      );

  Widget buildCarousal(String title, String subtitle, String time, String image) => Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: ColorConstants.yellow, borderRadius: BorderRadius.circular(20)),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 15),
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Text(subtitle, style: TextStyle(color: ColorConstants.red, fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.access_time_filled, color: Colors.red, size: 16),
                    const SizedBox(width: 10),
                    Text(time, style: const TextStyle(fontWeight: FontWeight.bold)),
                  ],
                )
              ],
            ),
            const Spacer(),
            SizedBox(height: 100, width: 150, child: Image.asset(image, fit: BoxFit.contain)),
          ],
        ),
      );

  Widget categorySection() => SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.all(8),
        child: Wrap(
          spacing: 6,
          children: const [
            ColumnCatgContainer(imagePath: "assets/images/breakfast.png", catgName: "Breakfast"),
            ColumnCatgContainer(imagePath: "assets/images/lunch.png", catgName: "Lunch"),
            ColumnCatgContainer(imagePath: "assets/images/dinner.png", catgName: "Dinner"),
            ColumnCatgContainer(imagePath: "assets/images/supper.png", catgName: "Supper"),
          ],
        ),
      );

  Widget pickedForYouSection(List items) => Padding(
        padding: const EdgeInsets.all(16),
        child: AlignedGridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 30,
          crossAxisSpacing: 10,
          itemCount: items.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) => recipeCard(items[index], index),
        ),
      );

  Widget popularRecipes(List items) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: HorizontalListView.builder(
          itemCount: items.length,
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          itemBuilder: (context, index) => recipeCard(items[index], index),
        ),
      );

  Widget recipeCard(dynamic recipe, int index) => Stack(
        clipBehavior: Clip.none,
        children: [
          InkWell(
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => RecipeDetails())),
            child: Container(
              margin: const EdgeInsets.only(top: 60, bottom: 15),
              padding: const EdgeInsets.only(top: 60, left: 10, right: 10, bottom: 40),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 40),
                  Text(recipe.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14), textAlign: TextAlign.center),
                  const SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(5, (i) {
                      return Icon(i < recipe.rating.floor() ? Icons.star : Icons.star_border, size: 14, color: ColorConstants.yellow);
                    }),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.access_time, size: 14, color: Colors.red),
                      const SizedBox(width: 4),
                      Text(recipe.time, style: const TextStyle(fontSize: 12)),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: GestureDetector(
              onTap: () {
                context.read<HomeBloc>().add(ToggleLikeRecipeEvent(index));
              },
              child: Container(
                height: 30,
                width: 30,
                decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.amber),
                child: Icon(recipe.isLiked ? Icons.favorite : Icons.favorite_border,
                    color: recipe.isLiked ? Colors.red : Colors.yellow, size: 17),
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: CircleAvatar(radius: 60, backgroundColor: Colors.white, backgroundImage: AssetImage(recipe.imagePath)),
          ),
        ],
      );
}
