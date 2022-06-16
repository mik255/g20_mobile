import 'package:g20newapp/modules/categorias/models/product.dart';
import 'package:g20newapp/modules/categorias/models/story.dart';

import '../../../util/paymentToString.dart';

class ReceiptStories {
  Store? storeId;
  String? paymentType;
  List<Product>? products;
  String? nId;
  ReceiptStories({this.storeId, this.products, this.nId, this.paymentType});

  ReceiptStories.fromJson(Map<String, dynamic> json) {
    storeId =
        json['store_id'] != null ? new Store.fromJson(json['store_id']) : null;
    paymentType = json['payment_type'];
    if (json['products'] != null) {
      products = <Product>[];
      json['products'].forEach((v) {
        products!.add(new Product.fromJson(v));
      });
    }
    nId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.storeId != null) {
      data['store_id'] = this.storeId!.sId;
    }
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    if (this.paymentType != null) {
      data['payment_type'] = paymentToStringView(this.paymentType!);
    }
    data['_id'] = this.nId;
    return data;
  }
  getTotalPrice() {
    double total = 0;
    products?.forEach((element) {
      total += element.price!*element.count!;
    });
    return total;
  }
}
