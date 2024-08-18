

import '../../../../core/class/crud.dart';
import '../../../../linkapi.dart';


class LogInData {

  Crud crud ;

  LogInData(this.crud) ;

  postData( String email , String password) async {

    var response = await crud.postData(AppLink.login, {
      "email" :  email,
      "password" : password ,
    });
    print(response) ;
    return response.fold((l) => l, (r) => r) ;

  }

  postDataFarm(String email , String password) async {
    var response = await crud.postData(AppLink.loginFarm, {
      "email" :  email,
      "password" : password ,
    });
    print(response) ;
    return response.fold((l) => l, (r) => r) ;

  }


}
