
import '../../../../core/class/crud.dart';
import '../../../../linkapi.dart';

class HomeData {
  Crud crud;
  HomeData(this.crud);


  getData() async {
    var response = await crud.postData(AppLink.homepage, {});
    return response.fold((l) => l, (r) => r);
  }
  searchData(String search) async {
    var response = await crud.postData(AppLink.search , {"search": search});
    return response.fold((l) => l, (r) => r);
  }

  addRate(String id_user , String id_farm , String rate) async {
    var response = await crud.postData(AppLink.addRate , {
      "id_farm": id_farm ,
      "id_user" : id_user ,
      "evaluation" : rate
    });
    return response.fold((l) => l, (r) => r);
  }

  getRate(String id_farm ) async {
    var response = await crud.postData(AppLink.getRate , {
      "id_farm": id_farm
    });
    return response.fold((l) => l, (r) => r);
  }



}
