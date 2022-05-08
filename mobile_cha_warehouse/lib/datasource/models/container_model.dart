import 'package:mobile_cha_warehouse/datasource/models/storage_slot_model.dart';
import 'package:mobile_cha_warehouse/datasource/models/warehouse_product_model.dart';
import 'package:mobile_cha_warehouse/domain/entities/container.dart';
import 'package:mobile_cha_warehouse/domain/entities/storage_slot.dart';
import 'package:mobile_cha_warehouse/domain/entities/item.dart';

class ContainerTypeModel extends ContainerType {
  ContainerTypeModel(EContainerType id, double weight) : super(id, weight);
}

class ContainerModel extends ContainerData {
  ContainerModel(
      String id,
      double plannedQuantity,
      double actualQuantity,
      DateTime productionDate,
      bool isConsistent,
      ItemModel product,
      SlotModel storageSlot,
      ContainerType containerType)
      : super(id, plannedQuantity, actualQuantity, productionDate, isConsistent,
            product, storageSlot, containerType);
}
