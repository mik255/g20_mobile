import 'package:g20newapp/modules/categorias/models/product.dart';
import 'package:g20newapp/modules/categorias/models/story.dart';

class HomeEvent{}
class SelectLojaEvent extends HomeEvent{
  Store store;
  SelectLojaEvent({required this.store});
}
class initialEvent extends HomeEvent{}
class HomeResetEvent extends HomeEvent{}
class HomeAddProductEvent extends HomeEvent{
  Store store;
  Product product;
  HomeAddProductEvent(this.product,this.store);
}
class HomeRemoveProductEvent extends HomeEvent{
  Store store;
  Product product;
  HomeRemoveProductEvent({required this.product,required this.store});
}
class ChangePage extends HomeEvent{
  int index =0;

  ChangePage(this.index);
}