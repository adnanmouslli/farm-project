import 'package:farm/core/constant/imagasset.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../controller/farmdetails_controller.dart';
import '../../core/class/handlingdataview.dart';
import '../../core/constant/color.dart';
import '../../core/constant/routes.dart';
import '../../linkapi.dart';
import '../widget/productdetails/priceandcount.dart';
import '../widget/productdetails/subitemslist.dart';
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
            child: MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                color: AppColor.primarySecandColor,
                onPressed: () {
                  controllerImp.viewServices();
                  // Get.toNamed(AppRoute.cart);
                },
                child: const Text(
                  "view services",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ))),
        body: GetBuilder<FarmDetailsControllerImp>(
            builder: (controller) => ListView(children: [
              // PageView for image slideshow
              SizedBox(
                height: 300, // Height of the PageView
                child: PageView.builder(
                  itemCount: controller.myImage.length , // controller.farmModel.images.length,
                  itemBuilder: (context, index) {
                    String urlImage = controller.myImage[index]['imageUrl'];
                    return
                      Image.network(
                      "$baseUrl/upload/$urlImage",
                      fit: BoxFit.cover,
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
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
                              style: Theme.of(context)
                                  .textTheme
                                  .displayLarge!
                                  .copyWith(
                                color: AppColor.primaryColor,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text("Contact:",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline1!
                                  .copyWith(
                                color: AppColor.primaryfourthColor,
                              )),
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
                                  Clipboard.setData(ClipboardData(
                                      text: controller.farmModel.phone!));
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(
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
                          Text("Description:",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline1!
                                  .copyWith(
                                color: AppColor.primaryfourthColor,
                              )),
                          const SizedBox(height: 10),
                          Text("${controller.farmModel.description}",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w300,
                                  color: AppColor.grey2)),
                          const SizedBox(height: 20),
                        ]),
                  ))
            ])));
  }
}
