import 'package:mobile_cha_warehouse/domain/entities/storage_slot.dart';
import 'package:mobile_cha_warehouse/domain/repositories/slot_repository.dart';

class SlotUseCase {
  SlotRepository _slotRepository;
  SlotUseCase(this._slotRepository);
  Future<Slot> getSlot() async {
    final slot = _slotRepository.getSlotStatus();
    return slot;
  }
}
