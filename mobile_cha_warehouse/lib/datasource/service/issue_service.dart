import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mobile_cha_warehouse/datasource/models/goods_issues_model.dart';
import 'package:mobile_cha_warehouse/datasource/service/receipt_service.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/blocs/issue_bloc.dart';
import 'package:mobile_cha_warehouse/presentation/screens/issue/list_container_screen.dart';
import 'package:mobile_cha_warehouse/presentation/screens/issue/list_issue_screen.dart';

class IssueService {
  Future<List<GoodsIssueModel>> getGoodsIssue(String startDate) async {
    final res = await http.get(Uri.parse(
        'https://cha-warehouse-management.azurewebsites.net/api/goodsissues/?Page=1&ItemsPerPage=10&StartTime=$startDate&EndTime=2023-05-30'),
         headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': '*/*',
        });
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
        'https://cha-warehouse-management.azurewebsites.net/api/goodsissues/$id'),
         headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': '*/*',
        });
    if (res.statusCode == 200) {
      dynamic body = jsonDecode(res.body);
      print(body.toString());
      GoodsIssueModel issue = GoodsIssueModel.fromJson(body);

      return issue;
    } else {
      throw "Unable to retrieve posts.";
    }
  }

  Future<int> confirmContainer(String containerId, int quantity, String issueId) async {
    final response = await http.patch(
        Uri.parse(
            'https://cha-warehouse-management.azurewebsites.net/api/goodsissues/$issueId/containers'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          // 'Accept': 'application/json',
          'Accept': '*/*',
          // 'Authorization': 'Bearer $token',
        },
        body: jsonEncode(<String, dynamic>{
          "containerId": containerId,
          "quantity": quantity,
        }));
    print(containerId + quantity.toString());
    if (response.statusCode == 200) {
      print('success');
      return response.statusCode;
    } else {
      print('fail');
      return response.statusCode;
    }
  }
  Future<void> confirmIssue( String issueId) async {
    final response = await http.patch(
        Uri.parse(
            'https://cha-warehouse-management.azurewebsites.net/api/goodsissues/$issueId/containers/confirmed'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          // 'Accept': 'application/json',
          'Accept': '*/*',
          // 'Authorization': 'Bearer $token',
        },
        body: jsonEncode(<String, dynamic>{
        // listBasketIdConfirm
        }));
    if (response.statusCode == 200) {
      print('success');
    } else {
      print('fail');
    }
  }
}
