



import 'package:g20newapp/modules/categorias/models/category.dart';

class ShoppingState{}
class ShoppingInitialState extends ShoppingState{}
class ShoppingMainState extends ShoppingState{
  Category category;
  double total;
  ShoppingMainState({required this.category,required this.total});
}
class ShoppingFinishBidState extends ShoppingMainState{
  ShoppingFinishBidState(Category category,
  double total) : super(category: category,total: total);
}
class ShoppingLoading extends ShoppingState{}
class ShoppingErrorState extends ShoppingState{
  String message;
  ShoppingErrorState({required this.message});
}