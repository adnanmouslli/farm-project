
import '../../../../core/class/crud.dart';
import '../../../../linkapi.dart';

class AdminData {
  Crud crud;

  AdminData(this.crud);


  getFarms() async {
    var response = await crud.postData(AppLink.get_pending_farms, {});
    return response.fold((l) => l, (r) => r);
  }

  deleteFarme(String id_farm) async {
    var response = await crud.postData(AppLink.delete_farm, {"id_farm" : id_farm});
    return response.fold((l) => l, (r) => r);
  }

  updateStatus(String id_farm)async {

    var response = await crud.postData(AppLink.updateStatus, {"id_farm" : id_farm});
    return response.fold((l) => l, (r) => r);

  }








}
