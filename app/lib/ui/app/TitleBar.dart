// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:ombruk/services/serviceLocator.dart';
// import 'package:ombruk/ui/app/AppRouter.dart';

// import 'package:ombruk/ui/customColors.dart' as customColors;

// AppRouter router = serviceLocator<AppRouter>();

// class TitleBar extends StatelessWidget with PreferredSizeWidget {
//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//     title: Text(
//         router.route.title.data,
//         style: TextStyle(
//           color: Colors.black,
//           fontSize: 25,
//         ),
//     ),
//     centerTitle: false,
//     backgroundColor: customColors.osloWhite,
//     elevation: 0,

//     // Menu item
//     leading: IconButton(
//       icon: Icon(Icons.menu),
//       color: Colors.black,
//       iconSize: 34,
//       onPressed: () {
//         router.key.currentState.openDrawer();
//       },
//     ),

//     actions: router.route.actionItems
//   );
//   }

//   @override
//   Size get preferredSize => Size.fromHeight(50);
// }
