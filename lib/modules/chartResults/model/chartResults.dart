class ChartResults {
  double? totalPrice;
  double? totalPriceSquare;
  double? grossProfit;
  double? profitMargin;
  int? salesAmount;
  double? averageTicket;

  ChartResults(
      {this.totalPrice,
        this.totalPriceSquare,
        this.grossProfit,
        this.profitMargin,
        this.salesAmount,
        this.averageTicket});

  ChartResults.fromJson(Map<String, dynamic> json) {
    totalPrice = double.parse(json['total_price'].toString());
    totalPriceSquare = double.parse(json['total_price_square'].toString());
    grossProfit = double.parse(json['gross_profit'].toString());
    profitMargin = double.parse(json['profit_margin'].toString());
    salesAmount = json['sales_amount'];
    averageTicket = double.parse(json['average_ticket'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_price'] = this.totalPrice;
    data['total_price_square'] = this.totalPriceSquare;
    data['gross_profit'] = this.grossProfit;
    data['profit_margin'] = this.profitMargin;
    data['sales_amount'] = this.salesAmount;
    data['average_ticket'] = this.averageTicket;
    return data;
  }
}