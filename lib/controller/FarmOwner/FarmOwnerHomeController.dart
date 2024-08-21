import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

import '../../data/datatsource/remote/farmOwner/farm-data.dart';
import '../../linkapi.dart';

class FarmOwnerHomeController extends GetxController {
  late var farm;
  FarmData farmData = FarmData(Get.find());

  // قائمة لصور المزرعة
  List farmImages = [];

  List bookings = [];

  final ImagePicker _picker = ImagePicker();
  final String ip = AppLink.server;

  // متحكمات النصوص للعروض
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController offerValueController = TextEditingController();
  final TextEditingController offerDayController = TextEditingController();

  List<String> selectedDays = []; // قائمة الأيام المختارة

  final List<String> allDays = [
    "أحد", "اثنين", "ثلاثاء", "أربعاء", "خميس", "جمعة", "سبت"
  ];

  void selectDays(List<String> days) {
    selectedDays = days;
    update();
  }

  String getFormattedDays() {
    return selectedDays.join('-'); // تحويل قائمة الأيام إلى سلسلة نصية بالشكل المطلوب
  }


  // جلب الصور من السيرفر
  Future<void> fetchFarmImages() async {
    farmImages.clear();
    var response = await farmData.getImageFarm(farm['id'].toString());
    if (response['status'] == 'success') farmImages.addAll(response['data']);
    update();
  }

  Future<void> fetchFarmBooking() async {
    bookings.clear();
    var response = await farmData.getFarmBooking(farm['id'].toString());
    if (response['status'] == 'success') bookings.addAll(response['data']);
    update();
  }

  void confirmBooking(int bookingId) async {
    var response = await farmData.confirmBooking(bookingId.toString());
    if (response['status'] == 'success') {
      final booking = bookings.firstWhere((b) => b['id'] == bookingId);
      booking['statusBooking'] = 'confirmed';
    }
    update();
  }

  void rejectBooking(int bookingId) async {
    var response = await farmData.rejectBooking(bookingId.toString());
    if (response['status'] == 'success') {
      bookings.removeWhere((b) => b['id'] == bookingId);
      update();
    }
  }

  // تحميل صورة جديدة
  Future<void> uploadImage(File image) async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse(AppLink.addImage), // رابط الـ API في الخادم
    );

    // إضافة حقول البيانات
    request.fields['id_farm'] = farm['id'].toString();

    // إضافة الصورة كجزء من البيانات
    request.files.add(
      await http.MultipartFile.fromPath(
        'image',
        image.path,
        filename: basename(image.path),
      ),
    );

    // إرسال الطلب
    var response = await request.send();
    var responseData = await response.stream.bytesToString();

    if (response.statusCode == 200) {
      var jsonData = json.decode(responseData);
      farmImages.add(jsonData['data']);
      Get.snackbar('Success', 'Image uploaded successfully');
    } else {
      Get.snackbar('Error', 'Failed to upload image');
    }
    update();
  }

  // حذف صورة
  Future<void> deleteImage(int index) async {
    var response = await farmData.deleteImage(farmImages[index]['id'].toString());
    if (response['status'] == 'success') {
      farmImages.removeAt(index);
      fetchFarmImages();
      Get.snackbar('Success', 'Image deleted successfully');
    } else {
      Get.snackbar('Error', 'Failed to delete image');
    }
    update();
  }

  // اختيار صورة من المعرض وتحميلها
  Future<void> pickAndUploadImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      await uploadImage(File(image.path));
    }
  }

  // إضافة عرض
  Future<void> addOffer() async {
    var response = await farmData.addOffer({
      'id_farm': farm['id'].toString(),
      'description': descriptionController.text,
      'offer_value': offerValueController.text,
      'offer_day': offerDayController.text,
    });

    if (response['status'] == 'success') {
      descriptionController.clear();
      offerDayController.clear();
      offerValueController.clear();
      Get.snackbar('Success', 'Offer added successfully');
    } else {
      Get.snackbar('Error', 'Failed to add offer');
    }
    update();
  }



  List farmOffers = [];

  Future<void> fetchFarmOffers() async {
  farmOffers.clear();
  var response = await farmData.getFarmOffers(farm['id'].toString());
  if (response['status'] == 'success') {
   farmOffers.addAll(response['data']);
  }
  update();
  }

  @override
  void onInit() {
    farm = Get.arguments["data"];
    fetchFarmImages();
    fetchFarmBooking();
    fetchFarmOffers();
    super.onInit();
  }

  @override
  void refresh() {
    // TODO: implement refresh
      super.refresh();
  }
}
