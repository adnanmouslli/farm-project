import 'package:farm/controller/bookingFarm/BookingFarmController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

class BookingFarm extends StatelessWidget {
  BookingFarmController controller = Get.put(BookingFarmController());

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
            focusedDay: controller.focusedDay.value,
            selectedDayPredicate: (day) {
              return controller.selectedDays.contains(day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              controller.onDaySelected(selectedDay, focusedDay);
            },
            calendarBuilders: CalendarBuilders(
              defaultBuilder: (context, day, focusedDay) {
                if (controller.isDayAvailable(day)) {
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
                      style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                    ),
                  );
                }
              },
            ),
            enabledDayPredicate: (day) {
              return controller.isDayAvailable(day);
            },
            calendarFormat: CalendarFormat.month,
          )),
          SizedBox(height: 20),
          Obx(() => ElevatedButton(
            onPressed: controller.selectedDays.isNotEmpty
                ? () {
              controller.saveBooking();
            }
                : null,
            child: Text('احجز الآن'),
          )),
        ],
      ),
    );
  }
}
