class QuoteRealtime {
  int quoteId;
  String symbol;
  String companyName;
  double? marketCap;
  String sector;
  String industry;
  String stockType;
  double price;
  double change;
  double percentChange;
  int volume;
  DateTime timeStamp;

  QuoteRealtime({
    required this.quoteId,
    required this.symbol,
    required this.companyName,
    this.marketCap,
    required this.sector,
    required this.industry,
    required this.stockType,
    required this.price,
    required this.change,
    required this.percentChange,
    required this.volume,
    required this.timeStamp,
  });

  factory QuoteRealtime.fromJson(Map<String, dynamic> json) {
    return QuoteRealtime(
      quoteId: json['quote_id'],
      symbol: json['symbol'],
      companyName: json['company_name'],
      marketCap: json['market_cap'],
      sector: json['sector'],
      industry: json['industry'],
      stockType: json['stock_type'],
      price: json['price'],
      change: json['change'],
      percentChange: json['percent_change'],
      volume: json['volume'],
      timeStamp: DateTime.parse(json['time_stamp']),
    );
  }
}
