// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:g20newapp/modules/home/bloc/homeBloc.dart';
// import 'package:g20newapp/modules/receiptHistory/receiptHistoryProvider.dart';
// import 'package:g20newapp/shared/receiptHistory/bloc/compraBloc.dart';
// import 'package:g20newapp/shared/util/SharedFunctions.dart';
// import 'package:g20newapp/shared/widgets/modalSheet.dart';
//
// class PagamentoProvider extends StatelessWidget {
//   PagamentoProvider({Key key,this.homeBloc}) : super(key: key);
//   HomeBloc homeBloc;
//   List<Map<String,dynamic>> pagamentos = [
//     {'nome':'Pix' ,'img':'https://psfonttk.com/wp-content/uploads/2021/08/logo-pix-png.png'},
//     {'nome':'Dinheiro' ,'img':'https://d168rbuicf8uyi.cloudfront.net/wp-content/uploads/2019/12/17155939/dinheiro-1024x682.jpg'},
//     {'nome':'Cartão' ,'img':'https://www.remessaonline.com.br/blog/wp-content/uploads/2022/01/shutterstock_1677488197-scaled.jpg.optimal.jpg'},
//     {'nome':'Lojista' ,'img':'https://www.megalojista.com.br/media/wysiwyg/New-Banners-Mega-Lojista---Porto-Theme-1.jpg'},
//   ];
//   @override
//   Widget build(BuildContext context) {
//     double total =  BlocProvider.of<CompraBloc>(context).receiptHistory.total;
//     return Scaffold(
//       appBar: AppBar(
//         shadowColor: Colors.transparent,
//         centerTitle: true,
//         title: Text("Método de pagamento"),
//       ),
//       backgroundColor: Colors.blue,
//       body: SingleChildScrollView(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.end,
//           children: [
//             Container(
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(25),
//                   topRight: Radius.circular(25),
//                 ),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(0.1),
//                     spreadRadius: 5,
//                     blurRadius: 7,
//                     offset: Offset(0, 2),
//                   )
//                 ],
//                 color: Colors.white,
//               ),
//               height: MediaQuery.of(context).size.height*0.8,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   Container(height: 80,),
//                   Expanded(
//                     child: CustomScrollView(
//                       primary: false,
//                       slivers: <Widget>[
//                         SliverPadding(
//                           padding: const EdgeInsets.all(8),
//                           sliver: SliverGrid.count(
//                               crossAxisSpacing: 10,
//                               mainAxisSpacing: 10,
//                               crossAxisCount: 2,
//                               children: List.generate(pagamentos.length, (index) {
//                                 return Stack(
//                                   children: [
//                                     InkWell(
//                                       onTap: (){
//                                         BlocProvider.of<CompraBloc>(context).receiptHistory.pagamento = pagamentos[index]['nome'];
//                                        Navigator.of(context)
//                                        .push(MaterialPageRoute(builder: (context)=>
//                                            ReciboProvider(homeBloc: homeBloc,)));
//                                       },
//                                       child: Container(
//                                         height: 180,
//                                         clipBehavior: Clip.hardEdge,
//                                         decoration: BoxDecoration(
//                                             borderRadius: BorderRadius.all(Radius.circular(25)),
//                                             boxShadow: [
//                                               BoxShadow(
//                                                 color: Colors.black.withOpacity(0.08),
//                                                 spreadRadius: 5,
//                                                 blurRadius: 7,
//                                                 offset: Offset(0, 2),
//                                               )
//                                             ],
//                                             color: Colors.white),
//                                         child: Stack(
//                                           children: [
//                                             Container(
//                                               height: 180,
//                                               child: Image.network(
//                                                 pagamentos[index]['img'],
//                                                 fit: BoxFit.cover,
//                                               ),
//                                             ),
//                                             Align(
//                                               alignment: Alignment.bottomCenter,
//                                               child: Row(
//                                                 children: [
//                                                   Expanded(
//                                                     child: Container(
//                                                       height: 50,
//                                                       color: Colors.black45,
//                                                       child: Center(
//                                                           child: Text(
//                                                             pagamentos[index]['nome'],
//                                                             style: TextStyle(color: Colors.white, fontSize: 18),
//                                                           )),
//                                                     ),
//                                                   ),
//                                                 ],
//                                               ),
//                                             ),
//
//                                           ],
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 );
//                               })),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             ModalSheet(
//                 value: FormatMoney(total),
//                 onTap: () {})
//           ],
//         ),
//       ),
//     );
//   }
// }
