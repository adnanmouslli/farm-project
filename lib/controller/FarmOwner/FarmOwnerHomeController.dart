import 'package:get/get.dart';

class FarmOwnerHomeController extends GetxController{


late var farm ;

@override
  void onInit() {

     farm = Get.arguments["data"] ;


    super.onInit();
  }

}