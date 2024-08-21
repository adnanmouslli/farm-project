import 'package:farm/data/datatsource/remote/admin/admin_data.dart';
import 'package:farm/data/datatsource/remote/booking/booking_data.dart';
import 'package:farm/data/model/BookingModel.dart';
import 'package:farm/data/model/FarmModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/class/statusrequest.dart';
import '../../core/functions/handingdatacontroller.dart';
import '../../core/services/services.dart';



class ConfirmFarmController extends GetxController {

  late StatusRequest statusRequest = StatusRequest.none;

  AdminData adminData = AdminData(Get.find()) ;

  MyServices myServices = Get.find();
  List pendingFarms = [] ;
  late int user_id ;
  late String username ;
  late String email ;
  late String phone ;

  getData() async {
    statusRequest = StatusRequest.loading;
    var response = await adminData.getFarms();
    print("=============================== Controller $response ");
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        pendingFarms.addAll(response['data']);
      } else {
        statusRequest = StatusRequest.failure;
      }
    }
    print(statusRequest) ;
    update();
  }

  confirmFarm(int index) async {
    FarmModel farmModel = FarmModel.fromJson(pendingFarms[index]);
    var response = await adminData.updateStatus(farmModel.id!.toString()) ;
    if(response['status'] == "success")
    {
      pendingFarms.removeAt(index);
      update();
      Get.snackbar(
        'الحجوزات',
        'تم تأكيد الموعد وارسال اشعار الى صاحب الموعد',
        duration: Duration(seconds: 3), // Set the duration to 3 seconds
        backgroundColor: Colors.green, // Set the background color to green
        colorText: Colors.white, // Set the text color to white
        shouldIconPulse: true, // Make the icon pulse
        snackPosition: SnackPosition.BOTTOM, // Set the position to bottom
      );
    }
  }

  deleteFarm(int index)
  async {
    FarmModel farmModel = FarmModel.fromJson(pendingFarms[index]);

    var response = await adminData.deleteFarme(farmModel.id!.toString()) ;

    if(response['status'] == "success")
      {
        pendingFarms.removeAt(index);
        update();
        Get.snackbar(
          'manager',
          'farm delete',
          duration: Duration(seconds: 3), // Set the duration to 3 seconds
          backgroundColor: Colors.green, // Set the background color to green
          colorText: Colors.white, // Set the text color to white
          shouldIconPulse: true, // Make the icon pulse
          snackPosition: SnackPosition.BOTTOM, // Set the position to bottom
        );
      }


  }


  @override
  void onInit() async {

    user_id = myServices.sharedPreferences.getInt("user_id")!;
    username = myServices.sharedPreferences.getString("username")!;
    email = myServices.sharedPreferences.getString("email")!;
    phone = myServices.sharedPreferences.getString("phone")!;


    await getData() ;
    super.onInit();


  }







}