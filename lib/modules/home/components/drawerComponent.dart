




import 'package:flutter/material.dart';
import 'package:g20newapp/modules/chartResults/chartResult.provider.dart';
import 'package:g20newapp/modules/receiptHistory/receiptHistoryProvider.dart';

class DrawerComponent extends StatelessWidget {
  const DrawerComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text('Menu'),
          ),
          ListTile(
            title: const Text('Lucro com G20'),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      MeusRecibosProvider()));
            },
          ),
          ListTile(
            title: const Text('Meus Recibos'),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      ReceiptHistoryProvider()));
            },
          ),
        ],
      ),
    );
  }
}
