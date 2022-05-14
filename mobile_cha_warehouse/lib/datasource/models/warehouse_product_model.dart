import 'package:mobile_cha_warehouse/datasource/models/warehouse_employee_model.dart';
import 'package:mobile_cha_warehouse/domain/entities/item.dart';

class ItemModel extends Item {
  ItemModel(
      String id,
      String name,
      int piecesPerKilogram,
      int minimumStockLevel,
      int maximumStockLevel,
      int unit,
      int itemSource,
    // WarehouseEmployeeModel manager
    dynamic manager 
      )
      : super(id, name, piecesPerKilogram, minimumStockLevel, maximumStockLevel,
            unit, itemSource, manager);

  factory ItemModel.fromJson(Map<String, dynamic> json) {
    return ItemModel(
      json["itemId"],
      json["name"],
      json["piecesPerKilogram"],
      json["minimumStockLevel"],
      json["maximumStockLevel"],
      json["unit"],
      json["itemSource"],
      json["manager"] == null ? null : WarehouseEmployeeModel.fromJson(json["manager"]),
      //WarehouseEmployeeModel('', '', '', DateTime.now())
    );
  }
}
