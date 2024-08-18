import 'package:farm/controller/MyBookinControllerImp.dart';
import 'package:farm/core/constant/imagasset.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import '../../../controller/booking/cancelBooking_controller.dart';
import '../../../controller/booking/confirmBooking_controller.dart';
import '../../../core/class/handlingdataview.dart';
import '../../../core/functions/dialogueConfirm.dart';
import '../../../data/model/BookingModel.dart';
import '../../core/class/statusrequest.dart';
import '../../core/constant/color.dart';


class MyBookin extends StatelessWidget {
  const MyBookin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(MyBookinControllerImp()) ;
    return
      Scaffold(
        appBar: AppBar(
          title: Text('الحجوزات السابقة'),
        ),
        body: GetBuilder<MyBookinControllerImp>(
          builder: (controller) {
            if (controller.statusRequest == StatusRequest.loading) {
              return Center(child: CircularProgressIndicator());
            } else if (controller.statusRequest == StatusRequest.failure) {
              return Center(child: Text('فشل في تحميل البيانات'));
            } else if (controller.availableBookings.isEmpty) {
              return Center(child: Lottie.asset(AppImageAsset.NotData));
            } else {
              return ListView.builder(
                itemCount: controller.availableBookings.length,
                itemBuilder: (context, index) {
                  SportBooking sportBooking = SportBooking.fromJson(controller.availableBookings[index]);
                  var booking = controller.availableBookings[index];
                  bool isConfirmed = sportBooking.statusBooking == "1";
                  // تنسيق التاريخ لإظهار التاريخ فقط بدون الوقت
                  String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.parse(booking['date']));
                  String price = booking['price'].toString() ;
                  return Card(
                    elevation: 4,
                    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                booking['name'],
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: AppColor.primarySecandColor
                                ),
                              ),
                              IconButton(
                                icon: Icon(Icons.delete, color: Colors.red),
                                onPressed: () => controller.deleteBooking(index),
                              ),
                            ],
                          ),
                          SizedBox(height: 8),

                          Text(
                            'التاريخ: $formattedDate',
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(height: 8),

                          Text(
                            'السعر: $price',
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(height: 8),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      );


  }

}
