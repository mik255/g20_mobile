



import 'package:flutter/material.dart';

class FilteredTabChartDateViewModel{
  String name;
  bool isSelected;
  FilteredTabChartDateViewModel(this.name, this.isSelected);
}
class FilteredTabChartDate extends StatefulWidget {
   FilteredTabChartDate({Key? key}) : super(key: key);

  @override
  State<FilteredTabChartDate> createState() => _FilteredTabChartDateState();
}

class _FilteredTabChartDateState extends State<FilteredTabChartDate> {
  List<FilteredTabChartDateViewModel> _list = [
    FilteredTabChartDateViewModel('Todos', true),
    FilteredTabChartDateViewModel('Este mês', false),
    FilteredTabChartDateViewModel('Esta semana', false),
    FilteredTabChartDateViewModel('Este ano', false),
    FilteredTabChartDateViewModel('Hoje', false),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 32,
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
          itemCount: _list.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: (){
                setState(() {
                  _list.forEach((element) {
                    element.isSelected = false;
                  });
                  _list[index].isSelected = true;
                });
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Container(
                  height: 32,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.white, width: 1, ),
                    color: !_list[index].isSelected?Colors.transparent:Colors.white,
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2, ),
                  child: Center(
                    child: Text(
                      _list[index].name,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: !_list[index].isSelected?Color(0xffffffff):Colors.blue,
                        fontSize: 14,
                        fontFamily: "Lato",
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
