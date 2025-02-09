import 'package:erp_demo/app/src/data/repositories/inventory/inventory_repository.dart';
import 'package:erp_demo/app/src/data/services/api/api_client.dart';
import 'package:erp_demo/app/src/domain/model/inventory/inventory.dart';
import 'package:erp_demo/app/src/utils/result.dart';

class InventoryRepositoryImpl implements InventoryRepository {
  final ApiClient _apiClient = ApiClient();

  @override
  Future<Result<List<Inventory>>> getInventoryList() async {
    return await _apiClient.getInventory();
  }
}