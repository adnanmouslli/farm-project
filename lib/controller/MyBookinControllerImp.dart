import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/class/statusrequest.dart';
import '../core/functions/handingdatacontroller.dart';
import '../core/services/services.dart';
import '../data/datatsource/remote/booking/booking_data.dart';
import '../data/model/BookingModel.dart';

class MyBookinControllerImp extends GetxController{

  late StatusRequest statusRequest = StatusRequest.none;

  BookingData bookingData = BookingData(Get.find());

  MyServices myServices = Get.find();
  List availableBookings = [];
  late int user_id;

  getData() async {
    statusRequest = StatusRequest.loading;
    var response = await bookingData.getUserData('$user_id');
    print("=============================== Controller $response ");
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        List bookings = response['data'];

        availableBookings = bookings.where((booking) {
          DateTime bookingDate = DateTime.parse(booking['date']);
          return bookingDate.isBefore(DateTime.now()) && booking['statusBooking'] == '1' ;
        }).toList();

      } else {
        statusRequest = StatusRequest.failure;
      }
    }
    print(statusRequest);
    update();
  }

  deleteBooking(int index) async {
    SportBooking sportBooking = SportBooking.fromJson(availableBookings[index]);

    var response = await bookingData.deleteData(sportBooking.idFarm!, sportBooking.idUser!, sportBooking.date!);

    if (response['status'] == "success") {
      availableBookings.removeAt(index);
      update();
      Get.snackbar(
        'الحجوزات',
        'تم حذف الموعد بنجاح',
        duration: Duration(seconds: 3), // Set the duration to 3 seconds
        backgroundColor: Colors.green, // Set the background color to green
        colorText: Colors.white, // Set the text color to white
        shouldIconPulse: true, // Make the icon pulse
        snackPosition: SnackPosition.BOTTOM, // Set the position to bottom
      );
    }
  }

  @override
  void onInit() async {
    user_id = myServices.sharedPreferences.getInt("user_id")!;
    await getData();
    super.onInit();
  }


}