import 'package:erp_demo/app/src/features/purchase_order/domain/purchase_order.dart';
import 'package:erp_demo/backend/controller/login/purchase_order_controller.dart';

class ApiService {
  final PurchaseOrderController _purchaseController = PurchaseOrderController();

  Future<List<PurchaseOrder>> fetchPurchaseOrders() async {
    final response = await _purchaseController.getAllPurchaseOrders();
    return response
        .map<PurchaseOrder>((json) => PurchaseOrder.fromJson(json))
        .toList();
  }
}
