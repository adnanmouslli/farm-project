import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/FarmOwner/FarmOwnerHomeController.dart';
import '../../../core/constant/color.dart';

class BookingListScreen extends StatelessWidget {
  final FarmOwnerHomeController controller = Get.put(FarmOwnerHomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Farm Bookings"),
        backgroundColor: AppColor.primaryColor,
        centerTitle: true,
      ),
      body: GetBuilder<FarmOwnerHomeController>(
          builder: (controller) {
        return controller.bookings.isEmpty
            ? Center(
          child: Text(
            "No Bookings Available",
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey[600],
            ),
          ),
        )
            : ListView.builder(
          padding: const EdgeInsets.all(10),
          itemCount: controller.bookings.length,
          itemBuilder: (context, index) {
            final booking = controller.bookings[index];
            final statusBooking = booking['statusBooking'];
            final isConfirmed = statusBooking == '1';

            return Card(
              margin: const EdgeInsets.symmetric(vertical: 10),
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.person, color: AppColor.primaryColor),
                        const SizedBox(width: 10),
                        Text(
                          booking['username'],
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Icon(Icons.phone, color: AppColor.primaryColor),
                        const SizedBox(width: 10),
                        Text(
                          booking['phone'].toString(),
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Icon(Icons.date_range, color: AppColor.primaryColor),
                        const SizedBox(width: 10),
                        Text(
                          booking['date'],
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Icon(Icons.info, color: AppColor.primaryColor),
                        const SizedBox(width: 10),
                        Text(
                          isConfirmed ? "Confirmed" : "Pending",
                          style: TextStyle(
                            fontSize: 16,
                            color: isConfirmed ? Colors.green : Colors.orange,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    if (!isConfirmed) // عرض الأزرار فقط إذا كان الحجز معلق
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          OutlinedButton.icon(
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(color: Colors.green, width: 2),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            onPressed: () {
                              controller.confirmBooking(booking['id']);
                            },
                            icon: const Icon(Icons.check, color: Colors.green),
                            label: const Text(
                              "Confirm",
                              style: TextStyle(color: Colors.green),
                            ),
                          ),

                          OutlinedButton.icon(
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(color: Colors.red, width: 2),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            onPressed: () {
                              controller.rejectBooking(booking['id']);
                            },
                            icon: const Icon(Icons.close, color: Colors.red),
                            label: const Text(
                              "Reject",
                              style: TextStyle(color: Colors.red),
                            ),
                          ),

                        ],
                      ),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
