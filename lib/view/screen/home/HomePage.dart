import 'package:cached_network_image/cached_network_image.dart';
import 'package:farm/data/model/FarmModel.dart';
import 'package:farm/view/widget/home/ListTop3FarmHome.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../../../controller/home/home_controller.dart';
import '../../../core/class/handlingdataview.dart';
import '../../../core/constant/color.dart';
import '../../../core/constant/imagasset.dart';
import '../../../core/constant/routes.dart';
import '../../../data/model/ServicesModel.dart';
import '../../widget/home/customappbar.dart';
import '../../widget/home/customcardhome.dart';
import '../../widget/home/customtitlehome.dart';
import '../../widget/home/ListFarmHome.dart';
import '../../widget/home/listitemshome.dart';
import '../../widget/items/CustomItem.dart';
import 'package:get/get_core/src/get_main.dart';

class Home_page extends GetView<HomeControllerImp> {
  const Home_page({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {

   Get.put(HomeControllerImp());
    return GetBuilder<HomeControllerImp>(
        builder: (controller) => Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: ListView(
              children: [
                CustomAppBar(
                  mycontroller: controller.search!,
                  titleappbar: "Find Farm",
                  // onPressedIcon: () {},
                  onPressedSearch: () {
                    controller.onSearchItems();
                  },
                  onChanged: (val) {
                    controller.checkSearch(val);
                  },
                   onPressedIcon: () {
                    controller.goToManager();
                   }, isAdmin: controller.isAdmin,

                ),
                HandlingDataView(
                    statusRequest: controller.statusRequest,
                    widget: !controller.isSearch
                        ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:   [
                        CustomCardHome(),
                        CustomTitleHome(title: "Farms"),
                        ListFarmHome(),
                        CustomTitleHome(title: "Top 3 farms"),
                        ListTop3FarmHome(),
                        CustomTitleHome(title: "Offers"),
                        ListOffersHome(),




                        SizedBox(height: 20,)
                      ],
                    )
                        : ListItemsSearch(listdata: controller.listdata) )

                // const CustomTitleHome(title: "Offer"),
               //  const ListItemsHome()
              ],
            )));

    }
}

class ListItemsSearch extends GetView<HomeControllerImp> {
  final List listdata;
  const ListItemsSearch({Key? key, required this.listdata})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      height: 680,
      child:
      GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: listdata.length,
          gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, childAspectRatio: 0.7),
          itemBuilder: (BuildContext context, index) {
            // ServicesModel servicesModel = ServicesModel.fromJson(listdata[index]);
            FarmModel farmModel = FarmModel.fromJson(listdata[index]) ;
            return
              InkWell(
                  onTap: () {
                    controller.goToPageFarmDetails(farmModel , false) ;
                  },
                  child: CustomListItems(
                    ImageUrl: AppImageAsset.logo,
                    price: farmModel.price!,
                    desc: farmModel.name!,
                    tag: farmModel.id!,
                    active: '0',
                    action: () {
                      // controller.favorite(
                      //     '${data['items_id']}',
                      //     '${data['items_favorit']}',
                      //     '${data['id_document']}'
                      // );
                    },
                  )
              );
          }),
    );
  }
}