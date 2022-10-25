import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_recipe_review/ReceipeModel.dart';
import 'package:food_recipe_review/blocs/app_states.dart';
import 'package:food_recipe_review/category_model.dart';

import '../model.dart';
import '../repos/repository.dart';
import 'app_events.dart';

class UserBloc extends Bloc<UserEvent, UserState>{
  final UserRepository _userRepository;
  UserBloc(this._userRepository):super(UserLoadingState()){
    on<LoadUserEvent>((event, emit)async{
      emit(UserLoadingState());

   try{
     final List<Users> users=await _userRepository.getUsers();

     emit(UserLoadedState(users));
   }catch(e){
emit(UserErrorState(e.toString()));
   }
// emit(create());
    });
  }

}

class FoodBloc extends Bloc<FoodEvent,FoodState>{
  final FoodRepository _foodRepository;

  FoodBloc(this._foodRepository):super(FoodLoadingState()){
on<FoodEvent>((event, emit) async {
  emit(FoodLoadingState());
  print('loading');
  final List<Meals> food=await _foodRepository.getFoodRecipe();

  emit(FoodLoadedState(food));

  // try{
  //   final List<Recipe> food=await _foodRepository.getFoodRecipe();
  //
  //   emit(FoodLoadedState(food));
  //   print('loaded');
  // }catch(e){
  //   emit(FoodErrorState(e.toString()));
  // }
});
  }
}

class FoodIngredientBloc extends Bloc<FoodIngredientsEvent,FoodIngredientState>{
  final FoodRepository _foodRepository;

  FoodIngredientBloc(this._foodRepository):super(FoodIngredientLoadingState()){
    on<LoadingFoodIngredientEvent>((event, emit) async {
      emit(FoodIngredientLoadingState());
      print('loading');



      // try{
      //   final List<Recipe> food=await _foodRepository.getFoodRecipe();
      //
      //   emit(FoodLoadedState(food));
      //   print('loaded');
      // }catch(e){
      //   emit(FoodErrorState(e.toString()));
      // }
    });

    on<LoadFoodIngredientEvent>((event, emit) async {

      print('load');

      final  List<Meals> food=await _foodRepository.getFoodIngredients(event.meadID);

      emit(FoodIngredientLoadedState(food));

      // try{
      //   final List<Recipe> food=await _foodRepository.getFoodRecipe();
      //
      //   emit(FoodLoadedState(food));
      //   print('loaded');
      // }catch(e){
      //   emit(FoodErrorState(e.toString()));
      // }
    });
  }
}
class FoodCatBloc extends Bloc<FoodCategoryEvent,FoodCateState>{
  final FoodRepository _foodRepository;

  FoodCatBloc(this._foodRepository):super(InitialState()){
    on<FoodCategory>((event, emit) async {
      emit(InitialState());
      print('loading');





      try{
        final List<MealCategory> cat=await _foodRepository.getFoodCategory(event.foodCat);

        emit(CategoryLoadedState(cat));
        print('loaded');
      }catch(e){
        emit(CategoryErrorState(e.toString()));
      }
    });

    on<Initial>((event, emit)async{
      Future.delayed(Duration(seconds: 6));
      final List<MealCategory> cat=await _foodRepository.getFoodCategory('Side');

      emit(TestState(cat));
    });
  }
}

class ColorBloc extends Bloc<SelectEvent,SelectedState>{


  ColorBloc():super(InitSelection()){
    on<SelectID>((event, emit) async {
      emit(SelectedID(event.selectedId));
// emit(CateID(event.selectedId));
      // try{
      //   final List<Recipe> food=await _foodRepository.getFoodRecipe();
      //
      //   emit(FoodLoadedState(food));
      //   print('loaded');
      // }catch(e){
      //   emit(FoodErrorState(e.toString()));
      // }
    });
    on<InitID>((event, emit) async{
      emit(TestSelection(0));
    });
  }
}

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc({
    required this.foodRepository,
  }) : super(const CategoryState()) {
    on<GetCategories>(_mapGetCategoriesEventToState);
    on<SelectCategory>(_mapSelectCategoryEventToState);
  }
  final FoodRepository foodRepository;

  void _mapGetCategoriesEventToState(
      GetCategories event, Emitter<CategoryState> emit) async {
    emit(state.copyWith(status: CategoryStatus.loading));
    try {
      final genres = await foodRepository.getFoodRecipe();
      emit(
        state.copyWith(
          status: CategoryStatus.success,
          categories: genres,
        ),
      );
    } catch (error, stacktrace) {
      print(stacktrace);
      emit(state.copyWith(status: CategoryStatus.error));
    }
  }

  void _mapSelectCategoryEventToState(
      SelectCategory event, Emitter<CategoryState> emit) async {
    emit(
      state.copyWith(
        status: CategoryStatus.selected,
        idSelected: event.idSelected,
      ),
    );
  }


}
class CounterCubit extends Cubit<int> {
  CounterCubit() : super(0);

  void increment() => emit(state + 1);
  void decrement() => emit(state - 1);
}

// class NavCubit extends Cubit<Post>{
//
// }