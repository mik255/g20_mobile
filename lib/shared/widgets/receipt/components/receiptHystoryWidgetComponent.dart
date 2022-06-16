import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:g20newapp/shared/theme/logo.dart';
import 'package:g20newapp/shared/user/bloc/bloc.dart';
import 'package:g20newapp/shared/user/model/user.dart';
import 'package:g20newapp/shared/util/SharedFunctions.dart';
import 'package:g20newapp/shared/util/dateUtil.dart';
import 'package:g20newapp/shared/util/screamShot.dart';
import 'package:g20newapp/shared/widgets/receipt/model/receipt.dart';
import 'package:g20newapp/shared/widgets/showModel.dart';
import 'package:screenshot/screenshot.dart';

import 'popupMenu.dart';

Widget receiptHystoryWidgetComponent(
  BuildContext context,
  Receipt receipt,
  GlobalKey<ScaffoldState> scaffoldState,
  ScreenshotController screenshotController,
  bool isBuy,
  Future<void> Function(Receipt receipt)? callback,
) {
  WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    if (!isBuy) {
      showModelSheet(
          context, receipt.totalPrice!, scaffoldState, 'Compartilhar',
          close: false, onTap: () async {
        try {
          await takeScreenshotandShare(screenshotController);
        } catch (e, _) {
          print(e);
          print(_);
        }
        return '';
      });
    } else {
      showModelSheet(context, receipt.totalPrice!, scaffoldState, 'Finalizar',
          close: false, onTap: () async {
        try {
          await callback?.call(receipt);
        } catch (e, _) {
          print(e);
          print(_);
        }
        return '';
      });
    }
  });
  User? user = BlocProvider.of<UserBloc>(context).user;
  double width = MediaQuery.of(context).size.width;
  double height = MediaQuery.of(context).size.height;
  return SafeArea(
    child: Scaffold(
      key: scaffoldState,
      body: Container(
        child: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Column(
            children: [
              Container(
                  height: height,
                  color: Colors.blue,
                  child: Swiper(
                    loop: false,
                    pagination: new SwiperPagination(
                      alignment: Alignment.bottomLeft,
                      builder: new FractionPaginationBuilder(
                          color: Colors.grey, activeColor: Color(0xff226edc)),
                    ),
                    control: new SwiperControl(
                      color: Colors.transparent,
                    ),
                    itemCount: receipt.receiptStories == null
                        ? 0
                        : receipt.receiptStories?.length,
                    itemBuilder: (context, i) => Container(
                      height: height,
                      width: width,
                      decoration: BoxDecoration(color: Colors.white),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Container(
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                Container(
                                  height: height * 0.03,
                                  width: width * 0.3,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(18),
                                        bottomRight: Radius.circular(18),
                                      ),
                                      color: Colors.black45),
                                  child: Center(
                                      child: Text(
                                    'Recibo',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  )),
                                ),
                                Container(
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                          radius: 35,
                                          backgroundColor: Colors.black54,
                                          child: logo()),
                                      SizedBox(
                                        width: 24,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            user!.name!,
                                            style: TextStyle(
                                                color: Colors.black54,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 18),
                                          ),
                                          Text(
                                              '${UtilBrasilFields.obterCnpj(user.indentify?.cnpj ?? '')}'),
                                          Text(
                                              '${AppDateUtil.dateToString(DateTime.parse(receipt.date!))}'),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Divider(),
                                Text(
                                  '${receipt.receiptStories![i].storeId!.name}',
                                  style: TextStyle(
                                      color: Colors.black54,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18),
                                ),
                                SizedBox(
                                  height: 16,
                                ),
                                ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: receipt
                                        .receiptStories![i].products!.length,
                                    itemBuilder: (context, index) {
                                      var item = receipt
                                          .receiptStories![i].products![index];
                                      return Column(
                                        children: [
                                          item.count != 0
                                              ? Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(0)),
                                                    color: index % 2 == 0
                                                        ? Color(0xffE0E0E0)
                                                        : Colors.white,
                                                  ),
                                                  height: 50,
                                                  child: Row(
                                                    children: [
                                                      FittedBox(
                                                        child: Text(
                                                          '${item.count}x ${item.name}',
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .black54,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontSize: 18),
                                                        ),
                                                      ),
                                                      Spacer(),
                                                      Text(
                                                        FormatMoney(
                                                            item.price!),
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black54,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontSize: 18),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              : Container(),
                                          item.count != 0
                                              ? Container(
                                                  height: 8,
                                                )
                                              : Container(),
                                          if (index ==
                                              receipt.receiptStories![i]
                                                      .products!.length -
                                                  1)
                                            Container(
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(0)),
                                                color: Colors.black54,
                                              ),
                                              height: 50,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 8.0),
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      'Total ',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 18),
                                                    ),
                                                    Spacer(),
                                                    Text(
                                                      FormatMoney(
                                                          receipt.receiptStories![i].getTotalPrice()),
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 18),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          if (index ==
                                              receipt.receiptStories![i]
                                                      .products!.length -
                                                  1)
                                            Container(
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(0)),
                                                color: Colors.black45,
                                              ),
                                              height: 50,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 8.0),
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      'Pagamento',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 18),
                                                    ),
                                                    Spacer(),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          '${receipt.receiptStories![i].paymentType} / Lojista',
                                                          style: TextStyle(
                                                              color: Colors.white,
                                                              fontWeight:
                                                                  FontWeight.w400,
                                                              fontSize: 18),
                                                        ),
                                                        // ReceiptChangePaymentent(callback: (value){
                                                        //    receipt.receiptStories![i].paymentType = value;
                                                        // },),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                        ],
                                      );
                                    }),
                                SizedBox(
                                  height: 16,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.1),
                                          spreadRadius: 5,
                                          blurRadius: 7,
                                          offset: Offset(0, 2),
                                        )
                                      ],
                                      color: Colors.white),
                                  child: Center(
                                      child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text('observação'))),
                                ),
                                SizedBox(
                                  height: 16,
                                ),
                                Text(
                                  AppDateUtil.dateToString(
                                      DateTime.parse(receipt.date!)),
                                  style: TextStyle(
                                      color: Colors.black54,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 18),
                                ),
                                SizedBox(
                                  height: 150,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  )),
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: Icon(Icons.share),
                  onPressed: () async {
                    await takeScreenshotandShare(screenshotController);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
