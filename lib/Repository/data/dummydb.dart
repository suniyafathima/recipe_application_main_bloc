import 'package:recipe_application_main/features/home/model/recipe_model.dart';
import 'package:recipe_application_main/features/list_screen/model/ingredient_model.dart';

class Dummydb {
  static List<IngredientModel> ingredients=[
     IngredientModel(name: "Egg", quantity: "1 item",isChecked: false),
     IngredientModel(name: "Cabbage", quantity: "2 gr",isChecked: false),
     IngredientModel(name: "Onion", quantity: "2 chopped",isChecked: false),
     IngredientModel(name: "prawns", quantity: "1/2 gr",isChecked: false),
     IngredientModel(name: "Ketchup", quantity: "1/3 tsp",isChecked: false),
  ];
  
  static List<Recipemodel> items = [
  Recipemodel(imagePath: "assets/images/chickenzuccini.jpg", name: "Chicken zuccini", rating: 4.5, time: "25m"),
  Recipemodel(imagePath: "assets/images/easybourboncake.jpg", name: "Easy bourbon cake", rating: 4, time: "20m"),
  Recipemodel(imagePath: "assets/images/noodles.jpg", name: "Chilly Egg noodles", rating: 3.5, time: "30m"),
  Recipemodel(imagePath: "assets/images/Potatofry.jpg", name: "Crispy Potato fry", rating: 5, time: "25m"),
  Recipemodel(imagePath: "assets/images/Sourcreamfried.jpg", name: "Sourcream fried chicken", rating: 5, time: "32m"),
  Recipemodel(imagePath: "assets/images/vegopesto.jpg", name: "Sego pesto pasta", rating: 1, time: "15m"),
  Recipemodel(imagePath: "assets/images/butterchicken.jpg", name: "Butter chicken", rating: 4.9, time: "20m", isLiked: false),
];
  
  static List<Map<String, dynamic>> steps = [
      {
        "instruction": "Place noodles in a heatproof bowl. Cover with boiling water. Set aside for 5 mins or until noodles separate. Drain.",
        "duration": 60
      },
      {
        "instruction": "Heat oil in a wok. Add curry powder and stir-fry for 1 min. Add oyster sauce, soy sauce, noodles, and ½ cup (125ml) water. Stir-fry for 2 mins until combined.",
        "duration": 90
      },
      {
        "instruction": "Add peas, choy sum, wombok, and spring onion. Stir-fry for 1-2 mins until wombok wilts. Serve hot.",
        "duration": 30
      }
    ];
}