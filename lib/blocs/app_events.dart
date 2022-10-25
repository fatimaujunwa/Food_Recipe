import 'package:equatable/equatable.dart';
import 'package:food_recipe_review/category_model.dart';

import '../ReceipeModel.dart';

abstract class UserEvent extends Equatable{}
abstract class FoodEvent extends Equatable{}
abstract class FoodIngredientsEvent extends Equatable{}
abstract class SelectEvent extends Equatable{}
abstract class FoodCategoryEvent extends Equatable{}

class LoadFoodIngredientEvent extends FoodIngredientsEvent {
  LoadFoodIngredientEvent(this.meadID);
 String meadID;
  @override
  List<Object?> get props=>[];


}

class LoadingFoodIngredientEvent extends FoodIngredientsEvent {

  @override
  List<Object?> get props=>[];


}


class LoadUserEvent extends UserEvent{
  @override
  List<Object?> get props=>[];

}
//onr event can rep multiple states
class FoodRecipe extends FoodEvent{
  @override
  List<Object?> get props=>[];

}
class FoodCategory extends FoodCategoryEvent{
  FoodCategory(this.foodCat);
  final String foodCat;

  @override
  List<Object?> get props=>[foodCat];

}
class SelectID extends SelectEvent{
  SelectID(this.selectedId);
  final int selectedId;

  @override
  List<Object?> get props=>[selectedId];

}
class InitID extends SelectEvent{
  InitID(this.selectedId);
  final int selectedId;

  @override
  List<Object?> get props=>[selectedId];

}

class Initial extends FoodCategoryEvent{
  @override
  List<Object?> get props=>[];

}


//
class CategoryEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetCategories extends CategoryEvent {}

class SelectCategory extends CategoryEvent {
  SelectCategory({
    required this.idSelected,
  });
  final int idSelected;

  @override
  List<Object?> get props => [idSelected];
}


