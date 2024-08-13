
import 'package:farm/core/constant/routes.dart';
import 'package:farm/data/datatsource/remote/home/home_data.dart';
import 'package:farm/data/model/EmployeesModel.dart';
import 'package:farm/data/model/FarmModel.dart';
import 'package:farm/linkapi.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';

import '../core/class/crud.dart';
import '../core/class/statusrequest.dart';
import '../core/services/services.dart';
import 'package:http/http.dart' as http;


class FarmDetailsControllerImp extends GetxController{
  // CartController cartController = Get.put(CartController());

  late FarmModel farmModel;
    double rating = 0.0 ;

  HomeData homeData = HomeData(Get.find());

  late StatusRequest statusRequest;

  MyServices myServices = Get.find();

  int countitems = 5;

  List imageFarms = [];

  List myImage = [];

  int userId = 0;
  bool flag = false ;

  intialData() async {
    statusRequest = StatusRequest.loading;
    farmModel = Get.arguments['farmModel'];
    imageFarms = Get.arguments['imageFarms'] ;
    flag = Get.arguments['flag'] ;
    userId = myServices.sharedPreferences.getInt("user_id")!;


    String originalImage = farmModel.urlImage! ;
    myImage.add({
      "id": 1,
      "id_farm": 1,
      "imageUrl": originalImage}

    );

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



  Future<void> addRate(String rate) async {

  int id = farmModel.id! ;
  var res = await homeData.addRate('$userId', '$id', rate) ;

  rating = await getRate(farmModel.id!.toString());

  update();

  }

  Future<double> getRate(String id_farm) async {
    var res = await homeData.getRate(id_farm);

    double rating = (res['data'] as num).toDouble(); // تحويل إلى double
    return rating;

  }

  goToBookingFarm(){
    Get.toNamed(AppRoute.BookingFarm ,
        arguments:
        {
         "farmModel" : farmModel
        }) ;
  }

  @override
  void onInit() async {
    intialData();

    try {
      rating = await getRate(farmModel.id!.toString());
    } catch (e) {
      print('Failed to get rating: $e');
    }
    update() ;

    super.onInit();
  }

}