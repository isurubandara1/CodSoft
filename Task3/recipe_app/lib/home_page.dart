import 'package:flutter/material.dart';
import 'api_service.dart';
import 'models/meal.dart';
import 'drawer_page.dart'; // Import the drawer page
import 'meal_search_delegate.dart'; // Import the search delegate

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  final ApiService apiService = ApiService();
  List<Meal> meals = [];
  bool isLoading = true;

  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    fetchRandomMeals();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    // Create a Tween animation for the button movement
    _animation = Tween<double>(begin: 0, end: 10).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    // Start animation
    _animationController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
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
        title: Text.rich(
          TextSpan(
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
            children: <TextSpan>[
              TextSpan(
                text: '𝐄𝐚𝐬𝐲',
                style: TextStyle(
                  color: Color.fromARGB(255, 235, 90, 23),
                  fontSize: 36,
                ),
              ),
              TextSpan(
                text: ' 𝐂𝐨𝐨𝐤𝐢𝐧𝐠',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ],
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
                context: context,
                delegate: MealSearchDelegate(apiService),
              );
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
              child: Opacity(
                opacity: 0.9,
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
                        'Unleash your inner chef with Easy Coookind App! Explore a world of delicious recipes for every taste bud. From quick weeknight meals to adventurous global cuisine, we have something for everyone. Find dishes that fit your dietary needs, with options for vegan, vegetarian, gluten-free, and paleo eaters.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.2),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: AnimatedBuilder(
                      animation: _animation,
                      builder: (context, child) {
                        return Transform.translate(
                          offset: Offset(0, _animation.value),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.white,
                                  width: 3), // White border
                              borderRadius: BorderRadius.circular(
                                  35), // Adjust border radius as needed
                            ),
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                primary: Colors.orange, // Button color
                                padding: EdgeInsets.symmetric(
                                    horizontal: 50,
                                    vertical: 11), // Button padding
                                textStyle: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold), // Text style
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  RichText(
                                    text: TextSpan(
                                      style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromARGB(
                                            255, 235, 90, 23), // Default color
                                      ),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: '𝐆',
                                          style: TextStyle(
                                            fontSize: 27,
                                            color: Color.fromARGB(
                                                255, 235, 90, 23),
                                          ),
                                        ),
                                        TextSpan(
                                          text: '𝐞𝐭 𝐒𝐭𝐚𝐫𝐭',
                                          style: TextStyle(
                                            color: Color.fromARGB(255, 255, 255,
                                                255), // Color for the rest of the text
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Image.asset(
                                    'assets/images/cookerman.png',
                                    fit: BoxFit.fill,
                                    width: 80,
                                    height: 45,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color.fromARGB(255, 235, 90, 23),
                                    ),
                                    padding: EdgeInsets.all(
                                        10), // Adjust padding as needed
                                    child: Icon(
                                      Icons.chevron_right,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
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
