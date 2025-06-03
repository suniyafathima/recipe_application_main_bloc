class Recipemodel {
  String imagePath;
  String name;
  double? rating;
  String time;
  bool isLiked;
  Recipemodel({
    required this.imagePath,
    required this.name,
    this.rating,
    this.time= "15min",//
    this.isLiked=false,
    });

  Recipemodel copyWith({
    String? imagePath,
    String? name,
    double? rating,
    String? time,
    bool? isLiked,
  }) {
    return Recipemodel(
      imagePath: imagePath ?? this.imagePath,
      name: name ?? this.name,
      rating: rating ?? this.rating,
      time: time ?? this.time,
      isLiked: isLiked ?? this.isLiked,
    );
  }
}

