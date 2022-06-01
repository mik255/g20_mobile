


import 'package:g20newapp/modules/categorias/models/product.dart';
import 'package:g20newapp/modules/categorias/models/story.dart';


class ReceiptStories {
  Store? storeId;
  List<Product>? products;
  String? nId;

  ReceiptStories({this.storeId, this.products, this.nId});

  ReceiptStories.fromJson(Map<String, dynamic> json) {
    storeId = json['store_id'] != null
        ? new Store.fromJson(json['store_id'])
        : null;
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
    data['_id'] = this.nId;
    return data;
  }
}
