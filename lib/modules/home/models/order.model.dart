import 'package:g20newapp/modules/categorias/models/product.dart';

class Order {
  String? user;
  List<Product>? products;

  Order({this.user, this.products});

  Order.fromJson(Map<String, dynamic> json) {
    user = json['user'];
    if (json['products'] != null) {
      products = <Product>[];
      json['products'].forEach((v) {
        products!.add(new Product.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user'] = this.user;
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}