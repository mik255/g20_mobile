

import 'story.dart';

class Category {
  String? sId;
  String? name;
  List<Store>? stores;
  int? iV;

  Category({this.sId, this.name, this.stores, this.iV});
  Category copyWith({String? sId, String? name, List<Store>? stores, int? iV}){
    return Category(sId: sId,name: name,stores: stores,iV: iV);
  }
  Category.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    if (json['stores'] != null) {
      stores = <Store>[];
      json['stores'].forEach((v) {

        stores!.add(new Store.fromJson(v));
      });
    }
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    if (this.stores != null) {
      data['stores'] = this.stores!.map((v) => v.toJson()).toList();
    }
    data['__v'] = this.iV;
    return data;
  }
}