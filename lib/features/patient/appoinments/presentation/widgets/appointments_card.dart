// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:se7ety_app/core/utils/color.dart';

// class AppointmentCard extends StatelessWidget {
//   final void Function() onTap;

//   const AppointmentCard({
//     Key? key,
//     required this.onTap,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Container(
//           width: double.infinity,
//           decoration: BoxDecoration(
//             color: AppColors.offWhite,
//             borderRadius: BorderRadius.circular(10),
//           ),
//           child: Material(
//             color: Colors.transparent,
//             child: InkWell(
//               onTap: onTap,
//               child: const Padding(
//                 padding: EdgeInsets.all(20),
//                 child: Column(
//                   children: [
//                     Row(
//                       children: [
//                         CircleAvatar(
//                           backgroundImage:
//                               AssetImage('assets/bannerDoctor.png'),
//                         ),
//                         SizedBox(
//                           width: 10,
//                         ),
//                         Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text("dr DuaaBaroni",
//                                 style: TextStyle(color: Colors.white)),
//                             SizedBox(
//                               height: 2,
//                             ),
//                             Text(
//                               "Hospital name:",
//                             ),
//                             Row(
//                               children: [
//                                 Icon(Icons.location_on_rounded, size: 16),
//                                 SizedBox(
//                                   width: 10,
//                                 ),
//                                 Text(
//                                   'location',
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                     SizedBox(
//                       height: 20,
//                     ),
//                     ScheduleCard(),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//         Container(
//           margin: const EdgeInsets.symmetric(horizontal: 20),
//           width: double.infinity,
//           height: 10,
//           decoration: BoxDecoration(
//             color: AppColors.background,
//             borderRadius: const BorderRadius.only(
//               bottomRight: Radius.circular(10),
//               bottomLeft: Radius.circular(10),
//             ),
//           ),
//         ),
//         Container(
//           margin: const EdgeInsets.symmetric(horizontal: 40),
//           width: double.infinity,
//           height: 10,
//           decoration: BoxDecoration(
//             color: AppColors.background,
//             borderRadius: const BorderRadius.only(
//               bottomRight: Radius.circular(10),
//               bottomLeft: Radius.circular(10),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

// class ScheduleCard extends StatelessWidget {
//   const ScheduleCard({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         color: AppColors.white,
//         borderRadius: BorderRadius.circular(10),
//       ),
//       width: double.infinity,
//       padding: const EdgeInsets.all(20),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Icon(
//             Icons.calendar_today,
//             color: AppColors.offWhite,
//             size: 15,
//           ),
//           const SizedBox(
//             width: 5,
//           ),
//           Text(
//             'Mon, July 29',
//             style: TextStyle(color: AppColors.offWhite),
//           ),
//           const SizedBox(
//             width: 20,
//           ),
//           Icon(
//             Icons.access_alarm,
//             color: AppColors.offWhite,
//             size: 17,
//           ),
//           const SizedBox(
//             width: 5,
//           ),
//           Flexible(
//             child: Text(
//               '11:00 ~ 12:10',
//               style: TextStyle(color: AppColors.offWhite),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }