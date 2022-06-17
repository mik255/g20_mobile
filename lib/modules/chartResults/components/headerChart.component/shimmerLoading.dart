


import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerLoading extends StatelessWidget {
   ShimmerLoading({Key? key}) : super(key: key);
  List<String> _list = ['Todos', 'Este Mês', 'Esta Semana', 'Dia'];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(backgroundColor: Color(0xff393D42),centerTitle: true,title: Text('Lucro Com G20'),),
        body: Container(
          child: Stack(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height * 0.40,
                width: MediaQuery.of(context).size.width,
                color: Colors.grey[200],
                child:  Center(
                  child: Container(
                    color: Colors.grey[200],
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: CircleAvatar(
                            radius: 80,
                            backgroundColor: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
             Align(
               alignment: Alignment.topCenter,
               child: Shimmer.fromColors(
                 baseColor: Colors.grey[300]!,
                 highlightColor: Colors.grey[100]!,
                 child: Padding(
                   padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 8),
                   child: Container(
                     height: 30,
                     child: ListView.builder(
                         itemCount: _list.length,
                         scrollDirection: Axis.horizontal,
                         itemBuilder: (context, index) {
                           return Padding(
                             padding: const EdgeInsets.symmetric(horizontal: 8.0),
                             child: Container(
                               height: 32,
                               decoration: BoxDecoration(
                                 borderRadius: BorderRadius.circular(12),
                                 border: Border.all(color: Colors.white, width: 1, ),
                                 color: Colors.grey[200],
                               ),
                               padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2, ),
                               child: Center(
                                 child: Text(
                                   _list[index],
                                   textAlign: TextAlign.center,
                                   style: TextStyle(
                                     color: Color(0xffffffff),
                                     fontSize: 14,
                                     fontFamily: "Lato",
                                     fontWeight: FontWeight.w700,
                                   ),
                                 ),
                               ),
                             ),
                           );
                         }),
                   ),
                 ),
               ),
             ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                    ]),
                height: MediaQuery.of(context).size.height*0.50,
              ),
            ),
          ),
        )
            ],
          ),
        ),
      ),
    );
  }
}
