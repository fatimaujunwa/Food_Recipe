import 'dart:convert';


import 'package:food_recipe_review/ReceipeModel.dart';
import 'package:food_recipe_review/category_model.dart';
import 'package:http/http.dart';

import '../model.dart';
class UserRepository{
  String endpoint='https://reqres.in/api/users?page=2';
 Future<List<Users>> getUsers()async{
    Response response=await get(Uri.parse(endpoint));
    if(response.statusCode==200){
      final List result=jsonDecode(response.body)['data'];

      //take a normal list and make it list of users
return result.map((e) => Users.fromJson(e)).toList();
    }
    else{
      // print(response.statusCode);
      throw Exception(response.reasonPhrase);
    }
  }
}
class FoodRepository{
  String endpoint='https://www.themealdb.com/api/json/v1/1/search.php?f=b';
  String categoryEndpoint='https://www.themealdb.com/api/json/v1/1/search.php?f=https://www.themealdb.com/api/json/v1/1/filter.php?c=Seafood';
 Future<List<Meals>> getFoodRecipe()async{
    Response response=await get(Uri.parse(endpoint));
    if(response.statusCode==200){
      Map<String, dynamic> map = json.decode(response.body);
      List result=map["meals"];
      print(result[0]["meals"]);

      return result.map((e) => Meals.fromJson(e)).toList();
    }
    else{
      // print(response.statusCode);
      throw Exception(response.reasonPhrase);
    }

  }

 List<Meals>result=[];
  Future<List<Meals>> getFoodIngredients(String mealID)async{
    Response response=await get(Uri.parse("https://www.themealdb.com/api/json/v1/1/lookup.php?i=$mealID"));
    // print("index:"+response.body);
    if(response.statusCode==200){
      Map<String, dynamic> map = json.decode(response.body);

      List result=map["meals"];
      print(result[0]["meals"]);

      return result.map((e) => Meals.fromJson(e)).toList();




    }
    else{
      throw Exception(response.reasonPhrase);


    }


  }

  Future<List<MealCategory>> getFoodCategory(String foodCat)async{
    Response response=await get(Uri.parse('https://www.themealdb.com/api/json/v1/1/filter.php?c=$foodCat'));
    if(response.statusCode==200){

      Map<String, dynamic> map = json.decode(response.body);
      List result=map["meals"];
      print(result.length);


      return result.map((e) => MealCategory.fromJson(e)).toList();
    }
    else{
      // print(response.statusCode);
      throw Exception(response.reasonPhrase);
    }

  }

}