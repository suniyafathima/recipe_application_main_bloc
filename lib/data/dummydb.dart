import 'package:recipe_application_main/model/ingredient_model/ingredient_model.dart';

class Dummydb {
  static List<IngredientModel> ingredients=[
     IngredientModel(name: "Egg", quantity: "1 item",isChecked: false),
     IngredientModel(name: "Cabbage", quantity: "2 gr",isChecked: false),
     IngredientModel(name: "Onion", quantity: "2 chopped",isChecked: false),
     IngredientModel(name: "prawns", quantity: "1/2 gr",isChecked: false),
     IngredientModel(name: "Ketchup", quantity: "1/3 tsp",isChecked: false),
  ];
}