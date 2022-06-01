import 'dart:convert';

import 'package:dio/dio.dart';

class G20Response {}

class G20Exception extends G20Response implements Exception {
  G20Exception({this.message});

  String? message;
}

class G20Sucess extends G20Response {
  G20Sucess({required this.response});

  Response<dynamic> response;
}

class G20Http {
  Dio dio = Dio();
  String baseEndpoint = 'https://g20-api-rest.herokuapp.com';

  Future<G20Response> requestHttp(String route, String method,
      {Map<String, dynamic>? data}) async {
    try {

      RequestOptions options = RequestOptions(
          method: method,
          path: baseEndpoint + route,
          data: data);

      print(baseEndpoint + route);
      print('body:'+'$data');
      var response = await dio.fetch(options);
      return G20Sucess(response: response);
    } catch (e, _) {
      print(e);
      return G20Exception();
    }
  }
}
