import 'package:equatable/equatable.dart';
import 'package:mobile_cha_warehouse/domain/entities/item.dart';

class StockCardEntry extends Equatable {
  DateTime date;
  double beforeQuantity;
  double inputQUantity;
  double outputQuantity;
  double afterQuantity;
  Item item;
  StockCardEntry(this.date, this.beforeQuantity, this.inputQUantity,
      this.outputQuantity, this.afterQuantity, this.item);
  @override
  // TODO: implement props
  List<Object?> get props =>
      [date, beforeQuantity, inputQUantity, outputQuantity, item];
}

class StockCard extends Equatable {
  List<StockCardEntry> items;
  StockCard(this.items);
  @override
  // TODO: implement props
  List<Object?> get props => [items];
}
