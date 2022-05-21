import 'package:mobile_cha_warehouse/datasource/models/warehouse_employee_model.dart';
import 'package:mobile_cha_warehouse/datasource/models/warehouse_product_model.dart';
import 'package:mobile_cha_warehouse/domain/entities/good_issue.dart';


class GoodsIssueEntryContainerModel extends GoodsIssueEntryContainer {
  GoodsIssueEntryContainerModel(int quantity, String productionDate,
      String containerId, bool isTaken)
      : super(quantity, productionDate, containerId, isTaken);
  factory GoodsIssueEntryContainerModel.fromJson(Map<String, dynamic> json) {
    return GoodsIssueEntryContainerModel(
      json["quantity"],
      json["productionDate"],
      json["containerId"],
      json["isTaken"],
    );
  }
}

class GoodsIssueEntryModel extends GoodsIssueEntry {
  GoodsIssueEntryModel(
      int totalQuantity,
      String? note,
      ItemModel item,
      WarehouseEmployeeModel employee,
      List<GoodsIssueEntryContainerModel> container
      //List<dynamic> container
      )
      : super(totalQuantity, note, item, employee, container);
  factory GoodsIssueEntryModel.fromJson(Map<String, dynamic> json) {
    return GoodsIssueEntryModel(
      json["totalQuantity"],
      json["note"],
      json["item"] == null ? null! : ItemModel.fromJson(json["item"]),
      json["employee"] == null
          ? null!
          : WarehouseEmployeeModel.fromJson(json["employee"]),
      json["containers"]==null ? null! : (json["containers"] as List).map((e)=> GoodsIssueEntryContainerModel.fromJson(e)).toList()
    );
  }
}

class GoodsIssueModel extends GoodsIssue {
  GoodsIssueModel(String id, String timestamp, bool isConfirmed,
      List<GoodsIssueEntryModel> entries)
      : super(id, timestamp, isConfirmed, entries);
  factory GoodsIssueModel.fromJson(Map<String, dynamic> json) {
    return GoodsIssueModel(
      json["goodsIssueId"],
      json["timestamp"],
      json["confirmed"],
      json["entries"] == null
          ? []
          : (json["entries"] as List)
              .map((e) => GoodsIssueEntryModel.fromJson(e))
              .toList(),
    );
  }
}

class GoodsIssueDataModel extends GoodsIssueData {
  GoodsIssueDataModel(List<GoodsIssue> items, int total) : super(items, total);
  factory GoodsIssueDataModel.fromJson(Map<String, dynamic> json) {
    return GoodsIssueDataModel(
      json["items"] == null
          ? []
          : (json["items"] as List)
              .map((e) => GoodsIssueModel.fromJson(e))
              .toList(),
      json["totalItems"],
    );
  }
}
