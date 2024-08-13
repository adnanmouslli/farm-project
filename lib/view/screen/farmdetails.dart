import 'package:farm/core/constant/imagasset.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

import '../../controller/farmdetails_controller.dart';
import '../../core/class/handlingdataview.dart';
import '../../core/constant/color.dart';
import '../../core/constant/routes.dart';
import '../../linkapi.dart';
import '../widget/productdetails/priceandcount.dart';
import '../widget/productdetails/toppageproductdetails.dart';
import 'package:clipboard/clipboard.dart';

class FarmDetails extends StatelessWidget {
  const FarmDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FarmDetailsControllerImp controllerImp = Get.put(FarmDetailsControllerImp());

    const String baseUrl = AppLink.server;
    return Scaffold(
      bottomNavigationBar: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        height: 40,
        child: Row(
          children: [
            Expanded(
              child: MaterialButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                color: AppColor.primarySecandColor,
                onPressed: () {
                controllerImp.goToBookingFarm() ;
                },
                child: const Text(
                  "Farm Booking",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: MaterialButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                color: AppColor.primaryColor,
                onPressed: () {
                  _showRatingDialog(context , controllerImp);
                },
                child: const Text(
                  "Rate Farm",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: GetBuilder<FarmDetailsControllerImp>(
        builder: (controller) => ListView(
          children: [
            // PageView for image slideshow
            SizedBox(
              height: 300, // Height of the PageView
              child: PageView.builder(
                itemCount: controller.myImage.length, // controller.farmModel.images.length,
                itemBuilder: (context, index) {
                  String urlImage = controller.myImage[index]['imageUrl'];
                  return Hero(
                    tag: controllerImp.flag ? '${controller.farmModel.id}T'
                    : '${controller.farmModel.id}E' ,
                    child: Image.network(
                      "$baseUrl/upload/$urlImage",
                      fit: BoxFit.cover,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),


            HandlingDataView(
              statusRequest: controller.statusRequest,
              widget: Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        " مزرعة ${controller.farmModel.name}",
                        style: Theme.of(context).textTheme.displayLarge!.copyWith(
                          color: AppColor.primaryColor,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "Contact:",
                      style: Theme.of(context).textTheme.headline1!.copyWith(
                        color: AppColor.primaryfourthColor,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Icon(
                          Icons.call_end_outlined,
                          color: AppColor.primarySecandColor,
                        ),
                        const SizedBox(width: 20),
                        Text(" ${controller.farmModel.phone}"),
                        const Spacer(),
                        InkWell(
                          onTap: () {
                            Clipboard.setData(ClipboardData(text: controller.farmModel.phone!));
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('تم نسخ رقم الهاتف'),
                              ),
                            );
                          },
                          child: const Icon(Icons.copy_all_outlined),
                        )
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Address:",
                      style: Theme.of(context).textTheme.headline1!.copyWith(
                        color: AppColor.primaryfourthColor,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "${controller.farmModel.address}",
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w300,
                        color: AppColor.grey2,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Price:",
                      style: Theme.of(context).textTheme.headline1!.copyWith(
                        color: AppColor.primaryfourthColor,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "${controller.farmModel.price}",
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w300,
                        color: AppColor.grey2,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Description:",
                      style: Theme.of(context).textTheme.headline1!.copyWith(
                        color: AppColor.primaryfourthColor,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "${controller.farmModel.description}",
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w300,
                        color: AppColor.grey2,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Farm Rating:',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColor.primaryfourthColor,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        RatingBarIndicator(
                          rating: controllerImp.rating ,
                          itemBuilder: (context, index) => Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          itemCount: 5,
                          itemSize: 30.0,
                          direction: Axis.horizontal,
                        ),
                        Spacer(),
                        Text(
                          '${controller.rating}/5',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: AppColor.primaryColor,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),

            // إضافة تقييم المزرعة هنا

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  void _showRatingDialog(BuildContext context, FarmDetailsControllerImp controllerImp) {
    double rating = 0.0;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Rate the Farm'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Please rate the farm:',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 20),
              RatingBar.builder(
                initialRating: 0,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (newRating) {
                  rating = newRating;
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () async {
                if (rating >= 1 && rating <= 10) {
                  await controllerImp.addRate(rating.toString());

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Rating submitted: $rating')),
                  );
                  Navigator.of(context).pop();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Invalid rating. Please select a rating.')),
                  );
                }
              },
              child: const Text('Submit'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }
}
