import 'package:erp_demo/app/src/domain/model/inventory/inventory.dart';
import 'package:erp_demo/app/src/utils/result.dart';

abstract class InventoryRepository {
  Future<Result<List<Inventory>>> getInventoryList();
}