import 'package:erp_demo/app/src/data/repositories/purchase_order/purchase_order_repository.dart';
import 'package:erp_demo/app/src/data/services/api/api_client.dart';
import 'package:erp_demo/app/src/domain/model/purchase_order/purchase_order.dart';
import 'package:erp_demo/app/src/domain/model/sale_order/sale_order.dart';
import 'package:erp_demo/app/src/utils/result.dart';

class PurchaseOrderRepositoryRemote implements PurchaseOrderRepository {
  final ApiClient _apiClient = ApiClient();

  @override
  Future<Result<List<PurchaseOrder>>> getAllPurchaseOrders() async {
    return await _apiClient.getAllPurchaseOrders();
  }
  
  @override
  Future<Result<List<PurchaseOrder>>> getSaleOrders() async {
   return await _apiClient.getSalesOrder();
  }
  
  @override
  Future<Result<SaleOrder>> getSaleOrderDetail(int id) async {
    return await _apiClient.getSaleOrderDetail(id);
  }
}