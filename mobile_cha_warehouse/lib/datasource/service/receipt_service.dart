import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mobile_cha_warehouse/datasource/models/goods_receipts_model.dart';

class ReceiptService {
  Future<List<GoodsReceiptsModel>> getGoodsReceipt() async {
    final res = await http.get(Uri.parse(''));
    if (res.statusCode == 200) {
      List<GoodsReceiptsModel> body = jsonDecode(res.body);
      // List<GoodsIssueModel> stations = body
      //     .map(
      //       (dynamic item) => StationModel.fromJson(item),
      //     )
      //     .toList();

      return body;
    } else {
      throw "Unable to retrieve posts.";
    }
  }
}
