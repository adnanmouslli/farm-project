
import 'package:farm/core/constant/routes.dart';
import 'package:farm/data/datatsource/remote/home/home_data.dart';
import 'package:farm/data/model/EmployeesModel.dart';
import 'package:farm/data/model/FarmModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/class/statusrequest.dart';
import '../core/services/services.dart';


class FarmDetailsControllerImp extends GetxController{
  // CartController cartController = Get.put(CartController());

  late FarmModel farmModel;

  HomeData homeData = HomeData(Get.find());

  late StatusRequest statusRequest;

  MyServices myServices = Get.find();

  int countitems = 5;

  List imageFarms = [] ;

  List myImage = [] ;


  intialData() async {
    statusRequest = StatusRequest.loading;
    farmModel = Get.arguments['farmModel'];
    imageFarms = Get.arguments['imageFarms'] ;

    for(int i = 0 ; i < imageFarms.length ; i++){
      if(imageFarms[i]['id_farm'] == farmModel.id)
        myImage.add(imageFarms[i]);
    }

    print("farm id = ");
    print(farmModel.id);
    //countitems = await getCountItems(itemsModel.itemsId!);
    statusRequest = StatusRequest.success;
    update();
  }

  viewServices(){
    Get.toNamed(AppRoute.items , arguments:
    {
      "farmModel": farmModel ,
      "imageFarms" : imageFarms
    }
    ) ;
  }


  // getCountItems(String itemsid) async {
  //   statusRequest = StatusRequest.loading;
  //   var response = await cartData.getCountCart(
  //       myServices.sharedPreferences.getString("id")!, itemsid);
  //   print("=============================== Controller $response ");
  //   statusRequest = handlingData(response);
  //   if (StatusRequest.success == statusRequest) {
  //     // Start backend
  //     if (response['status'] == "success") {
  //       int countitems = 0;
  //       countitems = int.parse(response['data']);
  //       print("==================================");
  //       print("$countitems");
  //       return countitems;
  //       // data.addAll(response['data']);
  //     } else {
  //       statusRequest = StatusRequest.failure;
  //     }
  //     // End
  //   }
  // }

  // addItems(String itemsid) async {
  //   statusRequest = StatusRequest.loading;
  //   update();
  //   var response = await cartData.addCart(
  //       myServices.sharedPreferences.getString("id")!, itemsid);
  //   print("=============================== Controller $response ");
  //   statusRequest = handlingData(response);
  //   if (StatusRequest.success == statusRequest) {
  //     // Start backend
  //     if (response['status'] == "success") {
  //       Get.rawSnackbar(
  //           title: "اشعار",
  //           messageText: const Text("تم اضافة المنتج الى السلة "));
  //       // data.addAll(response['data']);
  //     } else {
  //       statusRequest = StatusRequest.failure;
  //     }
  //     // End
  //   }
  //   update();
  // }

  // deleteitems(String itemsid) async {
  //   statusRequest = StatusRequest.loading;
  //   update();
  //
  //   var response = await cartData.deleteCart(
  //       myServices.sharedPreferences.getString("id")!, itemsid);
  //   print("=============================== Controller $response ");
  //   statusRequest = handlingData(response);
  //   if (StatusRequest.success == statusRequest) {
  //     // Start backend
  //     if (response['status'] == "success") {
  //       Get.rawSnackbar(
  //           title: "اشعار",
  //           messageText: const Text("تم ازالة المنتج من السلة "));
  //       // data.addAll(response['data']);
  //     } else {
  //       statusRequest = StatusRequest.failure;
  //     }
  //     // End
  //   }
  //   update();
  // }

  List subitems = [
    {"name": "red", "id": 1, "active": '0'},
    {"name": "yallow", "id": 2, "active": '0'},
    {"name": "black", "id": 3, "active": '1'}
  ];

  // add() {
  //   addItems(itemsModel.itemsId!);
  //   countitems++;
  //   update();
  // }
  //
  // remove() {
  //   if (countitems > 0) {
  //     deleteitems(itemsModel.itemsId!);
  //     countitems--;
  //     update();
  //   }
  // }

  @override
  void onInit() {
    intialData();
    super.onInit();
  }
}
