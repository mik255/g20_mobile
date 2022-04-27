

import 'package:g20newapp/shared/widgets/receipt/model/receipt.dart';

class User {
  Indentify? indentify;
  String? sId;
  String? name;
  String? password;
  List<Receipt>? receipts;
  int? iV;

  User(
      {this.indentify,
      this.sId,
      this.name,
      this.password,
      this.receipts,
      this.iV});

  User.fromJson(Map<String, dynamic> json) {
    indentify = json['indentify'] != null
        ? new Indentify.fromJson(json['indentify'])
        : null;
    sId = json['_id'];
    name = json['name'];
    password = json['password'];
    if (json['receipts'] != null) {
      receipts = <Receipt>[];
      json['receipts'].forEach((v) {
        receipts!.add(new Receipt.fromJson(v));
      });
    }
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.indentify != null) {
      data['indentify'] = this.indentify!.toJson();
    }
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['password'] = this.password;
    if (this.receipts != null) {
      data['receipts'] = this.receipts!.map((v) => v.toJson()).toList();
    }
    data['__v'] = this.iV;
    return data;
  }
}

class Indentify {
  String? cpf;
  String? cnpj;

  Indentify({this.cpf, this.cnpj});

  Indentify.fromJson(Map<String, dynamic> json) {
    cpf = json['cpf'];
    cnpj = json['cnpj'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cpf'] = this.cpf;
    data['cnpj'] = this.cnpj;
    return data;
  }
}
