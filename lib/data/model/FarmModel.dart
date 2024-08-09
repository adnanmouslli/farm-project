class FarmModel {
  int? id;
  String? name;
  String? address;
  String? phone;
  String? description;
  String? password;
  String? status;
  String? urlImage;

  FarmModel(
      {this.id,
        this.name,
        this.address,
        this.phone,
        this.description,
        this.password,
        this.status,
        this.urlImage
        });

  FarmModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    address = json['address'];
    phone = json['phone'];
    description = json['description'];
    password = json['password'];
    status = json['status'];
    urlImage = json['urlImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['address'] = this.address;
    data['phone'] = this.phone;
    data['description'] = this.description;
    data['password'] = this.password;
    data['status'] = this.status;
    data['urlImage'] = this.urlImage;
    return data;
  }
}
