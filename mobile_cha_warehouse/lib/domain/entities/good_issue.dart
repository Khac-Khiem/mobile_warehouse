import 'package:equatable/equatable.dart';
import 'package:mobile_cha_warehouse/domain/entities/item.dart';
import 'package:mobile_cha_warehouse/domain/entities/storage_slot.dart';
import 'package:mobile_cha_warehouse/domain/entities/warehouse_employee.dart';

// model lưu trữ từng rổ của một dòng trong đơn xuất kho
class GoodsIssueEntryContainer extends Equatable {
  double quantity;
  DateTime productionDate;
  String containerId;
  Slot storageSlot;
  GoodsIssueEntryContainer(
      this.quantity, this.productionDate, this.containerId, this.storageSlot);
  @override
  // TODO: implement props
  List<Object?> get props =>
      [quantity, productionDate, containerId, storageSlot];
}

// từng dòng của một đơn xuất kho
class GoodsIssueEntry extends Equatable {
  double plannedQuantity;
  double actualQuantity;
  String note;
  WarehouseEmployee employee;
  Item product;
  List<GoodsIssueEntryContainer> container;
  GoodsIssueEntry(this.plannedQuantity, this.actualQuantity, this.note,
      this.product, this.employee, this.container);
  @override
  // TODO: implement props
  List<Object?> get props =>
      [plannedQuantity, actualQuantity, note, employee, product, container];
}

//Model của một đơn xuất kho
class GoodsIssue extends Equatable {
  String id;
  DateTime timestamp;
  bool isConfirmed;
  bool causeStockChanges;
  List<GoodsIssueEntry> entries;
  GoodsIssue(this.id, this.timestamp, this.isConfirmed, this.causeStockChanges,
      this.entries);
  @override
  // TODO: implement props
  List<Object?> get props => [id, timestamp, isConfirmed, causeStockChanges, entries];
}

////////
class GoodsIssueData extends Equatable {
  List<GoodsIssue> items;
  int total;
  GoodsIssueData(this.items, this.total);
  @override
  // TODO: implement props
  List<Object?> get props => [items, total];
}
