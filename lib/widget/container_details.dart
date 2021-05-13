// import 'package:flutter/material.dart';
// import 'package:shifaa_pharmacy/constant/constant.dart';
//
// class ContainerDetails extends StatelessWidget {
//   final String text;
//   final IconData icon;
//   final Function onTap;
//   ContainerDetails({this.text, this.icon, this.onTap});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         color: mainColor,
//         borderRadius: BorderRadius.circular(5),
//       ),
//       margin: EdgeInsets.symmetric(vertical: 2),
//       child: ListTile(
//         onTap: onTap,
//         dense: true,
//         contentPadding: EdgeInsets.zero.copyWith(left: 10),
//         minLeadingWidth: 0,
//         minVerticalPadding: 0,
//         leading: Icon(icon, color: Colors.white, size: 30),
//         title: Text(
//           "$text",
//           style: TextStyle(
//             color: Colors.white,
//             fontWeight: FontWeight.w900,
//           ),
//         ),
//         // trailing: Image.asset(
//         //   "images/right.png",
//         //   color: Colors.white,
//         //   width: 25,
//         //   height: 25,
//         // ),
//       ),
//     );
//   }
// }
