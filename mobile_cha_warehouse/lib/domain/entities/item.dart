import 'package:equatable/equatable.dart';
import 'package:mobile_cha_warehouse/domain/entities/warehouse_employee.dart';

enum EUnit { kilogram, pieces }
enum EItemSource { internal, external }

class Item extends Equatable {
  String id;
  String name;
  double piecesPerKilogram;
  double minimumStockLevel;
  double maximumStockLevel;
  EUnit unit;
  EItemSource itemSource;
  WarehouseEmployee manager;
  Item(this.id, this.name, this.piecesPerKilogram, this.minimumStockLevel, this.maximumStockLevel,this.unit,this.itemSource, this.manager);

  @override
  // TODO: implement props
  List<Object?> get props => [id, name];
}
