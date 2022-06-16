import 'receiptStories.dart';
class Receipt {
  String? userId;
  String? date;
  String? categoryName;
  List<ReceiptStories>? receiptStories;
  double? totalPrice;
  double? totalPriceSquare;
  String? paymentType;

  Receipt(
      {this.userId,
        this.date,
        this.categoryName,
        this.receiptStories,
        this.totalPrice,
        this.totalPriceSquare,
        this.paymentType});

  Receipt.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    date = json['date'];
    categoryName = json['categoryName'];
    if (json['ReceiptStories'] != null) {
      receiptStories = <ReceiptStories>[];
      json['ReceiptStories'].forEach((v) {
        receiptStories!.add(new ReceiptStories.fromJson(v));
      });
    }
    totalPrice = double.parse(json['total_price'].toString());
    totalPriceSquare = double.parse(json['total_price_square'].toString());
    paymentType = json['payment_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['date'] = this.date;
    data['categoryName'] = this.categoryName;
    if (this.receiptStories != null) {
      data['ReceiptStories'] =
          this.receiptStories!.map((v) => v.toJson()).toList();
    }
    data['total_price'] = this.totalPrice;
    data['total_price_square'] = this.totalPriceSquare;
    data['payment_type'] = this.paymentType;
    return data;
  }
}