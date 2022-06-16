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

}
