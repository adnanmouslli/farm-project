
import 'package:farm/core/constant/imagasset.dart';
import 'package:farm/data/model/FarmModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../controller/home/home_controller.dart';
import '../../../core/constant/color.dart';
import '../../../linkapi.dart';

class ListEmployeesHome extends GetView<HomeControllerImp> {
  const ListEmployeesHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: ListView.separated(
        separatorBuilder: (context, index) => const SizedBox(width: 10),
        itemCount: controller.farms.length ,
        scrollDirection: Axis.horizontal ,
        itemBuilder: (context, index) {

          return
            Farms(
              i: index,
              farmModel:
              FarmModel.fromJson(controller.farms[index]),
          );

        },
      ),
    );
  }
}

class Farms extends GetView<HomeControllerImp> {

  final   FarmModel farmModel;
  final int? i;
  const Farms({Key? key, required this.farmModel, required this.i})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(30),
      onTap: () {
        controller.goToPageFarmDetails(farmModel) ;
        //controller.goToItems(controller.categories, i! , categoriesModel.categoriesId!);
      },
      child: Column(
        children: [
          Container(

            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(

                color: AppColor.primaryThreeColor,
                borderRadius: BorderRadius.circular(20)

                ),
           // padding: const EdgeInsets.symmetric(horizontal: 10),
            height: 80,
            width: 80,
            child: Hero(tag: '${farmModel.id}E' ,
            child: Image.asset("${AppImageAsset.rootImages}/${farmModel.urlImage}" , fit: BoxFit.cover,)) ,

             // SvgPicture.asset( AppImageAsset.logo ,
             //     "${AppLink.imagestCategories}/${categoriesModel.categoriesImage}",
             //    color: AppColor.primarySecandColor),
           ),
          Text( "${farmModel.name}" ,
            //"${translateDatabase(categoriesModel.categoriesNamaAr, categoriesModel.categoriesName)}",
            style: const TextStyle(fontSize: 13, color: AppColor.black),
          )
        ],
      ),
    );
  }
}
