import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/FarmOwner/FarmOwnerHomeController.dart';
import '../../../core/constant/color.dart';

class FarmOffersScreen extends StatelessWidget {
  const FarmOffersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Farm Offers"),
        backgroundColor: AppColor.primaryColor,
      ),
      body: GetBuilder<FarmOwnerHomeController>(
        builder: (controller) {
          if (controller.farmOffers.isEmpty) {
            return const Center(
              child: Text(
                "No offers available",
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView.builder(
                itemCount: controller.farmOffers.length,
                itemBuilder: (context, index) {
                  var offer = controller.farmOffers[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Offer Description: ${offer['description']}",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "Offer Value: ${offer['offer_value']}%",
                            style: const TextStyle(
                              color: AppColor.primaryColor,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "Available on: ${offer['offer_day']}",
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}
