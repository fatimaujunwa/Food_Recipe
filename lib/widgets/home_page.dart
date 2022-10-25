import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_recipe_review/category_model.dart';
import 'package:food_recipe_review/text_dimensions.dart';
import 'package:food_recipe_review/widgets/new_page.dart';

import '../ReceipeModel.dart';
import '../app_colors.dart';
import '../blocs/app_blocs.dart';
import '../blocs/app_events.dart';
import '../blocs/app_states.dart';
import 'custom_textfield.dart';

enum Food {
  Salad,
  Breakfast,
  Side,
  Starter,
  Chicken,
  seafood,
  vegetarian,
  beef,
  dessert,
  pork
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GlobalKey<ScaffoldState> homeScreenKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    List food = [
      "Side",
      "Chicken",
      "Seafood",
      "Vegetarian",
      "Beef",
      "Dessert",
      "Pork"
    ];

    TextEditingController search = TextEditingController();
    List<MealCategory> mealList=[];
    List<Meals> meals=[];
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(left: 10.w, right: 10.w, top: 44.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Find the best cooking',
                      style: TextDimensions.style24RajdhaniW600WBlack,
                    ),
                    Text(
                      'recipes',
                      style: TextDimensions.style24RajdhaniW600WOrange,
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                CustomTextField(
                  icon: Icons.search,
                  hintText: 'Search',
                  // prefixIcon: false,
                  obsText: false,
                  suffixIcon: false,
                  height: 60.h,
                  width: 350.w,
                  prefixIcon: true,

                  color: AppColors.grey.withOpacity(0.13),
                  controller: search,
                ),
                SizedBox(
                  height: 35.h,
                ),
                Text(
                  'Category',
                  style: TextDimensions.style20RajdhaniW600Black,
                ),
                SizedBox(
                  height: 20.h,
                ),
              ],
            ),
          ),
          BlocBuilder<FoodBloc, FoodState>(
            builder: (context, state) {
              if (state is FoodLoadedState) {
                return Container(
                  margin: EdgeInsets.only(left: 10.w),
                    height: 44.h,
                    // alignment: Alignment.center,
                    width: 375.w,
                    child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (_, index) {
                          return


                            GestureDetector(
                            onTap: () {
                              context.read<ColorBloc>().add(SelectID(index));
                              context
                                  .read<FoodCatBloc>()
                                  .add(FoodCategory(food[index]));
                            },
                            child:
                                // Container(height: 100,width: 100,color: Colors.blue,)
                                BlocSelector<ColorBloc, SelectedState, bool>(
                              selector: (state) {
                                if(state is TestSelection){
                                  if(state.selectedId==0 && index==0){
                                    return true;
                                  }
                                }
                                if (state is SelectedID) {
                                  if (state.selectedId == index) {
                                    return true;
                                  }

                                }
                                return false;
                              },
                              builder: (context, state) {
                                return Container(
                                  height: 24.h,
                                  alignment: Alignment.center,
                                  width: 83.w,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15.r),
                                    color: state
                                        ? AppColors.orange
                                        : AppColors.grey.withOpacity(0.05),
                                  ),
                                  child: Text(
                                    food[index],
                                    style: state
                                        ? TextDimensions
                                            .style12RajdhaniW600White
                                        : TextDimensions
                                            .style12RajdhaniW600Orange,
                                  ),
                                );
                              },
                            ),
                          );
                        },
                        separatorBuilder: (_, index) {
                          return SizedBox(
                            width: 10,
                          );
                        },
                        itemCount: food.length));
              }
              return Center(
                child:CircularProgressIndicator(color: AppColors.orange,)
              );
            },
          ),
          SizedBox(
            height: 10.h,
          ),
          BlocBuilder<FoodCatBloc, FoodCateState>(builder: (context, state) {
            if (state is TestState) {
              List<MealCategory> meal = state.food;

              return
                Expanded(
                  child: GridView.builder(
                    itemCount: meal.length,
                    itemBuilder: (_, index) {
                          (){



                      }();
                      return GestureDetector(
                        onTap: () {
                          context.read<FoodIngredientBloc>();
                          Navigator.of(context).push(NewPage.route(context,meal[index].idMeal!));
                       
                        },

                        child: Container(
                            height: 200.h,
                            margin: EdgeInsets.only(
                              left: 10.w,
                              bottom: 20.h,
                              right: 10.w,
                            ),
                            width: 200.w,

                            child: Container(
                              padding: EdgeInsets.only(
                                top: 5.h,
                                left: 10.w,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(30.r),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey.withOpacity(0.3),
                                      offset: Offset(1, 10),
                                      blurRadius: 10),
                                  BoxShadow(
                                      color: Colors.grey.withOpacity(0.3),
                                      offset: Offset(0, 10),
                                      blurRadius: 10)
                                ],

                                image: DecorationImage(
                                  image: NetworkImage(
                                      meal[index].strMealThumb!),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              // child: ,
                            )),
                      );
                    },
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, childAspectRatio: 1),
                  ),
                );
            }
            if (state is CategoryLoadedState) {
              List<MealCategory> meal = state.food;

              return
                Expanded(
                  child: GridView.builder(
                    itemCount: meal.length,
                    itemBuilder: (_, index) {
                          (){



                      }();
                      return GestureDetector(
                        onTap: () {

                        },

                        child: Container(
                            height: 200.h,
                            margin: EdgeInsets.only(
                              left: 10.w,
                              bottom: 20.h,
                              right: 10.w,
                            ),
                            width: 200.w,

                            child: Container(
                              padding: EdgeInsets.only(
                                top: 5.h,
                                left: 10.w,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(30.r),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey.withOpacity(0.3),
                                      offset: Offset(1, 10),
                                      blurRadius: 10),
                                  BoxShadow(
                                      color: Colors.grey.withOpacity(0.3),
                                      offset: Offset(0, 10),
                                      blurRadius: 10)
                                ],

                                image: DecorationImage(
                                  image: NetworkImage(
                                      meal[index].strMealThumb!),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              // child: ,
                            )),
                      );
                    },
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, childAspectRatio: 1),
                  ),
                );


            }
                (){}();
            return CircularProgressIndicator(
              color: Colors.yellow,
            );
          }),


        ],
      ),
    );
  }
}


