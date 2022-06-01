import 'package:g20newapp/modules/categorias/models/product.dart';
class Store {
  String? sId;
  String? pix;
  String? name;
  List<Product>? products;
  int? iV;

  Store({this.sId, this.pix, this.name, this.products, this.iV});

  Store.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    pix = json['pix'];
    name = json['name'];
    if (json['products'] != null) {
      products = <Product>[];
      json['products'].forEach((v) {

        products!.add(new Product.fromJson(v));
      });
    }
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['pix'] = this.pix;
    data['name'] = this.name;
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    data['__v'] = this.iV;
    return data;
  }
 double getTotal(){
    double total =0;
    products!.forEach((element) {
      total+=(element.price!*element.count!);
    });
    return total;
  }
}