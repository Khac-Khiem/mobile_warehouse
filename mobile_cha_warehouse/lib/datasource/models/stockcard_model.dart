import 'package:mobile_cha_warehouse/datasource/models/warehouse_product_model.dart';
import 'package:mobile_cha_warehouse/domain/entities/item.dart';
import 'package:mobile_cha_warehouse/domain/entities/stock_card.dart';

class StockCardEntryModel extends StockCardEntry {
  StockCardEntryModel(
      DateTime date,
      double beforeQuantity,
      double inputQUantity,
      double outputQuantity,
      double afterQuantity,
      ItemModel item)
      : super(date, beforeQuantity, inputQUantity, outputQuantity,
            afterQuantity, item);
}

class StockCardModel extends StockCard {
  StockCardModel(List<StockCardEntryModel> items) : super(items);
}
