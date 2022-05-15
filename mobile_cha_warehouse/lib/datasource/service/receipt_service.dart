import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mobile_cha_warehouse/datasource/models/goods_receipts_model.dart';

String token =
    'eyJhbGciOiJSUzI1NiIsImtpZCI6IjU2QzJFNzI3OUExN0UwMDc3RTVFOTJFMDAzRDg4NUFCIiwidHlwIjoiYXQrand0In0.eyJpc3MiOiJodHRwczovL2F1dGhlbnRpY2F0aW9uc2VydmVyMjAyMjAxMTEwOTQzNDMuYXp1cmV3ZWJzaXRlcy5uZXQiLCJuYmYiOjE2NTI1ODExNjgsImlhdCI6MTY1MjU4MTE2OCwiZXhwIjoxNjUyNjA5OTY4LCJhdWQiOiJodHRwczovL2F1dGhlbnRpY2F0aW9uc2VydmVyMjAyMjAxMTEwOTQzNDMuYXp1cmV3ZWJzaXRlcy5uZXQvcmVzb3VyY2VzIiwic2NvcGUiOlsib3BlbmlkIiwibmF0aXZlLWNsaWVudC1zY29wZSIsInByb2ZpbGUiXSwiYW1yIjpbInB3ZCJdLCJjbGllbnRfaWQiOiJuYXRpdmUtY2xpZW50Iiwic3ViIjoiNDMyYmIxMmItOTcxZi00ZDZmLTc3ZTMtMDhkYTJmNDA2Yjc0IiwiYXV0aF90aW1lIjoxNjUyNTgxMTY3LCJpZHAiOiJsb2NhbCIsIkFzcE5ldC5JZGVudGl0eS5TZWN1cml0eVN0YW1wIjoiN0dKSFNHNFlLWVlWNk1JT0hFNU82S1hFS1JNSUpPV0ciLCJyb2xlIjoiV2FyZWhvdXNlQ29vcmRpbmF0b3IiLCJwcmVmZXJyZWRfdXNlcm5hbWUiOiJuaG1kdW5nIiwibmFtZSI6Im5obWR1bmciLCJzaWQiOiIwMjQzMzZFQ0ZDODVGMTZCMzlGNDBBM0YxODQ5RkRCQyIsImp0aSI6IjEwRjU0MEIwQTg3NTMwQUU0NUVEMDMzRUQ1MjkxNkFFIn0.dn5LwUCGHzu0f3Jre2Amon-wATmWn5cOtcJjz1h1myEs4mc5NO3l_0L2byM7m41zvgIbO7ziOthb0NZYptGMAF-IxmkG2XZHVP_421158U8rFPs1eENHTdFP_-klyfruIceTTM_IhXNX5aKkBhOj2gCqpRvqXri5ruVonbgTokk9U789eTnVJAyNMCEDDZYcRiRWeiQlKzJMvUBqsAnYPNm6axGt2LDh4WEnhVo0V_F10Vv4JHggoJ-aBvzBzpMTdGfNcQw2C-z8V_vs8hDNyeUvJc06s3r-lbpnoZpn6QsQ-PM9JMdnpGWRplsjtsSEvvjMAvzDTTACpb5GqRd-RA';

class ReceiptService {
  Future<List<GoodsReceiptsModel>> getGoodsReceipt(String startDate) async {
    final res = await http.get(
        Uri.parse(
            'https://cha-warehouse-management.azurewebsites.net/api/goodsreceipts/?Page=1&ItemsPerPage=10&StartTime=$startDate&EndTime=2023-05-30'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          // 'Accept': 'application/json',
          'Accept': '*/*',
          'Authorization': 'Bearer $token',
        });
    if (res.statusCode == 200) {
      dynamic body = jsonDecode(res.body);
      List<dynamic> bodyResponse = body['items'];
      List<GoodsReceiptsModel> allReceipts = bodyResponse
          .map(
            (dynamic item) => GoodsReceiptsModel.fromJson(item),
          )
          .toList();
      // print(allReceipts);
      return allReceipts;
    } else {
      throw "Unable to retrieve posts.";
    }
  }

  Future<GoodsReceiptsModel> getGoodsReceiptById(String id) async {
    final res = await http.get(
        Uri.parse(
            'https://cha-warehouse-management.azurewebsites.net/api/goodsreceipts/$id'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': '*/*',
          'Authorization': 'Bearer $token',
        });
    if (res.statusCode == 200) {
      dynamic body = jsonDecode(res.body);
      GoodsReceiptsModel receipts = GoodsReceiptsModel.fromJson(body);
      print(receipts);
      return receipts;
    } else {
      throw "Unable to retrieve posts.";
    }
  }
}
