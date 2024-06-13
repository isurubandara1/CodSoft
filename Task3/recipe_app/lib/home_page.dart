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
      body: Container(
        height: double.infinity,
        child: Stack(
          children: [
            // Background image with opacity
            Positioned.fill(
              child: Container(
                color: Colors.black.withOpacity(0.2),
                child: Image.asset(
                  'assets/images/Home.jpg',
                  fit: BoxFit.fitHeight,
                  height: double.infinity,
                ),
              ),
            ),
            // Content
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.2),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Opacity(
                      opacity: 1,
                      child: Text(
                        'Unleash your inner chef with [App Name]! Explore a world of delicious recipes for every taste bud. From quick weeknight meals to adventurous global cuisine, we have something for everyone. Find dishes that fit your dietary needs, with options for vegan, vegetarian, gluten-free, and paleo eaters. Download [App Name] today - free and packed with features to turn you into a kitchen rockstar!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        primary: Colors.orange, // Button color
                        padding: EdgeInsets.symmetric(
                            horizontal: 80, vertical: 11), // Button padding
                        textStyle: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold), // Text style
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Go ahead',
                            style: TextStyle(color: Colors.white),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            padding:
                                EdgeInsets.all(10), // Adjust padding as needed
                            child: Icon(
                              Icons.chevron_right,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 16), // Space below button
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
