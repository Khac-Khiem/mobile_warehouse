import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mobile_cha_warehouse/datasource/models/goods_receipts_model.dart';

String token = 'eyJhbGciOiJSUzI1NiIsImtpZCI6IjU2QzJFNzI3OUExN0UwMDc3RTVFOTJFMDAzRDg4NUFCIiwidHlwIjoiYXQrand0In0.eyJpc3MiOiJodHRwczovL2F1dGhlbnRpY2F0aW9uc2VydmVyMjAyMjAxMTEwOTQzNDMuYXp1cmV3ZWJzaXRlcy5uZXQiLCJuYmYiOjE2NTI1MjA4MzQsImlhdCI6MTY1MjUyMDgzNCwiZXhwIjoxNjUyNTQ5NjM0LCJhdWQiOiJodHRwczovL2F1dGhlbnRpY2F0aW9uc2VydmVyMjAyMjAxMTEwOTQzNDMuYXp1cmV3ZWJzaXRlcy5uZXQvcmVzb3VyY2VzIiwic2NvcGUiOlsib3BlbmlkIiwibmF0aXZlLWNsaWVudC1zY29wZSIsInByb2ZpbGUiXSwiYW1yIjpbInB3ZCJdLCJjbGllbnRfaWQiOiJuYXRpdmUtY2xpZW50Iiwic3ViIjoiNDMyYmIxMmItOTcxZi00ZDZmLTc3ZTMtMDhkYTJmNDA2Yjc0IiwiYXV0aF90aW1lIjoxNjUyNTIwODMzLCJpZHAiOiJsb2NhbCIsIkFzcE5ldC5JZGVudGl0eS5TZWN1cml0eVN0YW1wIjoiN0dKSFNHNFlLWVlWNk1JT0hFNU82S1hFS1JNSUpPV0ciLCJyb2xlIjoiV2FyZWhvdXNlQ29vcmRpbmF0b3IiLCJwcmVmZXJyZWRfdXNlcm5hbWUiOiJuaG1kdW5nIiwibmFtZSI6Im5obWR1bmciLCJzaWQiOiI0QTM2MDQ1MzM3NjExOTlCNjM2NDEwQkRCMUZBMTMxMiIsImp0aSI6Ijc2NTk1QkIxMzA1OUJDQkYxRTFBNkFCQUY1NEIxOUJBIn0.rzWs3WnSSkP6TAS6DSu6ceJAn_owDU7HUTLA4Lpy2ArxRiwwW_A2UMg_fp3Wq3MMo053Lkf7Mjq7cB5UJnRv4Quj-6uXgmZDJB_8dIjmHiiEWdjMcB4tzN5IOX0r4xMma57cX5enK_fuiyAdlYFSVRZYNKpZVmBI5EU4NDGnLhJSF77LVBFwnAguKd3Fpkzz-DyaoDuLq8Tx7jgYo-9wcQPae-sOn5NCteTwO13hbbMarSWbeoZtmYNtqoVOa8DwlIdb5ToMyUTuo9mm7qQy2LFS10VYY1ranUSrmsGY4KjDIlMLNYdRSobA7wA2wWmCrT4Qj3ERjm7id1pKMz1skg';

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
