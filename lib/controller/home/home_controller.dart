import 'package:farm/data/model/FarmModel.dart';
import 'package:farm/data/model/ServicesModel.dart';
import 'package:farm/view/screen/home/HomePage.dart';
import 'package:farm/view/widget/home/ListTop3FarmHome.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../core/class/statusrequest.dart';
import '../../core/constant/routes.dart';
import '../../core/functions/handingdatacontroller.dart';
import '../../core/services/services.dart';
import '../../data/datatsource/remote/home/home_data.dart';

abstract class HomeController extends SearchMixController {
  initialData();
  getdata();
  goToServicesDetails(ServicesModel servicesModel, int flag) ;
  goToManager();

  goToItems(List categories, int selectedCat, String categoryid);

}

class HomeControllerImp extends HomeController {
  MyServices myServices = Get.find();

  String? username;
  String? id;
  String? lang;

  HomeData homedata = HomeData(Get.find());

  // List data = [];
  List farms = [] ;
  List imageFarms = [] ;
  List top3Farms = [] ;
  List top1Farm = [] ;

  List offerFarm = [] ;




  bool isAdmin = false ;


  @override
  initialData() {

  String? state = myServices.sharedPreferences.getString("isAdmin");
  if(state == "1") isAdmin =true ;

  }

  @override
  void onInit() {

    search = TextEditingController();
    getdata();
    initialData();
    super.onInit();
  }

  @override
  getdata() async {
    statusRequest = StatusRequest.loading;
    var response = await homedata.getData();
    print("=============================== Controller $response ");

    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        farms.addAll(response['data1']);
        imageFarms.addAll(response['data2']);
        offerFarm.addAll(response['data3']);
        top3Farms.addAll(response['data4']);
        top1Farm.addAll(response['data5']);

      } else {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  @override
  goToItems(categories, selectedCat, categoryid) {
    Get.toNamed(AppRoute.items, arguments: {
      "categories": categories,
      "selectedcat": selectedCat,
      "catid": categoryid
    });
  }

  goToPageFarmDetails(FarmModel farmModel , bool flag) {
    Get.toNamed(AppRoute.FarmDetails,
        arguments:
        {
          "farmModel": farmModel,
          "imageFarms" : imageFarms,
          "flag" : flag
        });
  }

  @override
  goToServicesDetails(ServicesModel servicesModel , int flag) {
    Get.toNamed(AppRoute.ServicesDetails , arguments: {
      "servicesModel" : servicesModel ,
      "flag" : flag
    });
  }

  @override
  goToManager() {
    Get.toNamed(AppRoute.ConfirmFarm);
  }

  void goToDetails(ServicesModel servicesModel) {


  }


}

class SearchMixController extends GetxController {
  List listdata = [];

  late StatusRequest statusRequest;
  HomeData homedata = HomeData(Get.find());

  searchData() async {
    statusRequest = StatusRequest.loading;
    var response = await homedata.searchData(search!.text);
    print("=============================== Controller $response ");
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        listdata.clear();
        listdata.addAll(response['data']);
      } else {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  bool isSearch = false;
  TextEditingController? search;
  checkSearch(val) {
    if (val == "") {
      statusRequest = StatusRequest.none;
      isSearch = false;
    }
    else{
      isSearch = true ;
      searchData();
    }

    update();
  }

  onSearchItems() {
    isSearch = true;
    searchData();
    update();
  }
}
