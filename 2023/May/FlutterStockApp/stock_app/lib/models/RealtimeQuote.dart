class RealtimeQuote {
  int quoteId;
  String? symbol;
  String? companyName;
  String? indexName;
  String? indexSymbol;
  double marketCap;
  String? sectorEn;
  String? industryEn;
  String? sector;
  String? industry;
  String? stockType;
  double price;
  double change;
  double percentChange;
  int volume;
  DateTime timeStamp;

  RealtimeQuote({
    required this.quoteId,
    this.symbol,
    this.companyName,
    this.indexName,
    this.indexSymbol,
    required this.marketCap,
    this.sectorEn,
    this.industryEn,
    this.sector,
    this.industry,
    this.stockType,
    required this.price,
    required this.change,
    required this.percentChange,
    required this.volume,
    required this.timeStamp,
  });
}
