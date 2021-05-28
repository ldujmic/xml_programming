import 'package:flutter/material.dart';
import 'package:xml_programming/models/recipe.api.dart';
import 'package:xml_programming/models/recipe.dart';
import 'package:xml_programming/views/widgets/recipe_card.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Recipe> _recipes;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    getRecipies();
  }

  Future<void> getRecipies() async {
    _recipes = await RecipeApi.getRecipe();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.restaurant_menu, color: Colors.pinkAccent,),
              SizedBox(
                width: 10,
              ),
              Text('Food Recipe',style: TextStyle(color: Colors.pinkAccent.withOpacity(0.8))),
            ],
          ),
        ),
        body: isLoading
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
          itemCount: _recipes.length,
          itemBuilder: (context, index) {
            return
            RecipeCard(
                title: _recipes[index].name,
                cookTime: _recipes[index].totalTime,
                rating: _recipes[index].rating.toString(),
                thumbnailUrl: _recipes[index].images);

          },

        ));
  }


}
