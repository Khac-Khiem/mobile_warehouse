import 'package:equatable/equatable.dart';
import 'package:mobile_cha_warehouse/domain/entities/storage_slot.dart';
import 'package:mobile_cha_warehouse/domain/entities/item.dart';

enum EContainerType { large, medium, small, packet }

class ContainerType {
  double weight;
  EContainerType id;
  ContainerType(this.id, this.weight);
}
// model du lieu cua mot ro
class ContainerData extends Equatable {
  String id;
  double plannedQuantity;
  double actualQuantity;
  DateTime productionDate;
  bool isConsistent;
  Item product;
  Slot storageSlot;
  ContainerType containerType;
  ContainerData(
      this.id,
      this.plannedQuantity,
      this.actualQuantity,
      this.productionDate,
      this.isConsistent,
      this.product,
      this.storageSlot,
      this.containerType);
  @override
  // TODO: implement props
  List<Object?> get props => [id, plannedQuantity, actualQuantity, productionDate, isConsistent, product, storageSlot,containerType];
}
