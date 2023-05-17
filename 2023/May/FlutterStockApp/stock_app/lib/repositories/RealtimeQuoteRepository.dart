import 'package:stock_app/models/RealtimeQuote.dart';
import 'package:web_socket_channel/io.dart';

class RealtimeQuoteRepository {
  static Stream<List<RealtimeQuote>> getRealtimeQuoteList(int page, int limit) {
    final channel = IOWebSocketChannel.connect(
      'wss://localhost:7036/api/Quote/ws?page=$page&limit=$limit',
    );

    return channel.stream.map((data) {
      final quotesData = List<dynamic>.from(data);
      return quotesData
          .map((quoteData) => RealtimeQuote(
        quoteId: quoteData['quoteId'],
        symbol: quoteData['Symbol'],
        companyName: quoteData['CompanyName'],
        indexName: quoteData['IndexName'],
        indexSymbol: quoteData['IndexSymbol'],
        marketCap: quoteData['MarketCap'],
        sectorEn: quoteData['SectorEn'],
        industryEn: quoteData['IndustryEn'],
        sector: quoteData['Sector'],
        industry: quoteData['Industry'],
        stockType: quoteData['StockType'],
        price: quoteData['Price'],
        change: quoteData['Change'],
        percentChange: quoteData['PercentChange'],
        volume: quoteData['Volume'],
        timeStamp: DateTime.parse(quoteData['TimeStamp']),
      ))
          .toList();
    });
  }
}
