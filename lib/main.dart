import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_recipe_review/ReceipeModel.dart';
import 'package:food_recipe_review/blocs/app_blocs.dart';
import 'package:food_recipe_review/blocs/app_events.dart';
import 'package:food_recipe_review/blocs/app_states.dart';
import 'package:food_recipe_review/category_model.dart';
import 'package:food_recipe_review/details_page.dart';
import 'package:food_recipe_review/repos/repository.dart';
import 'package:food_recipe_review/widgets/home_page.dart';
import 'package:food_recipe_review/widgets/new_page.dart';

import 'model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context, _) {
        return MaterialApp(
            debugShowCheckedModeBanner: false,
//you want to provide the repo to the child
            home: MultiRepositoryProvider(
              providers: [
                RepositoryProvider(create: (context) => UserRepository()),
                RepositoryProvider(create: (context) => FoodRepository())
              ],
              child: MyHomePage(title: '',),
            ));
      },
      designSize: Size(375, 812),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              UserBloc(RepositoryProvider.of<UserRepository>(context))
                ..add(LoadUserEvent()),
        ),
        BlocProvider(
          create: (context) =>
              FoodBloc(RepositoryProvider.of<FoodRepository>(context))
                ..add(FoodRecipe()),
        ),
        BlocProvider(
            create: (context) =>
                FoodCatBloc(RepositoryProvider.of<FoodRepository>(context))..add(Initial())),
        BlocProvider(
          create: (context) => ColorBloc()..add(InitID(0))
        ),
    BlocProvider<CounterCubit>(
    create: (BuildContext context) => CounterCubit(),),
        BlocProvider(
          create: (context) =>
          FoodIngredientBloc(RepositoryProvider.of<FoodRepository>(context))
            ..add(LoadingFoodIngredientEvent()),
        )

      ],
      child:
        Scaffold(

    body:DetailPage()
//     Column(
//       children: [

//       ],
//     )
    // BlocSelector<CounterCubit, int, bool>(
    // selector: (state) => state.isEven ? true : false,
    // builder: (context, booleanState) {
    // return Center(
    // child: booleanState
    // ? Text('$booleanState')
    //     : Icon(Icons.integration_instructions));
    // },
    // ),
    // floatingActionButton: Column(
    // crossAxisAlignment: CrossAxisAlignment.end,
    // mainAxisAlignment: MainAxisAlignment.end,
    // children: <Widget>[
    // FloatingActionButton(
    // child: const Icon(Icons.add),
    // onPressed: () => context.read<CounterCubit>().increment(),
    // ),
    // const SizedBox(height: 4),
    // FloatingActionButton(
    // child: const Icon(Icons.remove),
    // onPressed: () => context.read<CounterCubit>().decrement(),
    // ),
    // ],
    // ),
    ),
    );
  }
}



class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MultiBlocProvider(
        providers: [
          BlocProvider<ColorBloc>(
            create: (BuildContext context) => ColorBloc(),
          ),
        ],
        child: const BlocListenerCounterPage(),
      ),
    );
  }
}

class BlocListenerCounterPage extends StatelessWidget {
  const BlocListenerCounterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Counter')),
      body:

      BlocSelector<ColorBloc, SelectedState, bool>(
        selector: (state) {
          if(state is SelectedID){
            print(state.selectedId);
            if(state.selectedId!=1){
              return true;
            }
          }
        return false;
        } ,
        builder: (context, booleanState) {
          return Center(
              child:
              GestureDetector(
                onTap:  () => context.read<ColorBloc>().add(SelectID(1)),
                child: Container(
                    height: 100,
                    width: 100,
                    color: booleanState? Colors.orange:Colors.amberAccent,
                    child: Text('$booleanState')),
              ));

        },
      ),
      floatingActionButton: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(

            child: const Icon(Icons.add),
            onPressed: () => context.read<CounterCubit>().increment(),
          ),
          const SizedBox(height: 4),
          FloatingActionButton(
            child: const Icon(Icons.remove),
            onPressed: () => context.read<CounterCubit>().decrement(),
          ),
        ],
      ),
    );
  }
}