import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mobile_cha_warehouse/datasource/models/container_model.dart';
import 'package:mobile_cha_warehouse/datasource/models/goods_issues_model.dart';
import 'package:mobile_cha_warehouse/domain/entities/container.dart';

class ContainerService {
  Future<ContainerModel> getContainerLocation(String id) async {
    final res = await http.get(
      Uri.parse(
          'https://cha-warehouse-management.azurewebsites.net/api/containers/$id'),
    );
    if (res.statusCode == 200) {
      dynamic body = jsonDecode(res.body);
      //   print(body.toString());
      ContainerModel items = ContainerModel.fromJson(body);

      print(items.storageSlot.shelfId+items.storageSlot.cellId.toString()+items.storageSlot.rowId.toString());
      return items;
    } else {
      
      throw "Unable to retrieve posts.";
    }
   
  }
}
