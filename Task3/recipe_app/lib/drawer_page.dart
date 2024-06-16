import 'package:flutter/material.dart';
import 'package:recipe_app/home_page.dart';

class DrawerPage extends StatelessWidget {
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
            title: const Text('Home'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HomePage(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.search),
            title: const Text('Search'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.account_box_outlined),
            title: const Text('About'),
            onTap: () {
              // Navigate to the home screen
            },
          ),
          ListTile(
            leading: const Icon(Icons.share),
            title: const Text('Share App'),
            onTap: () {
              // Navigate to the home screen
            },
          ),
          ListTile(
            leading: const Icon(Icons.get_app),
            title: const Text('More Apps'),
            onTap: () {
              // Navigate to the settings screen
            },
          ),
          ListTile(
            leading: const Icon(Icons.star),
            title: const Text('Rate App'),
            onTap: () {
              // Navigate to the about screen
            },
          ),
        ],
      ),
    );
  }
}
