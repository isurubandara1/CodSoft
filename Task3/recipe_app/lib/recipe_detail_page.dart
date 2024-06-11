import 'package:flutter/material.dart';
import 'models/meal.dart';

class RecipeDetailPage extends StatelessWidget {
  final Meal meal;

  RecipeDetailPage({required this.meal});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(meal.name),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(meal.thumbnail),
            SizedBox(height: 8.0),
            Text(
              meal.name,
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(
              'Category: ${meal.category}',
              style: TextStyle(fontSize: 16.0),
            ),
            Text(
              'Area: ${meal.area}',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 8.0),
            Text(
              'Ingredients:',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            for (int i = 0; i < meal.ingredients.length; i++)
              Text(
                '${meal.ingredients[i]} - ${meal.measures[i]}',
                style: TextStyle(fontSize: 16.0),
              ),
            SizedBox(height: 8.0),
            Text(
              'Instructions:',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            Text(
              meal.instructions,
              style: TextStyle(fontSize: 16.0),
            ),
          ],
        ),
      ),
    );
  }
}
