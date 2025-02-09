import 'package:erp_demo/app/src/domain/model/purchase_order/purchase_order.dart';
import 'package:erp_demo/app/src/domain/model/sale_order/sale_order.dart';
import 'package:erp_demo/app/src/utils/result.dart';

abstract class PurchaseOrderRepository {
  Future<Result<List<PurchaseOrder>>> getAllPurchaseOrders();
  Future<Result<List<PurchaseOrder>>> getSaleOrders();
  Future<Result<SaleOrder>> getSaleOrderDetail(int id);
}
