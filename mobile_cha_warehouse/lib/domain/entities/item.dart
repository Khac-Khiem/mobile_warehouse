import 'package:equatable/equatable.dart';
import 'package:mobile_cha_warehouse/domain/entities/warehouse_employee.dart';

enum EUnit { kilogram, pieces }
enum EItemSource { internal, external }

class Item extends Equatable {
  String id;
  String name;
  int piecesPerKilogram;
  int minimumStockLevel;
  int maximumStockLevel;
  int unit;
  int itemSource;
  // WarehouseEmployee manager;
  dynamic manager;
  Item(this.id, this.name, this.piecesPerKilogram, this.minimumStockLevel,
      this.maximumStockLevel, this.unit, this.itemSource, this.manager);

  @override
  // TODO: implement props
  List<Object?> get props => [id, name];
}
