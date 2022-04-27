


import 'package:g20newapp/shared/widgets/receipt/model/receipt.dart';

class ReceiptHistoryState {}

class ReceiptHistoryMainState extends ReceiptHistoryState{
  List<Receipt> receiptList;

  ReceiptHistoryMainState({required this.receiptList});
}
class SetReciboDone extends ReceiptHistoryState {}

class ReceiptHistoryLoading extends ReceiptHistoryState {}

