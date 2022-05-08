import 'package:mobile_cha_warehouse/datasource/models/warehouse_employee_model.dart';
import 'package:mobile_cha_warehouse/datasource/models/warehouse_product_model.dart';
import 'package:mobile_cha_warehouse/domain/entities/goods_receipt.dart';
import 'package:mobile_cha_warehouse/domain/entities/item.dart';
import 'package:mobile_cha_warehouse/domain/entities/warehouse_employee.dart';

class GoodsReceiptsEntryModel extends GoodsReceiptEntry {
  GoodsReceiptsEntryModel(String containerId, double plannedQuantity,
      double actualQuantity, DateTime productionDate, ItemModel item)
      : super(
            containerId, plannedQuantity, actualQuantity, productionDate, item);
}

class GoodsReceiptsModel extends GoodsReceipt {
  GoodsReceiptsModel(
      String goodsReceiptId,
      DateTime timestamp,
      bool confirmed,
      bool causeStockChanges,
      WarehouseEmployeeModel employee,
      List<GoodsReceiptsEntryModel> entries)
      : super(goodsReceiptId, timestamp, confirmed, causeStockChanges, employee,
            entries);
}
