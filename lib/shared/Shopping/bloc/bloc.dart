import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:g20newapp/core/http-client/http_client.dart';
import 'package:g20newapp/modules/categorias/models/category.dart';
import 'package:g20newapp/modules/categorias/models/product.dart';
import 'package:g20newapp/modules/home/models/order.model.dart';
import 'package:g20newapp/shared/Shopping/bloc/states.dart';
import 'package:g20newapp/shared/Shopping/data/repository.dart';
import 'package:g20newapp/shared/widgets/receipt/model/receipt.dart';

import 'events.dart';

class ShoppingBloc extends Bloc<ShoppingEvent, ShoppingState> {
  ShoppingBloc(ShoppingState initialState,) : super(initialState);
  Category category = Category(sId: '');
  double total = 0;
  double totalSquare = 0;
  String paymentType = '';

  @override
  Stream<ShoppingState> mapEventToState(ShoppingEvent event) async* {
    if (event is SetCategoryEvent) {
      if (category.sId != event.category.sId) {
        category = event.category;
      }
      yield ShoppingMainState(category: category, total: total);
    }
    if (event is ShoppingFinishBidEvent) {
      _clean();
      yield ShoppingFinishBidState(category,total);
    }
    if (event is SendReceiptEvent) {
     yield* sendReceipt(event.receipt);
    }
    if (event is SendOrderEvent) {
     yield* sendOrder(event.order);
    }
    if (event is ShoppingInitialStateEvent) {
      _clean();
      yield ShoppingMainState(category: category, total: total);
    }
    if (event is AddProductEvent) {
      yield* addProduct(event.product);
    }
    if (event is RemoveProductEvent) {
      yield* RemoveProduct(event.product);
    }
  }

  Stream<ShoppingState> sendReceipt(Receipt receipt) async* {
    yield ShoppingLoading();
    G20Response g20response = await Repository().sendReceipt(receipt);
    if (g20response is G20Sucess) {
      _clean();
      yield ShoppingFinishBidState(category, total);
    } else if(g20response is G20Exception) {
      yield ShoppingErrorState(message: g20response.message??'erro');
    }
  }

  Stream<ShoppingState> sendOrder(Order order) async* {
    yield ShoppingLoading();
    G20Response g20response = await Repository().sendOrder(order);
    if (g20response is G20Sucess) {
      _clean();
      yield ShoppingFinishBidState(category, total);
    } else if(g20response is G20Exception) {
      yield ShoppingErrorState(message: g20response.message??'erro');
    }
  }

  _clean() {
    total = 0;
    paymentType = '';
    totalSquare = 0;
    category = category..stores!.map((store) =>
    store..paymentMethod=null..products!.map((product) =>
    product..count=0).toList()).toList();
  }

  Stream<ShoppingState> addProduct(Product product) async* {
    int count = product.count!;
    count++;
    product.count = count;
    total += product.price!;
    totalSquare += product.priceSquare!;
    yield ShoppingMainState(category: category, total: total);
  }

  Stream<ShoppingState> RemoveProduct(Product product) async* {
    if (product.count! > 0) {
      int count = product.count!;
      count--;
      product.count = count;
      total -= product.price!;
      totalSquare -= product.priceSquare!;
    }
    yield ShoppingMainState(category: category, total: total);
  }
}
