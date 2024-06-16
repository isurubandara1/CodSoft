import 'package:flutter/material.dart';
import 'api_service.dart';
import 'models/meal.dart';
import 'recipe_detail_page.dart';

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
              return Container(
                height: 120, // Adjust the height of the ListTile
                padding: EdgeInsets.all(8), // Padding around the ListTile
                child: Center(
                  child: Card(
                    color: Colors.orange, // Set background color to orange
                    child: ListTile(
                      contentPadding:
                          EdgeInsets.all(8), // Padding inside the ListTile
                      leading: ClipOval(
                        child: Image.network(
                          results[index].thumbnail,
                          width: 80, // Set width to maintain aspect ratio
                          height: 80, // Set height to maintain aspect ratio
                          fit: BoxFit.cover,
                        ),
                      ),
                      title: Text(
                        results[index].name,
                        style: TextStyle(
                          fontSize: 18, // Adjust the font size
                          color: Colors.white, // Set text color to white
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                RecipeDetailPage(meal: results[index]),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder(
      future: apiService.searchMealByName(query),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData ||
            (snapshot.data as Map<String, dynamic>)['meals'] == null) {
          return Center(child: Text('No suggestions found'));
        } else {
          final List<Meal> suggestions = (snapshot.data!['meals'] as List)
              .map((json) => Meal.fromJson(json))
              .toList();
          return ListView.builder(
            itemCount: suggestions.length,
            itemBuilder: (context, index) {
              return Container(
                height: 100, // Adjust the height of the ListTile
                padding: EdgeInsets.all(8), // Padding around the ListTile
                child: Center(
                  child: Card(
                    color: Colors.orange, // Set background color to orange
                    child: ListTile(
                      contentPadding:
                          EdgeInsets.all(8), // Padding inside the ListTile
                      leading: ClipOval(
                        child: Image.network(
                          suggestions[index].thumbnail,
                          width: 80, // Set width to maintain aspect ratio
                          height: 80, // Set height to maintain aspect ratio
                          fit: BoxFit.cover,
                        ),
                      ),
                      title: Text(
                        suggestions[index].name,
                        style: TextStyle(
                          fontSize: 18, // Adjust the font size
                          color: Colors.white, // Set text color to white
                        ),
                      ),
                      onTap: () {
                        query = suggestions[index].name;
                        showResults(context);
                      },
                    ),
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }
}
