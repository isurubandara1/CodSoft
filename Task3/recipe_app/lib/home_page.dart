import 'package:flutter/material.dart';
import 'api_service.dart';
import 'models/meal.dart';
import 'drawer_page.dart'; // Import the drawer page
import 'meal_search_delegate.dart'; // Import the search delegate

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
    fetchRandomMeals();
  }

  void fetchRandomMeals() async {
    try {
      final data = await apiService.getRandomMeals();
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
        backgroundColor: Colors.orange,
        title: Text(
          'Recipe App',
          style: TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.white,
              size: 35,
            ),
            onPressed: () {
              showSearch(
                  context: context, delegate: MealSearchDelegate(apiService));
            },
          ),
        ],
      ),
      drawer: DrawerPage(), // Use the DrawerPage widget here
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              'assets/images/Home.jpg',
              width: double.infinity,
              height: 800,
              fit: BoxFit.fill,
            ),
          ],
        ),
      ),
    );
  }
}
