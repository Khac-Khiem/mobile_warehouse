import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:mobile_cha_warehouse/datasource/models/goods_receipts_model.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/blocs/receipt_bloc.dart';

String token = 'eyJhbGciOiJSUzI1NiIsImtpZCI6IjU2QzJFNzI3OUExN0UwMDc3RTVFOTJFMDAzRDg4NUFCIiwidHlwIjoiYXQrand0In0.eyJpc3MiOiJodHRwczovL2F1dGhlbnRpY2F0aW9uc2VydmVyMjAyMjAxMTEwOTQzNDMuYXp1cmV3ZWJzaXRlcy5uZXQiLCJuYmYiOjE2NTQxMzA4NzMsImlhdCI6MTY1NDEzMDg3MywiZXhwIjoxNjU0MTU5NjczLCJhdWQiOiJodHRwczovL2F1dGhlbnRpY2F0aW9uc2VydmVyMjAyMjAxMTEwOTQzNDMuYXp1cmV3ZWJzaXRlcy5uZXQvcmVzb3VyY2VzIiwic2NvcGUiOlsib3BlbmlkIiwibmF0aXZlLWNsaWVudC1zY29wZSIsInByb2ZpbGUiXSwiYW1yIjpbInB3ZCJdLCJjbGllbnRfaWQiOiJuYXRpdmUtY2xpZW50Iiwic3ViIjoiNDMyYmIxMmItOTcxZi00ZDZmLTc3ZTMtMDhkYTJmNDA2Yjc0IiwiYXV0aF90aW1lIjoxNjU0MTMwODcxLCJpZHAiOiJsb2NhbCIsIkFzcE5ldC5JZGVudGl0eS5TZWN1cml0eVN0YW1wIjoiN0dKSFNHNFlLWVlWNk1JT0hFNU82S1hFS1JNSUpPV0ciLCJyb2xlIjoiV2FyZWhvdXNlQ29vcmRpbmF0b3IiLCJwcmVmZXJyZWRfdXNlcm5hbWUiOiJuaG1kdW5nIiwibmFtZSI6Im5obWR1bmciLCJzaWQiOiIwRUQ2ODE5MTg4NUY0NEYzMzY4N0I0OEE4NEU0MkNFQyIsImp0aSI6Ijg1REFFRkNCOThBOEM4NDlBQkRBMjFFMEQ3QkU3RTcyIn0.roeWczTKX1LAGR4SOWS-r_NtJ3A61vIOSn95UvHkCvXbKL7R-joRLiJhNJGPPg-7Wq8RTay3sR1fR7Wa2Shq-EcQFiAEl4lm2gVwneclq8I7LAOxMwIofkrjLmAbDbeuhmjwgdSEBr4nGHHwz-ufnWRj_HQ6zIienmRFKEZlRNTe1RZlUQlnRtm3IiZyvjNDSHD49r8RX7Cr9IBgcgP6whXG3hEl82OerWzIb6l4_dpdyugqpODu7CF3vZ7iOmz-szq-S8inF0CN9lLFe8zOImcCpeuUKSKIQ81luI2b4ccJyNlysEiRocnQ_t7e2PbqHF5-rbwuyta5-l7cZ6IJuQ';

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
