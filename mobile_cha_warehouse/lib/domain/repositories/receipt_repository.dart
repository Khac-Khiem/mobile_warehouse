import 'package:mobile_cha_warehouse/domain/entities/goods_receipt.dart';

abstract class ReceiptsRepo {
  Future<List<GoodsReceipt>> getReceipts();
  Future<GoodsReceipt> getReceiptById(String id);
}
