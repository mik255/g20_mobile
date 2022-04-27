import 'package:bloc/bloc.dart';
import 'package:g20newapp/modules/categorias/models/story.dart';
import 'package:g20newapp/modules/home/bloc/states.dart';
import 'package:g20newapp/shared/Shopping/bloc/bloc.dart';
import 'homeEvent.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc(
    HomeState initialState,this.shoppingBloc) : super(initialState){
    currentStore = shoppingBloc.category.stores![0];
  }
  ShoppingBloc shoppingBloc;
  late Store currentStore;

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (event is SelectLojaEvent) {
      yield* selectLoja(event.store);
    }
  }

  Stream<HomeState> selectLoja(Store store) async* {
    currentStore = store;
    yield HomeMainState();
  }


  // Stream<HomeState> resetData() async* {
  //   total = 0;
  //   category.stores!.forEach((element) {
  //     element.products!.forEach((element) {
  //       element.count = 0;
  //     });
  //   });
  //
  //   yield HomeMainState(category: category, currentStore: category.stores![0]);
  // }

  // Stream<HomeState> addProduto(Product product, Store store) async* {
  //   receiptBloc.add(CompraEventAddItem(product: product));
  //   yield HomeMainState(category: category, currentStore: store);
  // }
  //
  // Stream<HomeState> removeProductEvent(Product product, Store store) async* {
  //   receiptBloc.add(CompraEventRemoveItem(product: product));
  //   yield HomeMainState(category: category, currentStore: store);
  // }
}
