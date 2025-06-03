class PreferenceModel {
  final String name;
  final bool isSelected;

  PreferenceModel({required this.name, this.isSelected = false});

  PreferenceModel copyWith({String? name, bool? isSelected}) {
    return PreferenceModel(
      name: name ?? this.name,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}
