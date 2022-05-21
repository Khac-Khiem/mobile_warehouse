import 'package:equatable/equatable.dart';
import 'package:mobile_cha_warehouse/domain/entities/item.dart';
import 'package:mobile_cha_warehouse/domain/entities/storage_slot.dart';
import 'package:mobile_cha_warehouse/domain/entities/warehouse_employee.dart';

// model lưu trữ từng rổ của một dòng trong đơn xuất kho
class GoodsIssueEntryContainer extends Equatable {
  int quantity;
  String productionDate;
  String containerId;
  // Slot storageSlot;
  bool isTaken;
  GoodsIssueEntryContainer(
      this.quantity, this.productionDate, this.containerId, this.isTaken);
  @override
  // TODO: implement props
  List<Object?> get props =>
      [quantity, productionDate, containerId, isTaken];
}

// từng dòng của một đơn xuất kho
class GoodsIssueEntry extends Equatable {
  int totalQuantity;
  String? note;
  WarehouseEmployee employee;
  Item item;
  List<GoodsIssueEntryContainer> container;
  //List<dynamic> container;
  GoodsIssueEntry(
      this.totalQuantity, this.note, this.item, this.employee, this.container);
  @override
  // TODO: implement props
  List<Object?> get props => [totalQuantity, note, employee, item, container];
}

//Model của một đơn xuất kho
class GoodsIssue extends Equatable {
  String id;
  String timestamp;
  bool isConfirmed;
  List<GoodsIssueEntry> entries;
  GoodsIssue(this.id, this.timestamp, this.isConfirmed, this.entries);
  @override
  // TODO: implement props
  List<Object?> get props => [id, timestamp, isConfirmed, entries];
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
