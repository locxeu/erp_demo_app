import 'dart:ffi';
import 'package:erp_demo/app/src/data/repositories/purchase_order/purchase_order_repository_remote.dart';
import 'package:erp_demo/app/src/domain/model/purchase_order/purchase_order.dart';
import 'package:erp_demo/app/src/domain/model/sale_order/sale_order.dart';
import 'package:erp_demo/backend/controller/product_controller/product_controller.dart';
import 'package:erp_demo/backend/controller/purchase_controller/purchase_order_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PurchaseOrderProvider extends ChangeNotifier {
  List<PurchaseOrder> _purchaseOrders = [];
  List<PurchaseOrder> _saleOrders = [];
  List<Map<String, dynamic>> _products = [];
  List<Map<String, dynamic>> _companies = [];
  int? _selectedCustomer;
  Map<String, dynamic>? _selectedProduct;
  SaleOrder? _orderDetails;

  List<PurchaseOrder> get purchaseOrders => _purchaseOrders;
  List<PurchaseOrder> get saleOrders => _saleOrders;
  List<Map<String, dynamic>> get products => _products;
  List<Map<String, dynamic>> get companies => _companies;
  int? get selectedCustomer => _selectedCustomer;
  Map<String, dynamic>? get selectedProduct => _selectedProduct;
  SaleOrder? get orderDetails => _orderDetails;

  void setSelectedCustomer(int? customerId) {
    _selectedCustomer = customerId;
    notifyListeners();
  }

  void setSelectProduct(Map<String, dynamic>? product) {
    _selectedProduct = product;
    notifyListeners();
  }

  Future<void> fetchPurchaseOrders() async {
    final res = await PurchaseOrderRepositoryRemote().getAllPurchaseOrders();
    _purchaseOrders = res.data;
    notifyListeners();
  }

  Future<void> fetchProducts() async {
    _products = await ProductController().getAllProducts();
    notifyListeners();
  }

  Future<void> fetchCompanies() async {
    _companies = await PurchaseOrderController().getAllCompanies();
    notifyListeners();
  }

  Future<void> insertPurchaseOrder(
      {required Map<String, dynamic> orderData,
      required String SKU,
      required double price}) async {
    await PurchaseOrderController().insertPurchaseOrder(orderData);
    await fetchPurchaseOrders();
    insertOrderItem(SKU, price);
  }

  Future<void> insertOrderItem(String SKU, double price) async {
    final orderItemData = {
      'Qty': 1,
      'SKU': SKU,
      'OrderID': _purchaseOrders.last.orderID,
      'Price': price,
      'Total': price,
    };
    await PurchaseOrderController().insertOrderItem(orderItemData);
    await fetchPurchaseOrders();
  }

  Future<void> fetchSaleOrder() async {
    final res = await PurchaseOrderRepositoryRemote().getSaleOrders();
    _saleOrders = res.data;
    notifyListeners();
  }

  Future<void> fetchOrderDetails(int orderId) async {
    final res =
        await PurchaseOrderRepositoryRemote().getSaleOrderDetail(orderId);
    _orderDetails = res.data;
    notifyListeners();
  }
}
