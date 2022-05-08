import 'package:mobile_cha_warehouse/domain/entities/storage_slot.dart';

abstract class SlotRepository {
  Future<Slot> getSlotStatus();
}
