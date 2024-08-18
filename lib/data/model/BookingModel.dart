class SportBooking {
  int? id;
  int? idUser;
  int? idFarm;
  String? date;
  String? statusBooking;
  String? name;
  String? address;
  String? phone;
  String? description;
  String? password;
  String? urlImage;
  int? price;

  SportBooking(
      {this.id,
        this.idUser,
        this.idFarm,
        this.date,
        this.statusBooking,
        this.name,
        this.address,
        this.phone,
        this.description,
        this.password,
        this.urlImage,
        this.price});

  SportBooking.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idUser = json['id_user'];
    idFarm = json['id_farm'];
    date = json['date'];
    statusBooking = json['statusBooking'];
    name = json['name'];
    address = json['address'];
    phone = json['phone'];
    description = json['description'];
    password = json['password'];
    urlImage = json['urlImage'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['id_user'] = this.idUser;
    data['id_farm'] = this.idFarm;
    data['date'] = this.date;
    data['statusBooking'] = this.statusBooking;
    data['name'] = this.name;
    data['address'] = this.address;
    data['phone'] = this.phone;
    data['description'] = this.description;
    data['password'] = this.password;
    data['urlImage'] = this.urlImage;
    data['price'] = this.price;
    return data;
  }
}
