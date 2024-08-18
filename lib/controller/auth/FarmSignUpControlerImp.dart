import 'dart:io';
import 'package:farm/core/constant/routes.dart';
import 'package:farm/linkapi.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

import '../../core/class/statusrequest.dart';

class FarmSignUpControlerImp extends GetxController {
  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  late TextEditingController name;
  late TextEditingController email;
  late TextEditingController address;
  late TextEditingController phone;
  late TextEditingController description;
  late TextEditingController password;
  late TextEditingController price;

  File? farmImage;  // لتخزين الصورة المختارة
  StatusRequest? statusRequest = StatusRequest.none;
  final ImagePicker _picker = ImagePicker();

  @override
  void onInit() {
    name = TextEditingController();
    email = TextEditingController();
    address = TextEditingController();
    phone = TextEditingController();
    description = TextEditingController();
    password = TextEditingController();
    price = TextEditingController();
    super.onInit();
  }

  // وظيفة لاختيار الصورة من المعرض
  pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      farmImage = File(image.path);
      update();  // لتحديث الواجهة بعد اختيار الصورة
    }
  }

  // وظيفة رفع الصورة وإرسال البيانات إلى الخادم
  Future<void> signUp(BuildContext context) async {
    if (formstate.currentState!.validate()) {
      try {
        statusRequest = StatusRequest.loading;
        update();

        // إعداد طلب رفع متعدد الأجزاء
        var request = http.MultipartRequest(
          'POST',
          Uri.parse(AppLink.farmSignUp),  // رابط الـ API في الخادم
        );

        // إضافة حقول البيانات
        request.fields['name'] = name.text;
        request.fields['email'] = email.text;
        request.fields['address'] = address.text;
        request.fields['phone'] = phone.text;
        request.fields['description'] = description.text;
        request.fields['password'] = password.text;
        request.fields['price'] = price.text;

        // إضافة الصورة كجزء من البيانات
        if (farmImage != null) {
          request.files.add(
            await http.MultipartFile.fromPath(
              'image',
              farmImage!.path,
              filename: basename(farmImage!.path),
            ),
          );
        }

        // إرسال الطلب
        var response = await request.send();

        if (response.statusCode == 200) {
          Get.offNamed(AppRoute.successSignUp);
          statusRequest = StatusRequest.success;
        } else {
          // إذا فشل الرفع
          statusRequest = StatusRequest.failure;
        }
      } catch (e) {
        print(e);
        statusRequest = StatusRequest.error;
      }

      update();
    }
  }

  @override
  void dispose() {
    name.dispose();
    email.dispose();
    address.dispose();
    phone.dispose();
    description.dispose();
    password.dispose();
    price.dispose();
    super.dispose();
  }

}