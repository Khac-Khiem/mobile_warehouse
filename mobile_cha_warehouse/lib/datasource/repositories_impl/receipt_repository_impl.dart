import 'package:mobile_cha_warehouse/datasource/service/receipt_service.dart';
import 'package:mobile_cha_warehouse/domain/entities/goods_receipt.dart';
import 'package:mobile_cha_warehouse/domain/repositories/receipt_repository.dart';

class ReceiptRepositoryImpl implements ReceiptsRepo {
  ReceiptService receiptService;
  ReceiptRepositoryImpl(this.receiptService);
  @override
  Future<List<GoodsReceipt>> getReceipts() {
    final receipt = receiptService.getGoodsReceipt();
    return receipt;
  }

  @override
  Future<GoodsReceipt> getReceiptById(String id) {
    // TODO: implement getReceiptById
    throw UnimplementedError();
  }
}
