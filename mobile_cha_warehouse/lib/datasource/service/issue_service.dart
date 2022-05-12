import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mobile_cha_warehouse/datasource/models/goods_issues_model.dart';

class IssueService {
  Future<List<GoodsIssueModel>> getGoodsIssue() async {
    final res = await http.get(Uri.parse(
        'https://cha-warehouse-management.azurewebsites.net/api/goodsissues/?Page=1&ItemsPerPage=10&StartTime=2021-03-01&EndTime=2023-05-30'));
    if (res.statusCode == 200) {
      dynamic body = jsonDecode(res.body);

      List<dynamic> bodyResponse = body['items'];
      //  print(bodyResponse.toString());
      List<GoodsIssueModel> allReceipts = bodyResponse
          .map(
            (dynamic item) => GoodsIssueModel.fromJson(item),
          )
          .toList();
      print(allReceipts.toString());
      return allReceipts;
    } else {
      throw "Unable to retrieve posts.";
    }
  }

  Future<GoodsIssueModel> getGoodsIssueById(String id) async {
    final res = await http.get(Uri.parse(
        'https://cha-warehouse-management.azurewebsites.net/api/goodsissues/$id'));
    //load vi tri https://cha-warehouse-management.azurewebsites.net/api/containers/a1
    final response = await http.get(Uri.parse('https://cha-warehouse-management.azurewebsites.net/api/containers/$id'));
    if (res.statusCode == 200) {
      dynamic body = jsonDecode(res.body);
      print(body.toString());
      GoodsIssueModel receipts = GoodsIssueModel.fromJson(body);

      return receipts;
    } else {
      throw "Unable to retrieve posts.";
    }
  }
}
