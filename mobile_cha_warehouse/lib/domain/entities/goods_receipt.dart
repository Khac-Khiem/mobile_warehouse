import 'package:equatable/equatable.dart';
import 'package:mobile_cha_warehouse/domain/entities/warehouse_employee.dart';
import 'package:mobile_cha_warehouse/domain/entities/item.dart';

class GoodsReceipt extends Equatable {
  String goodsReceiptId;
  DateTime timestamp;
  bool confirmed;
  bool causeStockChanges;
  WarehouseEmployee employee;
  List<GoodsReceiptEntry> entries;
  GoodsReceipt(
      this.goodsReceiptId, this.timestamp,this.confirmed, this.causeStockChanges, this.employee, this.entries);
  @override
  // TODO: implement props
  List<Object?> get props => [goodsReceiptId, timestamp, employee, entries];
}

class GoodsReceiptEntry extends Equatable {
  String containerId;
  double plannedQuantity;
  double actualQuantity;
  DateTime productionDate;
  Item item;
  GoodsReceiptEntry(this.containerId, this.plannedQuantity, this.actualQuantity,
      this.productionDate, this.item);
  @override
  // TODO: implement props
  List<Object?> get props =>
      [containerId, plannedQuantity, actualQuantity, productionDate, item];
}
