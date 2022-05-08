import 'package:mobile_cha_warehouse/datasource/models/warehouse_employee_model.dart';
import 'package:mobile_cha_warehouse/domain/entities/item.dart';
import 'package:mobile_cha_warehouse/domain/entities/warehouse_employee.dart';

class ItemModel extends Item {
  ItemModel(
      String id,
      String name,
      double piecesPerKilogram,
      double minimumStockLevel,
      double maximumStockLevel,
      EUnit unit,
      EItemSource itemSource,
      WarehouseEmployeeModel manager)
      : super(id, name, piecesPerKilogram, minimumStockLevel, maximumStockLevel,
            unit, itemSource, manager);
}
