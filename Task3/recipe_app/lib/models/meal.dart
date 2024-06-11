class Meal {
  final String id;
  final String name;
  final String category;
  final String area;
  final String instructions;
  final String thumbnail;
  final List<String> ingredients;
  final List<String> measures;

  Meal({
    required this.id,
    required this.name,
    required this.category,
    required this.area,
    required this.instructions,
    required this.thumbnail,
    required this.ingredients,
    required this.measures,
  });

  factory Meal.fromJson(Map<String, dynamic> json) {
    List<String> ingredients = [];
    List<String> measures = [];
    for (int i = 1; i <= 20; i++) {
      String ingredient = json['strIngredient$i'];
      String measure = json['strMeasure$i'];
      if (ingredient.isNotEmpty) {
        ingredients.add(ingredient);
        measures.add(measure);
      }
    }
    return Meal(
      id: json['idMeal'],
      name: json['strMeal'],
      category: json['strCategory'],
      area: json['strArea'],
      instructions: json['strInstructions'],
      thumbnail: json['strMealThumb'],
      ingredients: ingredients,
      measures: measures,
    );
  }
}
