


import 'package:g20newapp/modules/categorias/models/category.dart';

class CategoriasState{}

class CategoriaStateLoading extends CategoriasState{}
class CategoryErrorState extends CategoriasState{
String message;
  CategoryErrorState({required this.message});
}
class CategoriasInitialState extends CategoriasState{
  List<Category> categoryList;
  CategoriasInitialState({required this.categoryList});
}
