import 'package:mobile_cha_warehouse/datasource/service/stockcard_service.dart';
import 'package:mobile_cha_warehouse/domain/entities/stock_card.dart';
import 'package:mobile_cha_warehouse/domain/repositories/stockcard_repository.dart';

class StockCardRepositoryImpl implements StockCardRepo {
  StockCardService stockCardService;
  StockCardRepositoryImpl(this.stockCardService);
  @override
  Future<List<StockCard>> getStockCards(String id) {
    // TODO: implement getStockCards
    throw UnimplementedError();
  }
}
