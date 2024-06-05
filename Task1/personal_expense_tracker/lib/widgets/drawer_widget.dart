import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';
import '../screens/category_screen.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: Text('Menu'),
            automaticallyImplyLeading: false,
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Categories'),
            onTap: () {
              Navigator.of(context).pushNamed(CategoryScreen.routeName);
            },
          ),
          ListTile(
            leading: Icon(themeProvider.themeMode == ThemeMode.light
                ? Icons.dark_mode
                : Icons.light_mode),
            title: Text('Toggle Theme'),
            onTap: () {
              themeProvider.toggleTheme();
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
