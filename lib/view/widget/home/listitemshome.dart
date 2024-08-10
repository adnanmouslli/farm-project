
import 'package:farm/data/model/EmployeesModel.dart';
import 'package:farm/data/model/FarmModel.dart';
import 'package:farm/data/model/OfferModel.dart';
import 'package:farm/data/model/ServicesModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/home/home_controller.dart';
import '../../../core/constant/color.dart';
import '../../../core/constant/imagasset.dart';
import '../../../linkapi.dart';

class ListOffersHome extends GetView<HomeControllerImp> {



  const ListOffersHome( {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeControllerImp controllerImp = Get.put(HomeControllerImp());
    return SizedBox(
      height: 260,
      child: ListView.separated(
          separatorBuilder: (context, index) => const SizedBox(width: 10),
          itemCount: controllerImp.offerFarm.length ,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, i) {

            OfferModel offerModel = OfferModel.fromJson(controller.offerFarm[i]);
            late FarmModel farmModel ;
            for(int j =0  ;j < controllerImp.farms.length ; j++){
              if(controllerImp.farms[j]['id'] == offerModel.idFarm){
                farmModel = FarmModel.fromJson(controllerImp.farms[j]);
                break ;
              }
            }

            return OfferFarms(
                 offerModel: offerModel,
                 onTap: () {
                    controller.goToPageFarmDetails(farmModel , false);
                  },

            );
          }),
    );
  }
}




class OfferFarms extends StatelessWidget {
  final OfferModel offerModel;

  final void Function()? onTap ;
   OfferFarms({Key? key, required this.offerModel , required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 5,
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Row(children: [
                // اسم المزرعة
                Text(
                  offerModel.name!,
                  style: Theme.of(context).textTheme.headline6!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.green[700],
                    fontSize: 16, // تعديل حجم الخط
                  ),
                ),


              ],) ,

              const SizedBox(height: 10),
              // وصف العرض
              Text(
                offerModel.description!,
                style: Theme.of(context).textTheme.bodyText2!.copyWith(
                  color: Colors.grey[700],
                  fontSize: 14, // تعديل حجم الخط
                ),
              ),
              const SizedBox(height: 10),
              // عرض السعر القديم والجديد
              Row(
                children: [
                  Text(
                    'Old Price: ',
                    style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      fontSize: 14, // تعديل حجم الخط
                    ),
                  ),
                  Text(
                    '\$${offerModel.price}', // السعر القديم
                    style: Theme.of(context).textTheme.headline6!.copyWith(
                      color: Colors.red, // لون أحمر للسعر القديم
                      decoration: TextDecoration.lineThrough, // خط يتوسط السعر القديم
                      fontSize: 14, // تعديل حجم الخط
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'New Price: ',
                    style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      fontSize: 14, // تعديل حجم الخط
                    ),
                  ),
                  Text(
                    '\$${offerModel.offerValue}', // السعر الجديد
                    style: Theme.of(context).textTheme.headline6!.copyWith(
                      color: Colors.green, // لون أخضر للسعر الجديد
                      fontWeight: FontWeight.bold,
                      fontSize: 14, // تعديل حجم الخط
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              // أيام العرض
              Row(
                children: [
                  const Icon(
                    Icons.calendar_today,
                    color: Colors.blueAccent,
                    size: 18,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    offerModel.offerDay!,
                    style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      color: Colors.blueAccent,
                      fontWeight: FontWeight.w500,
                      fontSize: 14, // تعديل حجم الخط
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 15),
              // زر عرض التفاصيل
             Container(
                 margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                 height: 30,
                 child: MaterialButton(
                     shape: RoundedRectangleBorder(
                         borderRadius: BorderRadius.circular(10)),
                     color: AppColor.primarySecandColor,
                     onPressed: onTap,
                     child: const Text(
                       "view farm",
                       style: TextStyle(
                           color: Colors.white, fontWeight: FontWeight.bold),
                     )))

            ],
          ),
        ),
      );

  }
}
