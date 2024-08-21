import 'package:farm/core/constant/imagasset.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../../../core/constant/color.dart';
import '../../../controller/FarmOwner/FarmOwnerHomeController.dart';

class FarmImagesScreen extends StatelessWidget {
  final FarmOwnerHomeController controller = Get.put(FarmOwnerHomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Farm Images'),
        backgroundColor: AppColor.primaryColor,
      ),
      body: GetBuilder<FarmOwnerHomeController>(builder: (controller) {
        return Column(
          children: [
            Expanded(
              child: controller.farmImages.length == 0
                  ? Center(
                child: Container(
                    width: 200,
                    height: 200,
                    child: Lottie.asset(AppImageAsset.NotData)),
              )
                  : GridView.builder(
                padding: const EdgeInsets.all(10),
                gridDelegate:
                const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: controller.farmImages.length,
                itemBuilder: (context, index) {
                  final imageUrl = controller.farmImages[index]['imageUrl'];
                  return Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(
                                "${controller.ip}/upload/$imageUrl"),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 5,
                              offset: Offset(0, 5),
                            )
                          ],
                        ),
                      ),
                      Positioned(
                        right: 5,
                        top: 5,
                        child: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            controller.deleteImage(index);
                          },
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        );
      }),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: controller.pickAndUploadImage,
        label: const Text('Add Image'),
        icon: const Icon(Icons.add),
        backgroundColor: AppColor.primaryColor,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
