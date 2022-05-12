import 'package:mobile_cha_warehouse/datasource/models/warehouse_employee_model.dart';
import 'package:mobile_cha_warehouse/datasource/models/warehouse_product_model.dart';
import 'package:mobile_cha_warehouse/domain/entities/goods_receipt.dart';
import 'package:mobile_cha_warehouse/domain/entities/item.dart';
import 'package:mobile_cha_warehouse/domain/entities/warehouse_employee.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/blocs/issue_bloc.dart';

class GoodsReceiptEntryContainerModel extends GoodsReceiptEntryContainer {
  GoodsReceiptEntryContainerModel(int planedQuantity, int actualQuantity,
      String productionDate, String containerId)
      : super(planedQuantity, actualQuantity, productionDate, containerId);
  factory GoodsReceiptEntryContainerModel.fromJson(Map<String, dynamic> json) {
    return GoodsReceiptEntryContainerModel(
      json["plannedQuantity"],
      json["actualQuantity"],
      json["productionDate"],
      json["containerId"],
    );
  }
}

class GoodsReceiptsEntryModel extends GoodsReceiptEntry {
  GoodsReceiptsEntryModel(int itemId, double plannedQuantity, ItemModel item, List<dynamic> containers, dynamic note) : super(itemId, plannedQuantity, item, containers, note);
 factory GoodsReceiptsEntryModel.fromJson(Map<String, dynamic> json) {
    return GoodsReceiptsEntryModel(
      json["itemId"],
      json["plannedQuantity"],
      json["item"] == null ? null as ItemModel : ItemModel.fromJson(json["item"]),
      json["containers"] ==null ? [] : (json["containers"] as List).map((e)=> GoodsReceiptEntryContainerModel.fromJson(e)).toList(),
      json["note"],
    );
  }
}

class GoodsReceiptsModel extends GoodsReceipt {
  GoodsReceiptsModel(String goodsReceiptId, String timestamp, bool confirmed,
      dynamic approver, List<GoodsReceiptsEntryModel> entries)
      : super(goodsReceiptId, timestamp, confirmed, approver, entries);
  factory GoodsReceiptsModel.fromJson(Map<String, dynamic> json) {
    return GoodsReceiptsModel(
      json["goodsReceiptId"],
      json["timestamp"],
      json["confirmed"],
      json["approver"]== null ? null : WarehouseEmployeeModel.fromJson(json["approver"]),
    
      json["entries"] == null
          ? []
          : (json["entries"] as List)
              .map((e) => GoodsReceiptsEntryModel.fromJson(e))
              .toList(),
    );
  }
}

class GoodsReceiptDataModel extends GoodsReceiptData {
  GoodsReceiptDataModel(int totalItem, List<GoodsReceiptsModel> items)
      : super(totalItem, items);
  factory GoodsReceiptDataModel.fromJson(Map<String, dynamic> json) {
    return GoodsReceiptDataModel(
      json["totalItems"],
      json["items"] == null
          ?[]
          : (json["items"] as List)
              .map((e) => GoodsReceiptsModel.fromJson(e))
              .toList(),
    );
  }
}
