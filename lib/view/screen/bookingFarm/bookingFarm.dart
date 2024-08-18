import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:farm/controller/bookingFarm/BookingFarmController.dart';

import '../../../core/constant/color.dart';

class BookingFarm extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    BookingFarmController con = Get.put(BookingFarmController());

    return Scaffold(
      floatingActionButton: FloatingActionButton(

          backgroundColor: AppColor.primaryColor,
          onPressed: () {
             con.refresh() ;
          },
          child: const Icon(Icons.refresh)),
      appBar: AppBar(
        title: Text('احجز الآن'),

      ),
      body: GetBuilder<BookingFarmController>(
        builder: (controller) =>
         Column(
          children: [
            Obx(() => TableCalendar(
              firstDay: DateTime.now(),
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
                // إظهار نافذة التأكيد قبل الحجز
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('تأكيد الحجز'),
                      content: Text('هل أنت متأكد من أنك تريد حجز هذه الأيام؟'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(); // إغلاق النافذة
                          },
                          child: Text('إلغاء'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            controller.saveBooking(); // تنفيذ الحجز
                            Navigator.of(context).pop(); // إغلاق النافذة
                          },
                          child: Text('تأكيد'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                );
              }
                  : null,
              child: Text('احجز الآن'),
            )),
          ],
        ),
      ),
    );
  }
}
