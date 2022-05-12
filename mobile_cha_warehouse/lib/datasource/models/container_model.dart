import 'package:flutter/cupertino.dart';
import 'package:mobile_cha_warehouse/datasource/models/storage_slot_model.dart';
import 'package:mobile_cha_warehouse/datasource/models/warehouse_product_model.dart';
import 'package:mobile_cha_warehouse/domain/entities/container.dart';
import 'package:mobile_cha_warehouse/domain/entities/storage_slot.dart';
import 'package:mobile_cha_warehouse/domain/entities/item.dart';

class ContainerTypeModel extends ContainerType {
  ContainerTypeModel(String name, int weight) : super(name, weight);
  factory ContainerTypeModel.fromJson(Map<String, dynamic> json) {
    return ContainerTypeModel(
        json["name"],
        json["weight"],
    );
  }
}

class ContainerModel extends ContainerData {
  ContainerModel(
      String id,
      int plannedQuantity,
      int actualQuantity,
      String productionDate,
      bool isConsistent,
      ItemModel product,
     // SlotModel storageSlot,
     LocationModel storageSlot,
      ContainerType containerType)
      : super(id, plannedQuantity, actualQuantity, productionDate, isConsistent,
            product, storageSlot, containerType);
  factory ContainerModel.fromJson(Map<String, dynamic> json) {
    return ContainerModel(
      json["containerId"],
      json["plannedQuantity"],
      json["actualQuantity"],
      json["productionDate"],
      json["consistent"],
      json["item"] == null ? null! : ItemModel.fromJson(json["item"]),
      json["location"] == null ? null! : LocationModel.fromJson(json["location"]),
      json["containerType"] == null
          ? null!
          : ContainerTypeModel.fromJson(json["containerType"]),
    );
  }
}
