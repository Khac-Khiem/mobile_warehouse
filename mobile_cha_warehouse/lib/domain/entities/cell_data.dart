import 'package:equatable/equatable.dart';
import 'package:mobile_cha_warehouse/domain/entities/container.dart';
import 'package:mobile_cha_warehouse/domain/entities/item.dart';

class CellData extends Equatable {
  String? shelfId;
  int? rowId;
  int? id;
  List<Slices>? slices;

  CellData({this.shelfId, this.rowId, this.id, this.slices});

  @override
  // TODO: implement props
  List<Object?> get props => [shelfId, rowId, id, slices];
}

class Slices extends Equatable {
  int? id;
  Item? item;
  List<Slots>? slots;

  Slices({this.id, this.item, this.slots});

  @override
  // TODO: implement props
  List<Object?> get props => [id, item, slots];
}

class Slots extends Equatable {
  int? levelId;
  int? id;
  dynamic containerId;
  dynamic container;

  Slots({this.levelId, this.id, this.containerId, this.container});

  @override
  // TODO: implement props
  List<Object?> get props => [levelId, id, containerId, container];
}
