import 'package:equatable/equatable.dart';
import 'package:mobile_cha_warehouse/domain/entities/warehouse_employee.dart';
import 'package:mobile_cha_warehouse/domain/entities/item.dart';

class GoodsReceiptEntryContainer extends Equatable {
  int planedQuantity;
  int actualQuantity;
  String productionDate;
  String containerId;
  // Slot storageSlot;

  GoodsReceiptEntryContainer(this.planedQuantity, this.actualQuantity,
      this.productionDate, this.containerId);
  @override
  // TODO: implement props
  List<Object?> get props => [planedQuantity, productionDate, containerId];
}

class GoodsReceiptEntry extends Equatable {
  int itemId;
  double plannedQuantity;
  Item item;
  List<dynamic> containers;
  dynamic note;
  GoodsReceiptEntry(
      this.itemId, this.plannedQuantity, this.item, this.containers, this.note);
  @override
  // TODO: implement props
  List<Object?> get props => [itemId, plannedQuantity, item, note];
}

class GoodsReceipt extends Equatable {
  String goodsReceiptId;
  String timestamp;
  bool confirmed;
  // WarehouseEmployee approver;
  dynamic approver;
  List<GoodsReceiptEntry> entries;
  GoodsReceipt(this.goodsReceiptId, this.timestamp, this.confirmed,
      this.approver, this.entries);
  @override
  // TODO: implement props
  List<Object?> get props => [goodsReceiptId, timestamp, entries];
}

class GoodsReceiptData extends Equatable {
  int totalItem;
  List<GoodsReceipt> items;
  GoodsReceiptData(this.totalItem, this.items);
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
