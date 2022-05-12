import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mobile_cha_warehouse/datasource/models/goods_receipts_model.dart';

String token = 'eyJhbGciOiJSUzI1NiIsImtpZCI6IjU2QzJFNzI3OUExN0UwMDc3RTVFOTJFMDAzRDg4NUFCIiwidHlwIjoiYXQrand0In0.eyJpc3MiOiJodHRwczovL2F1dGhlbnRpY2F0aW9uc2VydmVyMjAyMjAxMTEwOTQzNDMuYXp1cmV3ZWJzaXRlcy5uZXQiLCJuYmYiOjE2NTIzNDc3MTAsImlhdCI6MTY1MjM0NzcxMCwiZXhwIjoxNjUyMzUxMzEwLCJhdWQiOiJodHRwczovL2F1dGhlbnRpY2F0aW9uc2VydmVyMjAyMjAxMTEwOTQzNDMuYXp1cmV3ZWJzaXRlcy5uZXQvcmVzb3VyY2VzIiwic2NvcGUiOlsib3BlbmlkIiwibmF0aXZlLWNsaWVudC1zY29wZSIsInByb2ZpbGUiXSwiYW1yIjpbInB3ZCJdLCJjbGllbnRfaWQiOiJuYXRpdmUtY2xpZW50Iiwic3ViIjoiNDMyYmIxMmItOTcxZi00ZDZmLTc3ZTMtMDhkYTJmNDA2Yjc0IiwiYXV0aF90aW1lIjoxNjUyMzQ3NzA4LCJpZHAiOiJsb2NhbCIsIkFzcE5ldC5JZGVudGl0eS5TZWN1cml0eVN0YW1wIjoiN0dKSFNHNFlLWVlWNk1JT0hFNU82S1hFS1JNSUpPV0ciLCJyb2xlIjoiV2FyZWhvdXNlQ29vcmRpbmF0b3IiLCJwcmVmZXJyZWRfdXNlcm5hbWUiOiJuaG1kdW5nIiwibmFtZSI6Im5obWR1bmciLCJzaWQiOiI4N0JFRkJFQzg4MzZDQTkyRkI0NTUwQzQ4MUE2QUY5NiIsImp0aSI6IjRFQzhGMTI3MkM5RTYwQThDQkY4MUY5NjY0NkMzMjM4In0.O4S3o8Al3LS1rxkVhxUIkHdpT-sJezYZU6vuP7fqICOSZUDaroS60ixhQq103ZaAGmoiSc6ki2y-uxk1Rwid0-9908ceGqGNKWsGZVSx4HORct0KRfW35_7R_uyL9GlF1T_dvyxEEJ4LNZXZTiva55yToZbVI9BiE4HXGIio_mfgrFUH6NVUMChiDHUFbf_nRCM_Q-loNmahfr7THsT92MwzRpILIY-U7qo5uMvqyYY4xvwkrKftrSEsQdv6A2fMjafyOwmHIPsPvDGRgADTuPAxal4DPRW71tV_TElAf69F1DHzshNp0u0zA5GsgvJyKkwb-o0k04nRBBoH3H2MwQ';

class ReceiptService {
  Future<List<GoodsReceiptsModel>> getGoodsReceipt() async {
    final res = await http.get(
        Uri.parse(
            'https://cha-warehouse-management.azurewebsites.net/api/goodsreceipts/?Page=1&ItemsPerPage=10&StartTime=2021-03-01&EndTime=2023-05-30'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          // 'Accept': 'application/json',
          'Accept': '*/*',
          'Authorization': 'Bearer $token',
        });
    print(res.statusCode);
    if (res.statusCode == 200) {
      dynamic body = jsonDecode(res.body);
      print(body.toString());
      List<dynamic> bodyResponse = body['items'];
      List<GoodsReceiptsModel> allReceipts = bodyResponse
          .map(
            (dynamic item) => GoodsReceiptsModel.fromJson(item),
          )
          .toList();

      return allReceipts;
    } else {
      throw "Unable to retrieve posts.";
    }
  }
}
