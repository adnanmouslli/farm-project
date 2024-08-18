import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../core/class/statusrequest.dart';
import '../../core/constant/routes.dart';
import '../../core/functions/handingdatacontroller.dart';
import '../../core/services/services.dart';
import '../../data/datatsource/remote/auth/login.dart';

class LoginControlerImp extends GetxController {
  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  late TextEditingController email;
  late TextEditingController password;
  bool isshowpassword = true;
  bool isInternet = true;
  MyServices myServices = Get.find();

  LogInData logInData = LogInData(Get.find());

  StatusRequest? statusRequest = StatusRequest.none;

  // متغير لتخزين نوع الحساب المختار
  String selectedAccountType = 'User';

  showPassword() {
    isshowpassword = isshowpassword == true ? false : true;
    update();
  }

  // تحديث نوع الحساب المختار
  void setAccountType(String accountType) {
    selectedAccountType = accountType;
    update();
  }

  login(BuildContext context) async {
    var formdata = formstate.currentState;
    if (formdata!.validate()) {
      try {
        statusRequest = StatusRequest.loading;
        update();

        if (selectedAccountType == 'User') {


          var response = await logInData.postData(email.text, password.text);
          print("=============================== Controller $response ");
          statusRequest = handlingData(response);
          if (StatusRequest.success == statusRequest) {
            if (response['status'] == "success") {
              myServices.sharedPreferences.setInt("user_id", response['data']['id']);
              myServices.sharedPreferences.setString("username", response['data']['username']);
              myServices.sharedPreferences.setString("email", response['data']['email']);
              myServices.sharedPreferences.setInt("phone", response['data']['phone']);
              myServices.sharedPreferences.setString("password", response['data']['password']);
              myServices.sharedPreferences.setString("isAdmin", response['data']['isAdmin']);
              myServices.sharedPreferences.setString("step", "2");
              Get.offNamed(AppRoute.homePage);

            } else {
              Get.defaultDialog(title: "Warning", middleText: "No user found for that email");
              statusRequest = StatusRequest.failure;
            }
          }


        } else if (selectedAccountType == 'Farm Owner') {

          var response = await logInData.postDataFarm(email.text, password.text);
          print("=============================== Controller $response ");
          statusRequest = handlingData(response);
          if (StatusRequest.success == statusRequest) {
            if (response['status'] == "success") {
              Get.offNamed(AppRoute.farmOwnerHome ,
              arguments:  {
                "data" : response['data']
              }
              );

            } else {
              Get.defaultDialog(title: "Warning", middleText: "No user found for that email");
              statusRequest = StatusRequest.failure;
            }
          }

        }

        update();
      } catch (e) {
        print(e);
      }
    } else {
      print("not valid");
    }
  }

  goToSignUp() {
    Get.offNamed(AppRoute.signup);
  }

  @override
  void onInit() {
    email = TextEditingController();
    password = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

}