import 'package:bloc/bloc.dart';
import 'package:g20newapp/MainStances.dart';
import 'package:g20newapp/core/http-client/http_client.dart';
import 'package:g20newapp/modules/categorias/models/category.dart';
import 'package:g20newapp/modules/categorias/repository/repository.dart';
import 'CategoriaEvent.dart';
import 'categoriasState.dart';

class CategoriaBloc extends Bloc<CategoriaEvent, CategoriasState> {
  CategoriaBloc(CategoriasState initialState) : super(initialState);

  @override
  Stream<CategoriasState> mapEventToState(CategoriaEvent event) async* {
    if (event is CategoriaFetchData) {
      yield* getCategories();
    }
  }

  Stream<CategoriasState> getCategories() async* {
    yield CategoriaStateLoading();
    List<Category> categoryList = [];

    G20Response g20response = await Repository().getCategories();

    if (g20response is G20Sucess) {
      g20response.response.data.forEach((v) {
        categoryList.add(new Category.fromJson(v));

      });
      if(MainStances.settingsMainStances.settings==null){
        categoryList = categoryList.where((element) => element.name!='Pedidos').toList();
        yield CategoriasInitialState(categoryList: categoryList);
      }

      if(MainStances.settingsMainStances.settings!.period){
        categoryList = categoryList.where((element) => element.name=='Pedidos').toList();
      }else{
        categoryList = categoryList.where((element) => element.name!='Pedidos').toList();
      }
      yield CategoriasInitialState(categoryList: categoryList);
    } else if (g20response is G20Exception) {
      yield CategoryErrorState(message: g20response.message ?? 'Generic error');
    }
  }
}
