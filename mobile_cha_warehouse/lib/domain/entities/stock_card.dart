import 'package:equatable/equatable.dart';

class StockCardEntry extends Equatable {
  String date;
  double beforeQuantity;
  double inputQUantity;
  double outputQuantity;
  double afterQuantity;
  //Item item;
  String note;
  StockCardEntry(this.date, this.beforeQuantity, this.inputQUantity,
      this.outputQuantity, this.afterQuantity, this.note);
  @override
  // TODO: implement props
  List<Object?> get props =>
      [date, beforeQuantity, inputQUantity, outputQuantity,];
}

class StockCard extends Equatable {
  List<StockCardEntry> items;
  StockCard(this.items);
  @override
  // TODO: implement props
  List<Object?> get props => [items];
}
