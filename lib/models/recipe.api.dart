import 'dart:convert';
import 'package:xml_programming/models/recipe.dart';
import 'package:http/http.dart' as http;

class RecipeApi {
  /* help for code
  var req = unirest("GET", "https://yummly2.p.rapidapi.com/feeds/list");

  req.query({
  "start": "0",
  "limit": "18",
  "tag": "list.recipe.popular"
  });

  req.headers({
  "x-rapidapi-key": "57752647cbmsh24bf6541d3b9574p1364a6jsn53009f0d5d29",
  "x-rapidapi-host": "yummly2.p.rapidapi.com",
  "useQueryString": trues
  });

   */

  static Future<List<Recipe>> getRecipe() async{
    var uri = Uri.https('yummly2.p.rapidapi.com', '/feeds/list',{"start": "12", "limit": "40", "tag": "list.recipe.popular"});
    final response = await http.get(uri,headers: {
      "x-rapidapi-key": "57752647cbmsh24bf6541d3b9574p1364a6jsn53009f0d5d29",
      "x-rapidapi-host": "yummly2.p.rapidapi.com",
      "useQueryString": "true"
    });

    Map data = jsonDecode(response.body);
    List _temp = [];

    for (var a in data['feed']){
      _temp.add(a['content']['details']);
    }

    return Recipe.recipesFromSnapshot(_temp);

  }

}