import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import 'models/meal.dart';

class RecipeDetailPage extends StatefulWidget {
  final Meal meal;

  RecipeDetailPage({required this.meal});

  @override
  _RecipeDetailPageState createState() => _RecipeDetailPageState();
}

class _RecipeDetailPageState extends State<RecipeDetailPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 1))
          ..repeat(reverse: true); // Repeating the animation
    _animation = Tween(begin: -0.1, end: 0.1).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double imageWidth = MediaQuery.of(context).size.width - 20;

    return Scaffold(
        appBar: AppBar(
          title: Text(
            widget.meal.name + ' Recipe',
            style: TextStyle(fontSize: 30),
          ),
          backgroundColor: Color.fromARGB(255, 243, 82, 33),
        ),
        body: Container(
          color: Colors.amber,
          child: Padding(
            padding:
                const EdgeInsets.only(left: 15, right: 15, bottom: 5, top: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AnimatedBuilder(
                  animation: _animation,
                  builder: (context, child) {
                    return Transform.rotate(
                      angle: _animation.value,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.network(
                          widget.meal.thumbnail,
                          width: imageWidth,
                          height: 250,
                          fit: BoxFit.fill,
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(height: 15.0),
                Container(
                  width: imageWidth,
                  child: ClipOval(
                    child: Container(
                      color: Color.fromARGB(255, 243, 82, 33),
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        widget.meal.name,
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 8.0),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Category: ${widget.meal.category}',
                          style: TextStyle(fontSize: 20.0),
                        ),
                        Text(
                          'Area: ${widget.meal.area}',
                          style: TextStyle(fontSize: 20.0),
                        ),
                        SizedBox(height: 10.0),
                        Text(
                          'Ingredients:',
                          style: TextStyle(
                              fontSize: 30.0, fontWeight: FontWeight.bold),
                        ),
                        for (int i = 0; i < widget.meal.ingredients.length; i++)
                          Text(
                            '${widget.meal.ingredients[i]} - ${widget.meal.measures[i]}',
                            style: TextStyle(fontSize: 20.0),
                          ),
                        SizedBox(height: 8.0),
                        Text(
                          'Instructions:',
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          widget.meal.instructions,
                          textAlign: TextAlign.start,
                          style: TextStyle(fontSize: 20.0),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
