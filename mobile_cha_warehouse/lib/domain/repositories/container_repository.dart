import 'package:mobile_cha_warehouse/domain/entities/container.dart';
import 'package:mobile_cha_warehouse/domain/entities/item.dart';

abstract class ContainRepo {
  Future<ContainerData> getContainerById(String containerId);
  Future<ContainerData> updateContain(int plannedQuantity,
      DateTime productionDate, Item product, int actualQuantity);
  Future<ContainerData> updateActualQuantity(int actualQuantity);
  Future<ContainerData> updateShelfUnit(String shelfUnitId);
  Future<void> clear();
}

// abstract class UpdateActualQuantityRepo {
//   Future<Container> updateActualQuantity(int actualQuantity);
// }

// abstract class UpdateShelfUnitRepo {
//   Future<Container> updateShelfUnit(String shelfUnitId);
// }

// abstract class ClearContainRepo {
//   Future<void> clear();
// }
