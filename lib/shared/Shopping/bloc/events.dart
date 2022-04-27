


import 'package:g20newapp/modules/categorias/models/category.dart';
import 'package:g20newapp/modules/categorias/models/product.dart';
import 'package:g20newapp/modules/home/models/order.model.dart';
import 'package:g20newapp/shared/widgets/receipt/model/receipt.dart';

class ShoppingEvent{}

class SetCategoryEvent extends ShoppingEvent{
  Category category;
  SetCategoryEvent({required this.category});
}
class AddProductEvent extends ShoppingEvent{
  Product product;
  AddProductEvent({required this.product});
}
class RemoveProductEvent extends ShoppingEvent{
  Product product;
  RemoveProductEvent({required this.product});
}
class SendReceiptEvent extends ShoppingEvent{
  Receipt receipt;
  SendReceiptEvent({required this.receipt});
}
class SendOrderEvent extends ShoppingEvent{
  Order order;
  SendOrderEvent({required this.order});
}
class ShoppingFinishBidEvent extends ShoppingEvent{}
class ShoppingInitialStateEvent extends ShoppingEvent{}