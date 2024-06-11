import 'package:flutter/material.dart';
import 'models/meal.dart';

class RecipeDetailPage extends StatelessWidget {
  final Meal meal;

  RecipeDetailPage({required this.meal});

  @override
  Widget build(BuildContext context) {
    double imageWidth = MediaQuery.of(context).size.width - 20;

    return Scaffold(
      appBar: AppBar(
        title: Text(""),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: ClipRRect(
                borderRadius:
                    BorderRadius.circular(20), // Makes a circular clip
                child: Image.network(
                  meal.thumbnail,
                  width: imageWidth,
                  height:
                      imageWidth, // To maintain aspect ratio, set height equal to width
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 5.0),
            Container(
              width: imageWidth,
              child: ClipOval(
                child: Container(
                  color: const Color.fromARGB(255, 243, 33,
                      180), // Background color of the circular title
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    meal.name,
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white, // Text color of the title
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Category: ${meal.category}',
              style: TextStyle(fontSize: 20.0),
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
