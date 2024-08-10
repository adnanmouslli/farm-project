import 'package:farm/core/constant/imagasset.dart';
import 'package:farm/data/model/FarmModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/admin/confirmFarm_controller.dart';
import '../../../core/class/handlingdataview.dart';
import '../../../core/functions/dialogueConfirm.dart';


class ConfirmFarm extends StatelessWidget {
  const ConfirmFarm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(ConfirmFarmController()) ;
    return
      Scaffold(
        appBar: AppBar(
          title: Text('Pending Farms'),
        ),
        body:GetBuilder<ConfirmFarmController>(
          builder: (controller) =>
              HandlingDataView(
                statusRequest: controller.statusRequest ,
                widget:
                ListView.builder(
                  itemCount: controller.pendingFarms.length,
                  itemBuilder: (context, index) {
                    FarmModel farmModel = FarmModel.fromJson(controller.pendingFarms[index]);
                    return Container(
                      height: 150 ,
                      child: Card(
                        child: Center(
                          child: Column(mainAxisSize: MainAxisSize.min, children: [
                            Row(
                              children: [
                                Spacer(),
                                Column(children: [
                                  Text(farmModel.name! , style: TextStyle(fontWeight: FontWeight.w600 , color: Colors.black),) ,
                                  Text('address : ${farmModel.address}') ,
                                  Text('phone : ${farmModel.phone}') ,
                                  Text('price : ${farmModel.price}') ,


                                ],),

                                Spacer(),
                              ],
                            ) ,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [

                                InkWell(
                                  borderRadius: BorderRadius.circular(30),
                                  onTap: (){
                                    dialogueConfirm("تأكيد إضافة المزرعة ؟" , (){
                                      controller.confirmFarm(index);
                                      Get.back() ;
                                      controller.update();
                                    });
                                  },
                                  child: const Icon(
                                    Icons.add_task_outlined,
                                    color: Colors.green,
                                    size: 30,
                                  ),
                                ),
                                SizedBox(width: 30,),
                                InkWell(
                                  borderRadius: BorderRadius.circular(30),
                                  onTap: (){
                                    dialogueConfirm("تأكيد حذف المزرعة ؟" , (){
                                      controller.deleteFarm(index);
                                      Get.back() ;
                                      controller.update();

                                    }) ;
                                  },
                                  child: const Icon(
                                    Icons.cleaning_services_outlined,
                                    color: Colors.red,
                                    size: 30,
                                  ),
                                ),

                              ],)

                          ]),
                        ),
                      ),
                    );
                  },
                ),
              ),

        ) ,


      );

  }

}
