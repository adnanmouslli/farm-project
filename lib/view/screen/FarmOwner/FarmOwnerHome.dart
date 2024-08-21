import 'package:farm/core/constant/routes.dart';
import 'package:farm/linkapi.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/FarmOwner/FarmOwnerHomeController.dart';
import '../../../core/constant/color.dart';
import 'BookingListScreen.dart';
import 'AddOfferScreen.dart';
import 'FarmOffersScreen.dart'; // استيراد شاشة إضافة العرض

class FarmOwnerHome extends StatelessWidget {
  const FarmOwnerHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(FarmOwnerHomeController());

    // قائمة التدرجات اللونية للصناديق بألوان متناسقة
    final List<Gradient> gradients = [
      LinearGradient(
        colors: [Color(0xFFa8e063), Color(0xFF56ab2f)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      LinearGradient(
        colors: [Color(0xFFf7b733), Color(0xFFfc4a1a)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      LinearGradient(
        colors: [Color(0xFF2193b0), Color(0xFF6dd5ed)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      LinearGradient(
        colors: [Color(0xFFee9ca7), Color(0xFFffdde1)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    ];

    String ip = AppLink.server;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Farm Owner Home"),
        backgroundColor: AppColor.primaryColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            GetBuilder<FarmOwnerHomeController>(builder: (controller) {
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
                      offset: const Offset(0, 5),
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
                          // Avatar مع اسم وعنوان المزرعة
                          Row(
                            children: [
                              // صورة المزرعة كـ Avatar
                              CircleAvatar(
                                radius: 50,
                                backgroundImage: NetworkImage(
                                    "$ip/upload/${controller.farm['urlImage']}"), // استبدلها بمسار صورة صاحب المزرعة
                              ),
                              const SizedBox(width: 15),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Farm Owner Name:", // اسم صاحب المزرعة
                                      style: const TextStyle(
                                        color: AppColor.primaryfourthColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      controller.farm['name'], // عنوان المزرعة
                                      style: const TextStyle(
                                        color: AppColor.primaryfourthColor,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 4, // عدد الصناديق
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemBuilder: (context, index) {
                  if (index == 0) {
                    // بوكس عرض صور المزرعة
                    return Container(
                      decoration: BoxDecoration(
                        gradient: gradients[index % gradients.length],
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: InkWell(
                        onTap: () async {
                          Get.toNamed(AppRoute.farmImage);
                        },
                        child: const Center(
                          child: Text(
                            "Farm Images",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    );
                  } else if (index == 1) {
                    return Container(
                      decoration: BoxDecoration(
                        gradient: gradients[index % gradients.length],
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: InkWell(
                        onTap: () {
                          Get.to(() => BookingListScreen());
                        },
                        child: const Center(
                          child: Text(
                            "Farm Bookings",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    );
                  } else if (index == 2) {
                    // بوكس إضافة عرض
                    return Container(
                      decoration: BoxDecoration(
                        gradient: gradients[index % gradients.length],
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: InkWell(
                        onTap: () {
                          Get.to(() => AddOfferScreen()); // الانتقال إلى شاشة إضافة العرض
                        },
                        child: const Center(
                          child: Text(
                            "Add Offer",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    );
                  }
                  else if(index == 3){
                    return Container(
                      decoration: BoxDecoration(
                        gradient: gradients[index % gradients.length],
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: InkWell(
                        onTap: () {
                          Get.to(() => const FarmOffersScreen());
                        },
                        child: const Center(
                          child: Text(
                            "View Offers",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    );
                  }

                  return Container(
                    decoration: BoxDecoration(
                      gradient: gradients[index % gradients.length],
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: InkWell(
                      onTap: () {},
                      child: Center(
                        child: Text(
                          "Task ${index + 1}",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 20,)
          ],
        ),
      ),
    );
  }
}
