import 'dart:ffi';
import 'package:erp_demo/backend/controller/login/product_controller.dart';
import 'package:erp_demo/backend/controller/login/purchase_order_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PurchaseOrderProvider extends ChangeNotifier {
  List<Map<String, dynamic>> _purchaseOrders = [];
  List<Map<String, dynamic>> _saleOrders = [];
  List<Map<String, dynamic>> _products = [];
  List<Map<String, dynamic>> _companies = [];
  int? _selectedCustomer;
  Map<String, dynamic>? _selectedProduct;
  Map<String, dynamic>? _orderDetails;


  List<Map<String, dynamic>> get purchaseOrders => _purchaseOrders;
  List<Map<String, dynamic>> get saleOrders => _saleOrders;
  List<Map<String, dynamic>> get products => _products;
  List<Map<String, dynamic>> get companies => _companies;
  int? get selectedCustomer => _selectedCustomer;
  Map<String, dynamic>? get selectedProduct => _selectedProduct;
  Map<String, dynamic>? get orderDetails => _orderDetails;

  void setSelectedCustomer(int? customerId) {
    _selectedCustomer = customerId;
    notifyListeners();
  }

  void setSelectProduct(Map<String, dynamic>? product) {
    _selectedProduct = product;
    notifyListeners();
  }

  Future<void> fetchPurchaseOrders() async {
    _purchaseOrders = await PurchaseOrderController().getAllPurchaseOrders();
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


  Future<void> insertPurchaseOrder({required Map<String, dynamic> orderData,required String SKU,required double price}) async {
    await PurchaseOrderController().insertPurchaseOrder(orderData);
   await fetchPurchaseOrders();
   insertOrderItem(SKU,price);
  }

  Future<void> insertOrderItem(String SKU,double price) async {
    final orderItemData = {
      'Qty': 1,
      'SKU': SKU,
      'OrderID': _purchaseOrders.last['OrderID'],
      'Price':price,
      'Total': price,
    };
    await PurchaseOrderController().insertOrderItem(orderItemData);
    await fetchPurchaseOrders();
  }

  Future<void> fetchSaleOrder() async {
    _saleOrders = await PurchaseOrderController().getSaleOrder();
    notifyListeners();
  }

  Future<void> fetchOrderDetails(int orderId) async {
    _orderDetails = await PurchaseOrderController().getOrderDetails(orderId);
    notifyListeners();
  }

}