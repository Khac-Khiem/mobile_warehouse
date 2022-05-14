import 'package:mobile_cha_warehouse/domain/entities/stock_card.dart';

class StockCardEntryModel extends StockCardEntry {
  StockCardEntryModel(
      String date,
      double beforeQuantity,
      double inputQUantity,
      double outputQuantity,
      double afterQuantity,
      String note)
      : super(date, beforeQuantity, inputQUantity, outputQuantity,
            afterQuantity, note);
  factory StockCardEntryModel.fromJson(Map<String, dynamic> json) {
    return StockCardEntryModel(
      json["date"],
      json["beforeQuantity"],
      json["inputQuantity"],
      json["outputQuantity"],
      json["afterQuantity"],
      json["note"],
    );
  }
}

class StockCardModel extends StockCard {
  StockCardModel(List<StockCardEntryModel> items) : super(items);
}
