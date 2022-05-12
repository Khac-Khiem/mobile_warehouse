import 'package:mobile_cha_warehouse/datasource/models/container_model.dart';
import 'package:mobile_cha_warehouse/datasource/models/warehouse_product_model.dart';
import 'package:mobile_cha_warehouse/domain/entities/container.dart';
import 'package:mobile_cha_warehouse/domain/entities/item.dart';
import 'package:mobile_cha_warehouse/domain/entities/storage_slot.dart';

class SlotModel extends Slot {
  SlotModel(int id, ContainerModel container) : super(id, container);
}

class SliceLevelModel extends SliceLevel {
  SliceLevelModel(int id, List<SlotModel> slots) : super(id, slots);
}

class SliceModel extends Slice {
  SliceModel(int id, List<SliceLevelModel> levels, ItemModel product)
      : super(id, levels, product);
}

class CellModel extends Cell {
  CellModel(int row, int column, List<SliceModel> slices)
      : super(row, column, slices);
}

class RowModel extends Row {
  RowModel(int id, List<CellModel> cells) : super(id, cells);
}

class ShelfModel extends Shelf {
  ShelfModel(int id, List<RowModel> rows) : super(id, rows);
}

class LocationModel extends Location {
  LocationModel(
      String shelfId, int rowId, int cellId, int sliceId, int levelId, int id)
      : super(shelfId, rowId, cellId, sliceId, levelId, id);
  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      json["shelfId"],
      json["rowId"],
      json["cellId"],
      json["sliceId"],
      json["levelId"],
      json["id"],
    );
  }
}
