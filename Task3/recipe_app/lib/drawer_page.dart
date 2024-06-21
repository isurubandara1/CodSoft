import 'package:flutter/material.dart';
import 'package:recipe_app/api_service.dart';
import 'package:recipe_app/home_page.dart';
import 'package:recipe_app/meal_search_delegate.dart';

class DrawerPage extends StatelessWidget {
  final ApiService apiService = ApiService();
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Center(
              child: Column(
                children: [
                  Text(
                    'Easy Cooking',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Image.asset(
                    'assets/images/cookerman.png',
                    fit: BoxFit.fill,
                    height: 80,
                    width: 120,
                  ),
                ],
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.orange,
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text(
              'Home',
              style: TextStyle(
                  fontSize: 22,
                  color: Colors.brown,
                  fontWeight: FontWeight.bold),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HomePage(),
                ),
              );
            },
          ),
          SizedBox(
            height: 10,
          ),
          ListTile(
            leading: const Icon(Icons.search),
            title: const Text(
              'Search',
              style: TextStyle(
                  fontSize: 22,
                  color: Colors.brown,
                  fontWeight: FontWeight.bold),
            ),
            onTap: () {
              showSearch(
                context: context,
                delegate: MealSearchDelegate(apiService),
              );
            },
          ),
          SizedBox(
            height: 10,
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text(
              'About',
              style: TextStyle(
                  fontSize: 22,
                  color: Colors.brown,
                  fontWeight: FontWeight.bold),
            ),
            onTap: () {
              // Navigate to the home screen
            },
          ),
          SizedBox(
            height: 10,
          ),
          ListTile(
            leading: const Icon(Icons.share),
            title: const Text(
              'Share App',
              style: TextStyle(
                  fontSize: 22,
                  color: Colors.brown,
                  fontWeight: FontWeight.bold),
            ),
            onTap: () {
              // Navigate to the home screen
            },
          ),
          SizedBox(
            height: 10,
          ),
          ListTile(
            leading: const Icon(Icons.get_app),
            title: const Text(
              'More Apps',
              style: TextStyle(
                  fontSize: 22,
                  color: Colors.brown,
                  fontWeight: FontWeight.bold),
            ),
            onTap: () {
              // Navigate to the settings screen
            },
          ),
          SizedBox(
            height: 10,
          ),
          ListTile(
            leading: const Icon(Icons.star),
            title: const Text(
              'Rate App',
              style: TextStyle(
                  fontSize: 22,
                  color: Colors.brown,
                  fontWeight: FontWeight.bold),
            ),
            onTap: () {
              // Navigate to the about screen
            },
          ),
        ],
      ),
    );
  }
}
