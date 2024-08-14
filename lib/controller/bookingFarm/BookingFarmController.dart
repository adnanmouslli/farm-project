import 'package:dartz/dartz_unsafe.dart';
import 'package:farm/data/datatsource/remote/booking/booking_data.dart';
import 'package:farm/data/model/FarmModel.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../core/services/services.dart';

class BookingFarmController extends GetxController {
  late FarmModel farmModel;
  String id_user = "";
  MyServices myServices = Get.find();


  BookingData bookingData = BookingData(Get.find());
  var bookingFarm = <DateTime>[].obs;

  var selectedDays = <DateTime>[].obs;
  var focusedDay = DateTime.now().obs;

  void onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    this.focusedDay.value = focusedDay;
    if (selectedDays.contains(selectedDay)) {
      selectedDays.remove(selectedDay);
    } else {
      selectedDays.add(selectedDay);
    }
  }

  bool isSameDate(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  bool isDayAvailable(DateTime day) {
    return !bookingFarm.any((bookedDay) => isSameDate(bookedDay, day));
  }


  /// جلب الأيام المحجوزة من قاعدة البيانات
  getDayBooking() async {
    var res = await bookingData.getBookingFarm(farmModel.id!.toString());
    if (res['status'] == "success") {
      bookingFarm.addAll(
        res['data'].map<DateTime>((day) => DateTime.parse(day['date'])).toList(),
      );
      print(bookingFarm);
    }
  }

  /// حفظ الأيام المختارة كحجز جديد
  saveBooking() async {
    var bookingDates = selectedDays.map((date) => date.toIso8601String()).toList();
    var res ;
    for (var booking in bookingDates) {

      res =  await bookingData.addBookingFarm(farmModel.id!.toString(), id_user, booking) ;

    }
    
    if (res['status'] == "success") {
      Get.snackbar('تم الحجز', 'تم حجز الأيام بنجاح');
      getDayBooking(); // تحديث الأيام المحجوزة بعد الحجز
    } else {
      Get.snackbar('خطأ', 'حدث خطأ أثناء الحجز');
    }
  }


  @override
  void refresh() {
    // TODO: implement refresh
    super.refresh();
  }
  @override
  void onInit() {
    farmModel = Get.arguments['farmModel'];
    id_user = myServices.sharedPreferences.getInt("user_id").toString() ;
    getDayBooking();
    update() ;
    super.onInit();
  }
}
