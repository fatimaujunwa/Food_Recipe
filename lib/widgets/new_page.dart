import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_recipe_review/app_colors.dart';
import 'package:food_recipe_review/blocs/app_blocs.dart';
import 'package:food_recipe_review/blocs/app_events.dart';
import 'package:food_recipe_review/blocs/app_states.dart';
import 'package:food_recipe_review/widgets/home_page.dart';

import '../ReceipeModel.dart';
import '../category_model.dart';
import '../repos/repository.dart';

// class AppRouter {
//   Route? onGenerateRoute(RouteSettings settings) {
//     final Object? key = settings.arguments;
//     switch (settings.name) {
//       case '/':
//         return MaterialPageRoute(
//           builder: (_) => HomePage(
//
//           ),
//         );
//       case '/second':
//         return MaterialPageRoute(
//           builder: (_) => NewPage(
//
//           ),
//         );
//
//       default:
//         return null;
//     }
//   }
// }


class NewPage extends StatelessWidget {
  const NewPage({
    Key? key,
    required this.blocContext,
    required this.meals
  }) : super(key: key);

  final BuildContext blocContext;
final String meals;
  static MaterialPageRoute<void> route(BuildContext context,String meal) => MaterialPageRoute(
    builder: (_) => NewPage(blocContext: context,meals:meal,),
  );

  @override
  Widget build(BuildContext context) {
    return BlocProvider<FoodIngredientBloc>(
      // Use existing BLoC instead of creating a new one
      create: (_) => BlocProvider.of<FoodIngredientBloc>(blocContext)..add(LoadFoodIngredientEvent(meals)),
      child: _ItemDetailsScreen(meals: meals,),
    );
  }
}

class _ItemDetailsScreen extends StatefulWidget {
  const _ItemDetailsScreen({Key? key,required this.meals}) : super(key: key);
final String meals;
  @override
  _ItemDetailsScreenState createState() => _ItemDetailsScreenState();
}

class _ItemDetailsScreenState extends State<_ItemDetailsScreen> {

  @override
  Widget build(BuildContext context) {
    print(widget.meals);
    return BlocBuilder<FoodIngredientBloc, FoodIngredientState>(
      builder: (context, state) {
        if(state is FoodIngredientLoadedState){
          List<Meals> meals=state.ingredients;
          print('meals'+meals.length.toString());

         return Scaffold(body:
         Stack(
           children: [
             Container(height: 816,width: 375,
                 decoration: BoxDecoration(
                   image: DecorationImage(image:
                  NetworkImage(meals[0].strMealThumb!),
                     fit: BoxFit.cover

                   )
                 ),




             ),
             Container(
               margin: EdgeInsets.only(top: 250),
               height: 500,decoration: BoxDecoration(
                 color:Colors.white.withOpacity(0.7),
                 borderRadius: BorderRadius.only(topRight: Radius.circular(30.r),topLeft: Radius.circular(30.r))

             ),),
           ],
         ),


         );

        }

        return
        Scaffold(body: Center(child: CircularProgressIndicator(color: AppColors.orange,)));
      },
    );
  }
}
