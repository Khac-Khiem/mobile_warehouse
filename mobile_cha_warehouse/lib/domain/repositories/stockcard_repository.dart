import 'package:mobile_cha_warehouse/domain/entities/stock_card.dart';

abstract class StockCardRepo {
  Future<List<StockCard>> getStockCards(String id);
}
