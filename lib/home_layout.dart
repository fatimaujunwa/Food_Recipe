// import 'package:flutter/cupertino.dart';
//
// class HomeLayout extends StatelessWidget {
//   const HomeLayout({
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(top: 80.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           HeaderTitle(),
//           const SizedBox(height: 40.0),
//           ContainerBody(
//             children: [
//               CategoriesWidget(),
//               GamesByCategoryWidget(),
//               AllGamesWidget(title: 'All games'),
//             ],
//           )
//         ],
//       ),
//     );
//   }