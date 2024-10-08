import 'package:farm/controller/test.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

import 'controller/booking/booking_controller.dart';

class BookingScreen extends StatelessWidget {

  final BookingTestController bookingTestController = Get.put(BookingTestController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('احجز الآن'),
      ),
      body: Column(
        children: [
          Obx(() => TableCalendar(
            firstDay: DateTime.utc(2024, 1, 1),
            lastDay: DateTime.utc(2024, 12, 31),
            focusedDay: bookingTestController.focusedDay.value,
            selectedDayPredicate: (day) {
              return isSameDay(bookingTestController.selectedDay.value, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              bookingTestController.onDaySelected(selectedDay, focusedDay);
            },
            calendarBuilders: CalendarBuilders(
              defaultBuilder: (context, day, focusedDay) {
                if (bookingTestController.isDayAvailable(day)) {
                  return Center(
                    child: Text(
                      '${day.day}',
                      style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
                    ),
                  );
                } else {
                  return Center(
                    child: Text(
                      '${day.day}',
                      style: TextStyle(color: Colors.grey),
                    ),
                  );
                }
              },
            ),
            enabledDayPredicate: (day) {
              return bookingTestController.isDayAvailable(day);
            },
            calendarFormat: CalendarFormat.month,
          )),
          SizedBox(height: 20),
          Obx(() => ElevatedButton(
            onPressed: bookingTestController.isDayAvailable(bookingTestController.selectedDay.value)
                ? () {
              // تنفيذ عملية الحجز هنا
              Get.snackbar('تم الحجز', 'تم حجز اليوم: ${bookingTestController.selectedDay.value.toLocal()}');
            }
                : null,
            child: Text('احجز الآن'),
          )),
        ],
      ),
    );
  }
}
