import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/FarmOwner/FarmOwnerHomeController.dart';
import '../../../core/constant/color.dart';

class AddOfferScreen extends StatelessWidget {
  const AddOfferScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Offer"),
        backgroundColor: AppColor.primaryColor,
      ),
      body: GetBuilder<FarmOwnerHomeController>(
        builder: (controller) {
          return LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Form(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          _buildTextField(
                            controller: controller.descriptionController,
                            label: "Description",
                            icon: Icons.description,
                          ),
                          const SizedBox(height: 20),
                          _buildTextField(
                            controller: controller.offerValueController,
                            label: "Offer Value",
                            icon: Icons.local_offer,
                            keyboardType: TextInputType.number,
                          ),
                          const SizedBox(height: 20),

                          // حقل اختيار الأيام
                          InkWell(
                            onTap: () {
                              _showMultiSelectDialog(context);
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Colors.grey.shade300),
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.3),
                                    blurRadius: 5,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    controller.selectedDays.isEmpty
                                        ? "Select Offer Days"
                                        : controller.getFormattedDays(),
                                    style: TextStyle(
                                      color: controller.selectedDays.isEmpty
                                          ? Colors.grey
                                          : Colors.black,
                                    ),
                                  ),
                                  Icon(Icons.calendar_today),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () {
                              if (controller.selectedDays.isNotEmpty) {
                                controller.offerDayController.text =
                                    controller.getFormattedDays();
                                controller.addOffer(); // استدعاء دالة إضافة العرض
                              } else {
                                Get.snackbar("Error", "Please select offer days");
                              }
                            },
                            child: const Text("Add Offer"),
                            style: ElevatedButton.styleFrom(

                              padding: const EdgeInsets.symmetric(
                                  horizontal: 32, vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              textStyle: const TextStyle(fontSize: 18 ,fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  // حقل النص المعاد استخدامه
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: AppColor.primaryColor),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.white,
        ),
      ),
    );
  }

  // نافذة اختيار الأيام
  void _showMultiSelectDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return GetBuilder<FarmOwnerHomeController>(
            builder: (controller) {
              return AlertDialog(
                title: const Text("Select Offer Days"),
                content: SingleChildScrollView(
                  child: Column(
                    children: controller.allDays.map((day) {
                      return CheckboxListTile(
                        title: Text(day),
                        value: controller.selectedDays.contains(day),
                        onChanged: (bool? isChecked) {
                          if (isChecked != null) {
                            if (isChecked) {
                              controller.selectedDays.add(day);
                            } else {
                              controller.selectedDays.remove(day);
                            }
                            controller.update(); // استخدام update بدلاً من refresh
                          }
                        },
                      );
                    }).toList(),
                  ),
                ),
                actions: [
                  TextButton(
                    child: const Text("OK"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            });
      },
    );
  }
}
