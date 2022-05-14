import 'package:mobile_cha_warehouse/domain/entities/goods_receipt.dart';
import 'package:mobile_cha_warehouse/domain/repositories/receipt_repository.dart';

class ReceiptUseCase {
  final ReceiptsRepo _receiptsRepo;
  ReceiptUseCase(this._receiptsRepo);
  Future<List<GoodsReceipt>> getAllReceipts(String startDate) async {
    final goodsreceipts = await _receiptsRepo.getReceipts(startDate);
    return goodsreceipts;
  }
  Future<GoodsReceipt> getReceiptsById(String id) async {
    final goodsreceipts = await _receiptsRepo.getReceiptById(id);
    return goodsreceipts;
  }
}
