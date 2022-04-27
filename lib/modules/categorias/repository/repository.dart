import 'package:g20newapp/core/http-client/http_client.dart';
class Repository extends G20Http{

  String route = '/category';

  Future<G20Response> getCategories() async{
   G20Response response = await super.requestHttp(route, 'GET');
   if(response is G20Sucess){
     return response;
   }else if(response is G20Exception){
      return G20Exception();
   }
   throw G20Exception();
}
}