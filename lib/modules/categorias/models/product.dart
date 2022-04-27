class Product {
  String? sId;
  String? name;
  String? img;
  double? price;
  double? priceSquare;
  int count =0;
  int? iV;

  Product(
      {this.sId,
        this.name,
        this.img,
        this.price,
        this.priceSquare,
        this.count =0,
        this.iV});

  Product.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    img = json['img'];
    price = double.parse(json['price'].toString());
    priceSquare = double.parse(json['price_square'].toString());
    count = json['count'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['img'] = this.img;
    data['price'] = this.price;
    data['price_square'] = this.priceSquare;
    data['count'] = this.count;
    data['__v'] = this.iV;
    return data;
  }
}


