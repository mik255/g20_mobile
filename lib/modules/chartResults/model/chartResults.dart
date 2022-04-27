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
    totalPrice = json['total_price'];
    totalPriceSquare = json['total_price_square'];
    grossProfit = json['gross_profit'];
    profitMargin = json['profit_margin'];
    salesAmount = json['sales_amount'];
    averageTicket = json['average_ticket'];
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