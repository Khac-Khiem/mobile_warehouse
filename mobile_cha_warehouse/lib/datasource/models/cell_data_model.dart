import 'package:equatable/equatable.dart';
import 'package:mobile_cha_warehouse/datasource/models/warehouse_product_model.dart';
import 'package:mobile_cha_warehouse/domain/entities/cell_data.dart';
import 'package:mobile_cha_warehouse/domain/entities/item.dart';

class CellDataModel extends CellData {
  String? shelfId;
  int? rowId;
  int? id;
  List<Slices>? slices;

  CellDataModel(this.shelfId, this.rowId, this.id, this.slices)
      : super(shelfId: shelfId, rowId: rowId, id: id, slices: slices);

  factory CellDataModel.fromJson(Map<String, dynamic> json) {
    return CellDataModel(
        json["shelfId"],
        json["rowId"],
        json["id"],
        json["slices"] == null
            ? null
            : (json["slices"] as List)
                .map((e) => SlicesModel.fromJson(e))
                .toList());
  }
}

class SlicesModel extends Slices {
  int? id;
  ItemModel? itemModel;
  List<SlotsModel>? slotsModel;

  SlicesModel(this.id, this.itemModel, this.slotsModel)
      : super(id: id, item: itemModel, slots: slotsModel);

  factory SlicesModel.fromJson(Map<String, dynamic> json) {
    return SlicesModel(
      json["id"],
      json["item"] == null ? null : ItemModel.fromJson(json["item"]),
      json["slots"] == null
          ? null
          : (json["slots"] as List).map((e) => SlotsModel.fromJson(e)).toList(),
    );
  }
}

class SlotsModel extends Slots {
  int? levelId;
  int? id;
  dynamic containerId;
  dynamic container;

  SlotsModel(this.levelId, this.id, this.containerId, this.container)
      : super(
            levelId: levelId,
            id: id,
            containerId: containerId,
            container: container);

  factory SlotsModel.fromJson(Map<String, dynamic> json) {
    return SlotsModel(
      json["levelId"],
      json["id"],
      json["containerId"],
      json["container"],
    );
  }
}
