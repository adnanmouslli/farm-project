


import '../../../../core/class/crud.dart';
import '../../../../linkapi.dart';

class FarmData {
  Crud crud;

  FarmData(this.crud);

  getImageFarm(String idFarm) async {
    var response = await crud.postData(AppLink.getImage, {
      "id_farm" : idFarm
    });
    return response.fold((l) => l, (r) => r);

  }

  deleteImage(String id) async {
    var response = await crud.postData(AppLink.deleteImage, {
      "id" : id
    });
    return response.fold((l) => l, (r) => r);
  }

  getFarmBooking(String idFarm)async {
    var response = await crud.postData(AppLink.getFarmBooking, {
      "id_farm" : idFarm
    });
    return response.fold((l) => l, (r) => r);
  }

  confirmBooking(String idBooking)async {
    var response = await crud.postData(AppLink.confirmBooking, {
      "idBooking" : idBooking
    });
    return response.fold((l) => l, (r) => r);

  }


  rejectBooking(String idBooking) async {
    var response = await crud.postData(AppLink.rejectBooking, {
      "idBooking" : idBooking
    });
    return response.fold((l) => l, (r) => r);


  }

  addOffer(Map<String , dynamic> data) async{

    var response = await crud.postData(AppLink.addOffer ,  data);
    return response.fold((l) => l, (r) => r);
  }

  getFarmOffers(String id_farm) async {
    var response = await crud.postData(AppLink.getFarmOffers , {"id_farm" : id_farm});
    return response.fold((l) => l, (r) => r);

  }

}
