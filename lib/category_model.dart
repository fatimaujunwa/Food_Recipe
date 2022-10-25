class Category {
  List<MealCategory>? meals;

  Category({this.meals});

  Category.fromJson(Map<String, dynamic> json) {
    if (json['meals'] != null) {
      meals = <MealCategory>[];
      json['meals'].forEach((v) {
        meals!.add(new MealCategory.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.meals != null) {
      data['meals'] = this.meals!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MealCategory {
  String? strMeal;
  String? strMealThumb;
  String? idMeal;

  MealCategory({this.strMeal, this.strMealThumb, this.idMeal});

  MealCategory.fromJson(Map<String, dynamic> json) {
    strMeal = json['strMeal'];
    strMealThumb = json['strMealThumb'];
    idMeal = json['idMeal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['strMeal'] = this.strMeal;
    data['strMealThumb'] = this.strMealThumb;
    data['idMeal'] = this.idMeal;
    return data;
  }
}

