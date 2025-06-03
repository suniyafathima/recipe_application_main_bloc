class AllergyModel {
  final List<String> defaultAllergies;
  final List<String> selectedAllergies;
  final List<String> addedAllergies;
  final bool hasAllergy;

  AllergyModel({
    required this.defaultAllergies,
    required this.selectedAllergies,
    required this.addedAllergies,
    required this.hasAllergy,
  });

  AllergyModel copyWith({
    List<String>? selectedAllergies,
    List<String>? addedAllergies,
    bool? hasAllergy,
  }) {
    return AllergyModel(
      defaultAllergies: defaultAllergies,
      selectedAllergies: selectedAllergies ?? this.selectedAllergies,
      addedAllergies: addedAllergies ?? this.addedAllergies,
      hasAllergy: hasAllergy ?? this.hasAllergy,
    );
  }

  static AllergyModel initial() {
    return AllergyModel(
      defaultAllergies: [
        'Wheat', 'Dairy', 'Tree Nuts', 'Tomatoes', 'Egg', 'Chicken', 'Beef', 'Vegan', 'Gluten'
      ],
      selectedAllergies: [],
      addedAllergies: [],
      hasAllergy: false,
    );
  }
}
