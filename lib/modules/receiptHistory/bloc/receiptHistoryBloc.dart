import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:g20newapp/MainStances.dart';
import 'package:g20newapp/core/http-client/http_client.dart';
import 'package:g20newapp/modules/receiptHistory/bloc/ReceiptHistoryEvent.dart';
import 'package:g20newapp/modules/receiptHistory/bloc/ReceiptHistoryState.dart';
import 'package:g20newapp/shared/user/bloc/bloc.dart';
import 'package:g20newapp/shared/widgets/receipt/model/receipt.dart';

import '../repository.dart';

class ReceiptHistoryBloc extends Bloc<ReceiptHistoryEvent, ReceiptHistoryState> {
  ReceiptHistoryBloc(ReceiptHistoryState initialState,this.user) : super(initialState);
  UserBloc user;
  @override
  Stream<ReceiptHistoryState> mapEventToState(ReceiptHistoryEvent event) async* {
    if(event is ReceiptHistoryLoadingEvent){
      yield ReceiptHistoryLoading();
    }
    if(event is ReceiptHistoryInitEvent){
      yield* getReceipts();
    }
  }


  Stream<ReceiptHistoryState> getReceipts() async* {
    yield ReceiptHistoryLoading();
    G20Response g20response = await Repository().getReceipts(user.user!.sId!);
     List<Receipt> receiptList = [];
    if (g20response is G20Sucess) {
      g20response.response.data['receipts'].forEach((v) {
        receiptList.add(new Receipt.fromJson(v));
      });

      yield ReceiptHistoryMainState(receiptList: receiptList);
    } else if (g20response is G20Exception) {
      throw g20response;
      //yield CategoryErrorState(message: g20response.message ?? 'Generic error');
    }
  }

}
