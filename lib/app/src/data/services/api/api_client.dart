import 'package:erp_demo/app/src/domain/model/inventory/inventory.dart';
import 'package:erp_demo/app/src/domain/model/purchase_order/purchase_order.dart';
import 'package:erp_demo/app/src/domain/model/sale_order/sale_order.dart';
import 'package:erp_demo/app/src/utils/result.dart';
import 'package:erp_demo/backend/controller/login/inventory_controller.dart';
import 'package:erp_demo/backend/controller/login/purchase_order_controller.dart';

class ApiClient {
  Future<Result<List<Inventory>>> getInventory() async {
    try {
      final response = await InventoryController().getInventory();
      return Result.ok(
          response.map((json) => Inventory.fromJson(json)).toList());
    } on Exception catch (error) {
      return Result.error(error);
    }
  }

    Future<Result<List<PurchaseOrder>>> getAllPurchaseOrders() async {
    try {
      final response = await PurchaseOrderController().getAllPurchaseOrders();
      return Result.ok(
          response.map((json) => PurchaseOrder.fromJson(json)).toList());
    } on Exception catch (error) {
      return Result.error(error);
    }
  }

      Future<Result<List<PurchaseOrder>>> getSalesOrder() async {
    try {
      final response = await PurchaseOrderController().getSaleOrder();
      return Result.ok(
          response.map((json) => PurchaseOrder.fromJson(json)).toList());
    } on Exception catch (error) {
      return Result.error(error);
    }
  }

    Future<Result<SaleOrder>> getSaleOrderDetail(int id) async {
    try {
      final response = await PurchaseOrderController().getOrderDetails(id);
      return Result.ok(SaleOrder.fromJson(response));
    } on Exception catch (error) {
      return Result.error(error);
    }
  }
}
