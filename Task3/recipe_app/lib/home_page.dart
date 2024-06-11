import 'package:flutter/material.dart';
import 'api_service.dart';
import 'models/meal.dart';
import 'recipe_detail_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ApiService apiService = ApiService();
  List<Meal> meals = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchMeals();
  }

  void fetchMeals() async {
    try {
      final data = await apiService.listMealsByFirstLetter('a');
      setState(() {
        meals =
            (data['meals'] as List).map((json) => Meal.fromJson(json)).toList();
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  void searchMeals(String query) async {
    setState(() {
      isLoading = true;
    });
    try {
      final data = await apiService.searchMealByName(query);
      setState(() {
        meals =
            (data['meals'] as List).map((json) => Meal.fromJson(json)).toList();
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recipe App'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                  context: context, delegate: MealSearchDelegate(apiService));
            },
          )
        ],
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: meals.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Image.network(meals[index].thumbnail),
                  title: Text(meals[index].name),
                  subtitle: Text(meals[index].category),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            RecipeDetailPage(meal: meals[index]),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}

class MealSearchDelegate extends SearchDelegate {
  final ApiService apiService;

  MealSearchDelegate(this.apiService);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [IconButton(icon: Icon(Icons.clear), onPressed: () => query = '')];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder(
      future: apiService.searchMealByName(query),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData ||
            (snapshot.data as Map<String, dynamic>)['meals'] == null) {
          return Center(child: Text('No results found'));
        } else {
          final List<Meal> results = (snapshot.data!['meals'] as List)
              .map((json) => Meal.fromJson(json))
              .toList();
          return ListView.builder(
            itemCount: results.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: Image.network(results[index].thumbnail),
                title: Text(results[index].name),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          RecipeDetailPage(meal: results[index]),
                    ),
                  );
                },
              );
            },
          );
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }
}
