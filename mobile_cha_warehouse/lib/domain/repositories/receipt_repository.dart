import 'package:mobile_cha_warehouse/domain/entities/goods_receipt.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/blocs/issue_bloc.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/blocs/receipt_bloc.dart';

abstract class ReceiptsRepo {
  Future<List<GoodsReceipt>> getReceipts(String startDate);
  Future<GoodsReceipt> getReceiptById(String id);
  Future<void> addContainerReceipt(
      String receiptId, GoodsReceiptEntryContainerData goodsIssueData);
  Future<void> confirmReceipt(String receiptId);
}
