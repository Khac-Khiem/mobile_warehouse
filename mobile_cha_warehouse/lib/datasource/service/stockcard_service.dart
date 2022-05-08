import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mobile_cha_warehouse/datasource/models/stockcard_model.dart';
import 'package:mobile_cha_warehouse/datasource/models/token_model.dart';

class StockCardService {
  Future<List<StockCardModel>> getGoodsIssue() async {
    final res = await http.get(Uri.parse(''));
    if (res.statusCode == 200) {
    List<StockCardModel> body = jsonDecode(res.body);
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
