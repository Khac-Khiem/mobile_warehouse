import 'package:mobile_cha_warehouse/datasource/service/item_service.dart';
import 'package:mobile_cha_warehouse/domain/entities/item.dart';
import 'package:mobile_cha_warehouse/domain/repositories/item_repository.dart';

class ItemRepositoryimpl implements ItemRepository {
  ItemService itemService;
  ItemRepositoryimpl(this.itemService);
  @override
  Future<List<Item>> getAllItem() {
    // TODO: implement getAllItem
    throw UnimplementedError();
  }

  @override
  Future<Item> getItemById(String id) {
    // TODO: implement getItemById
    throw UnimplementedError();
  }
}
