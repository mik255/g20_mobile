import 'package:g20newapp/MainStances.dart';
import 'package:g20newapp/core/http-client/http_client.dart';
import 'package:g20newapp/modules/login/models/credentials.dart';

class Repository {
  Future<G20Response> login(Credentials credentials) async {
    G20Http g20http = MainStances.g20http;
    try {
      var response =
          await g20http.requestHttp('/users/account/login', 'POST', data: {
        "indentify": {"cpf": credentials.cpfCnpj},
        "password": credentials.passWord
      });
      return response;
    } catch (e, _) {
      print(_);
      return G20Exception();
    }
  }
}
