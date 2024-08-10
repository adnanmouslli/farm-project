class OfferModel {
  int? id;
  int? idFarm;
  String? description;
  String? offerValue;
  String? offerDay;
  String? name;
  int? price ;

  OfferModel(
      {this.id,
        this.idFarm,
        this.description,
        this.offerValue,
        this.offerDay,
        this.name,
        this.price
      });

  OfferModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idFarm = json['id_farm'];
    description = json['description'];
    offerValue = json['offer_value'];
    offerDay = json['offer_day'];
    name = json['name'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['id_farm'] = this.idFarm;
    data['description'] = this.description;
    data['offer_value'] = this.offerValue;
    data['offer_day'] = this.offerDay;
    data['name'] = this.name;
    data['price'] = this.price;
    return data;
  }
}
