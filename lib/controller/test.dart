import 'package:get/get.dart';
import 'package:flutter/material.dart';

class BookingTestController extends GetxController {
  // قائمة بالأيام المتاحة
  var availableDays = <DateTime>[
    DateTime.utc(2024, 8, 15),
    DateTime.utc(2024, 8, 16),
    DateTime.utc(2024, 8, 17),
    DateTime.utc(2024, 8, 20),
  ].obs;

  var selectedDay = DateTime.now().obs;
  var focusedDay = DateTime.now().obs;

  void onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    this.selectedDay.value = selectedDay;
    this.focusedDay.value = focusedDay;
  }

  bool isDayAvailable(DateTime day) {
    return availableDays.contains(day);
  }
}
