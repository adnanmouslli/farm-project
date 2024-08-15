import 'package:farm/data/model/FarmModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../../../controller/home/home_controller.dart';
import '../../../core/constant/color.dart';
import '../../../core/constant/imagasset.dart';

class CustomCardHome extends GetView<HomeControllerImp> {

  const CustomCardHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
      decoration: BoxDecoration(
        color: AppColor.primaryColor,
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: [
            AppColor.primaryColor.withOpacity(0.8),
            AppColor.primaryfourthColor.withOpacity(0.8),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(13.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // اسم المزرعة
                Row(
                  children: [
                    Icon(
                      Icons.location_city_outlined,
                      color: AppColor.primaryfourthColor,
                      size: 24,
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        controller.top1Farm[0]['name'],
                        style: TextStyle(
                          color: AppColor.primaryfourthColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),

                // عنوان المزرعة
                Row(
                  children: [
                    Icon(Icons.location_on_outlined, color: AppColor.primaryfourthColor),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        controller.top1Farm[0]['address'] ?? "No address available",
                        style: TextStyle(
                          color: AppColor.primaryfourthColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),

                // هاتف المزرعة
                Row(
                  children: [
                    Icon(Icons.phone_outlined, color: AppColor.primaryfourthColor),
                    SizedBox(width: 10),
                    Text(
                      controller.top1Farm[0]['phone'] ?? "No phone available",
                      style: TextStyle(
                        color: AppColor.primaryfourthColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Container(
                    margin: const EdgeInsets.symmetric(horizontal: 1, vertical: 1),
                    height: 30,
                    child: MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        color: AppColor.primarySecandColor,
                        onPressed: (){
                        controller.goToPageFarmDetails(FarmModel.fromJson(controller.top1Farm[0]), false);
                        },
                        child: const Text(
                          "view farm",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        )))
                //
                // // سعر الخدمة في المزرعة
                // Row(
                //   children: [
                //     Icon(Icons.attach_money_outlined, color: AppColor.primaryfourthColor),
                //     SizedBox(width: 10),
                //     Text(
                //       "${controller.top1Farm[0]['price'] ?? "No price available"}",
                //       style: TextStyle(
                //         color: AppColor.primaryfourthColor,
                //         fontWeight: FontWeight.bold,
                //         fontSize: 18,
                //       ),
                //     ),
                //   ],
                // ),
                // SizedBox(height: 10),
                //
                // // تقييم المزرعة
                // Row(
                //   children: [
                //     Icon(Icons.star_rate_rounded, color: Colors.amber, size: 24),
                //     SizedBox(width: 10),
                //     Text(
                //       "${4.5 ?? "No rating available"}",
                //       style: TextStyle(
                //         color: AppColor.primaryfourthColor,
                //         fontWeight: FontWeight.bold,
                //         fontSize: 18,
                //       ),
                //     ),
                //   ],
                // ),
              ],
            ),
          ),
          Positioned(
            top: -10,
            right: -10,
            child: Container(
              height: 160,
              width: 160,
              decoration: BoxDecoration(
                color: AppColor.primarySecandColor.withOpacity(0.3),
                borderRadius: BorderRadius.circular(160),
              ),
              child: Lottie.asset(AppImageAsset.topOne_3),
            ),
          ),
        ],
      ),
    );
  }
}




// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:lottie/lottie.dart';
//
// import '../../../controller/home/home_controller.dart';
// import '../../../core/constant/color.dart';
// import '../../../core/constant/imagasset.dart';
//
// class CustomCardHome extends GetView<HomeControllerImp> {
//
//
//   const CustomCardHome({Key? key})
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.symmetric(vertical: 15),
//       child: Stack(children: [
//         Container(
//           alignment: Alignment.center,
//           height: 150,
//           decoration: BoxDecoration(
//               color: AppColor.primaryColor ,
//               borderRadius: BorderRadius.circular(20)),
//           child:  Padding(
//             padding: EdgeInsets.all(8.0),
//             child: Column(
//               children: [
//                 Row(children: [
//                   Icon(Icons.location_on_outlined , color: AppColor.primaryfourthColor,),
//                   SizedBox(width: 10,) ,
//                   Text(
//                      ,
//                     style: TextStyle(
//                         color: AppColor.primaryfourthColor ,
//                         fontWeight: FontWeight.bold
//                     ),
//                   )
//                 ],) ,
//
//                 SizedBox(height: 5,) ,
//
//                 Row(children: [
//                   Icon(Icons.email_outlined, color: AppColor.primaryfourthColor),
//                   SizedBox(width: 10,) ,
//                   Text(
//                       "" , style: TextStyle(
//                       color: AppColor.primaryfourthColor,
//                       fontWeight: FontWeight.bold)
//                   )
//                 ],) ,
//
//                 SizedBox(height: 5,) ,
//
//                 Row(children: [
//                   Icon(Icons.add_ic_call_outlined, color: AppColor.primaryfourthColor),
//                   SizedBox(width: 10,) ,
//                   Text(
//                       "" , style: TextStyle(
//                               color: AppColor.primaryfourthColor,
//                               fontWeight: FontWeight.bold)
//                         )
//                 ],) ,
//
//                 SizedBox(height: 5,) ,
//
//                 Row(children: [
//                   Icon(Icons.facebook_outlined, color: AppColor.primaryfourthColor),
//                   SizedBox(width: 10,) ,
//                   Text(
//                       "" , style: TextStyle(
//                       color: AppColor.primaryfourthColor,
//                       fontWeight: FontWeight.bold)
//
//                   )
//                 ],) ,
//               ],
//             ),
//           )
//         ),
//         Positioned(
//           top: -23,
//           right:   -23  ,
//          // left: controller.lang == "ar" ?  -20 : null ,
//           child: Container(
//             height: 160,
//             width: 160,
//             decoration: BoxDecoration(
//                 color: AppColor.primarySecandColor,
//                 borderRadius: BorderRadius.circular(160)),
//             child: Lottie.asset(AppImageAsset.cashback) ,
//           ),
//         ) ,
//
//       ]),
//     );
//   }
// }
