import 'package:equatable/equatable.dart';
import 'package:mobile_cha_warehouse/domain/entities/container.dart';
import 'package:mobile_cha_warehouse/domain/entities/item.dart';

class Slot extends Equatable {
  int id;
  ContainerData container;
  Slot(this.id, this.container);
  @override
  // TODO: implement props
  List<Object?> get props => [id, container];
}

class SliceLevel extends Equatable {
  int id;
  List<Slot> slots;
  SliceLevel(this.id, this.slots);
  @override
  // TODO: implement props
  List<Object?> get props => [id, slots];
}

class Slice extends Equatable {
  int id;
  Item product;
  List<SliceLevel> levels;
  Slice(this.id, this.levels, this.product);
  @override
  // TODO: implement props
  List<Object?> get props => [id];
}

class Cell extends Equatable {
  int row;
  int column;
  List<Slice> slices;
  Cell(this.row, this.column, this.slices);
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class RowData extends Equatable {
  int id;
  List<Cell> cells;
  RowData(this.id, this.cells);
  @override
  // TODO: implement props
  List<Object?> get props => [id];
}

class Shelf extends Equatable {
  int id;
  List<RowData> rows;
  Shelf(this.id, this.rows);
  @override
  // TODO: implement props
  List<Object?> get props => [id];
}

class Location extends Equatable {
  String shelfId;
  int rowId;
  int cellId;
  int sliceId;
  int levelId;
  int id;
  Location(this.shelfId, this.rowId, this.cellId, this.sliceId, this.levelId,
      this.id);
  @override
  // TODO: implement props
  List<Object?> get props => [id];
}
