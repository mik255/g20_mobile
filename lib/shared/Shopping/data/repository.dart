import 'package:g20newapp/core/http-client/http_client.dart';
import 'package:g20newapp/modules/home/models/order.model.dart';
import 'package:g20newapp/shared/widgets/receipt/model/receipt.dart';
class Repository extends G20Http{

  String receiptRoute = '/users/account/receipts';
  String orderRoute = '/orders';

  Future<G20Response> sendReceipt(Receipt receipt) async{

    G20Response response = await super.requestHttp(receiptRoute, 'POST',
        data: {'receipt':receipt.toJson()});
    if(response is G20Sucess){
      return response;
    }else if(response is G20Exception){
      return G20Exception();
    }
    throw G20Exception();
  }

  Future<G20Response> sendOrder(Order order) async{
    G20Response response = await super.requestHttp(orderRoute, 'POST',
        data: {'order':order.toJson()});
    if(response is G20Sucess){
      return response;
    }else if(response is G20Exception){
      return G20Exception();
    }
    throw G20Exception();
  }
}