import 'package:equatable/equatable.dart';
import 'package:food_recipe_review/ReceipeModel.dart';
import 'package:food_recipe_review/category_model.dart';

import '../model.dart';
// basically one event generating multible states so they all extend same equatable
abstract class UserState extends Equatable{}
abstract class FoodCateState extends Equatable{}
abstract class SelectedState extends Equatable{}
abstract class FoodIngredientState extends Equatable{}
class UserLoadingState extends UserState{
  @override
  List<Object?> get props=>[];
}
class FoodIngredientLoadingState extends FoodIngredientState{
  @override
  List<Object?> get props=>[];
}
class FoodIngredientLoadedState extends FoodIngredientState{
  FoodIngredientLoadedState(this.ingredients);
   final  List<Meals> ingredients;
  @override
  List<Object?> get props=>[ingredients];
}

class UserLoadedState extends UserState{
  UserLoadedState(this.users);
  final List<Users> users;
  @override
  List<Object?> get props=>[users];
}

class UserErrorState extends UserState{
  UserErrorState(this.error);
  final String error; //this is used if you want return something from server
  @override
  List<Object?> get props=>[error];
}
class create extends UserState{
  create(this.error);
  final String error;
  @override
  List<Object?> get props=>[error];
}

abstract class FoodState extends Equatable{}
class FoodLoadingState extends FoodState{
  @override
  List<Object?> get props=>[];
}
class FoodLoadedState extends FoodState{
  FoodLoadedState(this.food);
  final List<Meals> food;
  @override
  List<Object?> get props=>[food];
}

class FoodErrorState extends FoodState{
  FoodErrorState(this.error);
  final String error; //this is used if you want return something from server
  @override
  List<Object?> get props=>[error];
}
class InitialState extends FoodCateState{

  @override
  List<Object?> get props=>[];
}

class TestState extends FoodCateState{
  TestState(this.food);
  final List<MealCategory> food;
  @override
  List<Object?> get props=>[food];
}



class InitSelection extends SelectedState{

@override
  List<Object?> get props=>[];
}
class TestSelection extends SelectedState{
  final int selectedId=0;
  TestSelection(selectedId);
  @override
  List<Object?> get props=>[selectedId];
}

class CategoryLoadedState extends FoodCateState{
  CategoryLoadedState(this.food);
  final List<MealCategory> food;
  @override
  List<Object?> get props=>[food];
}

class CategoryErrorState extends FoodCateState{
  CategoryErrorState(this.error);
  final String error;
  @override
  List<Object?> get props=>[error];
}


class SelectedID extends SelectedState{
  SelectedID(this.selectedId);
  final int selectedId;
  @override
  List<Object?> get props=>[selectedId];
}
class CateID extends SelectedState{
  CateID (this.cate);
  final int cate;
  @override
  List<Object?> get props=>[cate];
}






enum CategoryStatus { initial, success, error, loading, selected }

extension CategoryStatusX on CategoryStatus {
  bool get isInitial => this == CategoryStatus.initial;
  bool get isSuccess => this == CategoryStatus.success;
  bool get isError => this == CategoryStatus.error;
  bool get isLoading => this == CategoryStatus.loading;
  bool get isSelected => this == CategoryStatus.selected;
}

class CategoryState extends Equatable {
  const CategoryState({
    this.status = CategoryStatus.initial,
    List<Meals>? categories,
    int idSelected = 0,
  })  : categories = categories ?? const [],
        idSelected = idSelected;

  final List<Meals> categories;
  final CategoryStatus status;
  final int idSelected;

  @override
  List<Object?> get props => [status, categories, idSelected];

  CategoryState copyWith({
    List<Meals>? categories,
    CategoryStatus? status,
    int? idSelected,
  }) {
    return CategoryState(
      categories: categories ?? this.categories,
      status: status ?? this.status,
      idSelected: idSelected ?? this.idSelected,
    );
  }
}