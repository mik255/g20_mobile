import 'package:flutter_masked_text/flutter_masked_text.dart';

String FormatMoney(double price) {
  final lowPrice = MoneyMaskedTextController(
    leftSymbol: 'R\$ ',
    decimalSeparator: ',',
    thousandSeparator: '.',
  ); //after
  lowPrice.updateValue(price);
  return lowPrice.text;
}
