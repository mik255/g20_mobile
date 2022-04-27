import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:g20newapp/modules/categorias/bloc/categoriasBloc.dart';
import 'package:g20newapp/modules/categorias/pages/categoriasPage.dart';

import 'bloc/CategoriaEvent.dart';
import 'bloc/categoriasState.dart';


class CategoryProvider extends StatefulWidget {
  const CategoryProvider({Key? key}) : super(key: key);

  @override
  _CategoryProviderState createState() => _CategoryProviderState();
}

class _CategoryProviderState extends State<CategoryProvider> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(

        providers: [
          BlocProvider<CategoriaBloc>(create: (BuildContext context) =>
              CategoriaBloc(CategoriaStateLoading())..add(CategoriaFetchData())),
        ],
        child: CategoriaPage());
  }
}
