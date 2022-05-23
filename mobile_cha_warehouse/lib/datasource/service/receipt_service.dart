import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:mobile_cha_warehouse/datasource/models/goods_receipts_model.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/blocs/receipt_bloc.dart';
import 'package:mobile_cha_warehouse/presentation/screens/receipt/modify_info_screen.dart';

String token = 'eyJhbGciOiJSUzI1NiIsImtpZCI6IjU2QzJFNzI3OUExN0UwMDc3RTVFOTJFMDAzRDg4NUFCIiwidHlwIjoiYXQrand0In0.eyJpc3MiOiJodHRwczovL2F1dGhlbnRpY2F0aW9uc2VydmVyMjAyMjAxMTEwOTQzNDMuYXp1cmV3ZWJzaXRlcy5uZXQiLCJuYmYiOjE2NTMyOTMzNTMsImlhdCI6MTY1MzI5MzM1MywiZXhwIjoxNjUzMzIyMTUzLCJhdWQiOiJodHRwczovL2F1dGhlbnRpY2F0aW9uc2VydmVyMjAyMjAxMTEwOTQzNDMuYXp1cmV3ZWJzaXRlcy5uZXQvcmVzb3VyY2VzIiwic2NvcGUiOlsib3BlbmlkIiwibmF0aXZlLWNsaWVudC1zY29wZSIsInByb2ZpbGUiXSwiYW1yIjpbInB3ZCJdLCJjbGllbnRfaWQiOiJuYXRpdmUtY2xpZW50Iiwic3ViIjoiNDMyYmIxMmItOTcxZi00ZDZmLTc3ZTMtMDhkYTJmNDA2Yjc0IiwiYXV0aF90aW1lIjoxNjUzMjkzMzUyLCJpZHAiOiJsb2NhbCIsIkFzcE5ldC5JZGVudGl0eS5TZWN1cml0eVN0YW1wIjoiN0dKSFNHNFlLWVlWNk1JT0hFNU82S1hFS1JNSUpPV0ciLCJyb2xlIjoiV2FyZWhvdXNlQ29vcmRpbmF0b3IiLCJwcmVmZXJyZWRfdXNlcm5hbWUiOiJuaG1kdW5nIiwibmFtZSI6Im5obWR1bmciLCJzaWQiOiJGQkI1RDY0MTAyNTREMjUzMUI2MzUzMDAwRDJDRkE3NCIsImp0aSI6IkJCNkMzREJFOTkwQkRDNzE5QUM2Mzk3RDA5MDdBQUMzIn0.hM5_cU3THhGwaQeW7Pib3RTOpodRVLurOW_NIfmtF7NP8I1zVn-FRinZggmnFHca-VoEuEcu66DB7uIlKQmPaeJESBop0g1zWQivJpVLmvWKYEk0M6mVhezAR8OdAyy-S1-X-QWZMqsjVRjDu8WuB44MNtfQ2kckft7urxqwI7Aoy2lKcfJYUoKty49F7yZtCMPbqQCGbOmkLyJhw_duDN7nl7kENBLKIOuEA5ScQWyfaUuvuEVPMIBpDTXGryNLFDnYZUYQZlaDgsbwjs-HBTmJDy_mvoNxYqABnPqU9JJ5TdV9CysyBNT2xL7jxUyLTmbSBluHlcfrqTQ1XDeFfg';

class ReceiptService {
  Future<List<GoodsReceiptsModel>> getGoodsReceipt(String startDate) async {
    final res = await http.get(
        Uri.parse(
            'https://cha-warehouse-management.azurewebsites.net/api/goodsreceipts/?Page=1&ItemsPerPage=1000&StartTime=$startDate&EndTime=2023-05-30'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
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
      List<GoodsReceiptsModel> allReceipts = [];

      //throw "Unable to retrieve posts.";
      return allReceipts;
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

  Future<void> addContainerReceipt(
      GoodsReceiptEntryContainerData goodsReceiptEntryContainerData,
      String receiptId) async {
    // List<Map<String, dynamic>> bodyJson = [];
    // for (var i = 0; i < goodsReceiptEntryContainerData.length; i++) {
    //   Map<String, dynamic> entryJson = {
    //     "containerId": "NCC - TB - 05172022 - 0048",
    //     "itemId": "LXNR",
    //     "plannedQuantity": double.parse(50.toString()),
    //     "actualQuantity": double.parse(50.toString()),
    //     "productionDate": "2022-05-21"
    //   };
    //   bodyJson.add(entryJson);
    // }
    final res = await http.patch(
        Uri.parse(
            'https://cha-warehouse-management.azurewebsites.net/api/goodsreceipts/$receiptId/containers'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': '*/*',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(<Map<String, dynamic>>[
          {
            "containerId": goodsReceiptEntryContainerData.containerId,
            // "containerId": a == true
            //     ? "NCC - TB - 05172022 - 0005"
            //     : "NCC - TB - 05172022 - 0006",
            "itemId": goodsReceiptEntryContainerData.itemId,
            "plannedQuantity": double.parse(
                goodsReceiptEntryContainerData.plannedQuantity.toString()),
            "actualQuantity": double.parse(
                goodsReceiptEntryContainerData.actualQuantity.toString()),
            "productionDate": DateFormat("yyyy-MM-dd").format(DateTime.now())
            //  "containerId": "NCC - TB - 05172022 - 0048",
            // "itemId": "LXC1",
            // "plannedQuantity": double.parse(goodsReceiptEntryContainerData.plannedQuantity.toString()),
            // "actualQuantity": double.parse(goodsReceiptEntryContainerData.actualQuantity.toString()),
            // "productionDate":  DateFormat("yyyy-MM-dd")
            //                  .format(DateTime.now())
          },
        ]));
    if (res.statusCode == 200) {
      print('success');
    } else {
      print('fail');
      // throw "Unable to retrieve posts.";
    }
  }

  Future<int> confirmReceipt(String receiptId) async {
    final response = await http.patch(
      Uri.parse(
          'https://cha-warehouse-management.azurewebsites.net/api/goodsreceipts/$receiptId/confirmed'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': '*/*',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      print('success');
      return response.statusCode;
    } else {
      print('fail');
      return response.statusCode;
    }
  }
}
