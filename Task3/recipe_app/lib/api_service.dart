import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "https://www.themealdb.com/api/json/v1/1";

  Future<Map<String, dynamic>> searchMealByName(String name) async {
    final response = await http.get(Uri.parse('$baseUrl/search.php?s=$name'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load meal');
    }
  }

  Future<Map<String, dynamic>> listMealsByFirstLetter(String letter) async {
    final response = await http.get(Uri.parse('$baseUrl/search.php?f=$letter'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load meals');
    }
  }

  Future<Map<String, dynamic>> lookupMealById(String id) async {
    final response = await http.get(Uri.parse('$baseUrl/lookup.php?i=$id'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load meal');
    }
  }

  Future<Map<String, dynamic>> getRandomMeal() async {
    final response = await http.get(Uri.parse('$baseUrl/random.php'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load random meal');
    }
  }

  Future<Map<String, dynamic>> listMealCategories() async {
    final response = await http.get(Uri.parse('$baseUrl/categories.php'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load categories');
    }
  }

  Future<Map<String, dynamic>> getRandomMeals() async {
    final response = await http.get(Uri.parse('$baseUrl/randomselection.php'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load random meals');
    }
  }
}
