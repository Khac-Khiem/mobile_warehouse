import 'package:mobile_cha_warehouse/datasource/models/storage_slot_model.dart';
import 'package:mobile_cha_warehouse/datasource/models/warehouse_employee_model.dart';
import 'package:mobile_cha_warehouse/datasource/models/warehouse_product_model.dart';
import 'package:mobile_cha_warehouse/domain/entities/good_issue.dart';
import 'package:mobile_cha_warehouse/domain/entities/item.dart';
import 'package:mobile_cha_warehouse/domain/entities/storage_slot.dart';
import 'package:mobile_cha_warehouse/domain/entities/warehouse_employee.dart';

class GoodsIssueEntryContainerModel extends GoodsIssueEntryContainer {
  GoodsIssueEntryContainerModel(double quantity, DateTime productionDate,
      String containerId, SlotModel storageSlot)
      : super(quantity, productionDate, containerId, storageSlot);
}

class GoodsIssueEntryModel extends GoodsIssueEntry {
  GoodsIssueEntryModel(
      double plannedQuantity,
      double actualQuantity,
      String note,
      ItemModel product,
      WarehouseEmployeeModel employee,
      List<GoodsIssueEntryContainerModel> container)
      : super(plannedQuantity, actualQuantity, note, product, employee,
            container);
}

class GoodsIssueModel extends GoodsIssue {
  GoodsIssueModel(String id, DateTime timestamp, bool isConfirmed,
      bool causeStockChanges, List<GoodsIssueEntryModel> entries)
      : super(id, timestamp, isConfirmed, causeStockChanges, entries);
}
