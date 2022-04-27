import 'package:g20newapp/modules/categorias/models/story.dart';

class Receipt {
  String? userId;
  String? categoryId;
  List<Store>? stories;
  double? totalPrice;
  double? totalPriceSquare;
  String? paymentType;
  int? iV;

  Receipt(
      {this.userId,
        this.categoryId,
        this.stories,
        this.totalPrice,
        this.totalPriceSquare,
        this.paymentType,
        this.iV});

  Receipt.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    categoryId = json['categoryId'];
    if (json['stories'] != null) {
      stories = <Store>[];
      json['stories'].forEach((v) {
        stories!.add(new Store.fromJson(v));
      });
    }
    totalPrice = double.parse(json['total_price'].toString());
    totalPriceSquare = double.parse(json['total_price_square'].toString());
    paymentType = json['payment_type'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['categoryId'] = this.categoryId;
    if (this.stories != null) {
      data['stories'] = this.stories!.map((v) => v.toJson()).toList();
    }
    data['total_price'] = this.totalPrice;
    data['total_price_square'] = this.totalPriceSquare;
    data['payment_type'] = this.paymentType;
    data['__v'] = this.iV;
    return data;
  }
}