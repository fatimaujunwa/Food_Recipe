// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import 'blocs/app_blocs.dart';
// import 'blocs/app_events.dart';
// import 'blocs/app_states.dart';
//
// class CategoriesWidget extends StatelessWidget {
//   const CategoriesWidget({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<CategoryBloc, CategoryState>(
//       buildWhen: (previous, current) => current.status.isSuccess,
//       builder: (context, state) {
//         return CategoriesSuccessWidget();
//       },
//     );
//   }
// }
// class CategoriesSuccessWidget extends StatelessWidget {
//   const CategoriesSuccessWidget({
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<CategoryBloc, CategoryState>(
//       builder: (context, state) {
//         return SizedBox(
//           height: MediaQuery.of(context).size.height * .15,
//           child: ListView.separated(
//             padding: const EdgeInsets.symmetric(horizontal: 16.0),
//             shrinkWrap: true,
//             itemBuilder: (context, index) {
//               return CategoryItem(
//                 key: ValueKey('${state.categories[index].name}$index'),
//                 category: state.categories[index],
//                 callback: (Genre categorySelected) {
//                   context.read<GamesByCategoryBloc>().add(
//                     GetGamesByCategory(
//                       idSelected: categorySelected.id,
//                       categoryName: categorySelected.name ?? '',
//                     ),
//                   );
//                   context.read<CategoryBloc>().add(
//                     SelectCategory(
//                       idSelected: categorySelected.id,
//                     ),
//                   );
//                 },
//               );
//             },
//             scrollDirection: Axis.horizontal,
//             separatorBuilder: (_, __) => SizedBox(
//               width: 16.0,
//             ),
//             itemCount: state.categories.length,
//           ),
//         );
//       },
//     );
//   }
// }
//
// typedef CategoryCLicked = Function(Genre categorySelected);
//
// class CategoryItem extends StatelessWidget {
//   const CategoryItem({
//     Key? key,
//     required this.category,
//     required this.callback,
//   }) : super(key: key);
//
//   final Genre category;
//   final CategoryCLicked callback;
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () => callback(category),
//       child: BlocSelector<CategoryBloc, CategoryState, bool>(
//         selector: (state) =>
//         (state.status.isSelected && state.idSelected == category.id)
//             ? true
//             : false,
//         builder: (context, state) {
//           return Column(
//             children: [
//               AnimatedContainer(
//                 duration: const Duration(milliseconds: 400),
//                 curve: Curves.easeInOutCirc,
//                 padding: const EdgeInsets.symmetric(horizontal: 2.0),
//                 alignment: Alignment.center,
//                 height: state ? 70.0 : 60.0,
//                 width: state ? 70.0 : 60.0,
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   color: state ? Colors.deepOrangeAccent : Colors.amberAccent,
//                 ),
//                 child: Icon(
//                   Icons.gamepad_outlined,
//                 ),
//               ),
//               SizedBox(height: 4.0),
//               Container(
//                 width: 60,
//                 child: Text(
//                   category.name ?? '',
//                   style: TextStyle(
//                       fontSize: 10.0,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black87),
//                   textAlign: TextAlign.center,
//                   maxLines: 2,
//                   overflow: TextOverflow.ellipsis,
//                 ),
//               )
//             ],
//           );
//         },
//       ),
//     );
//   }
// }
//
// // view raw