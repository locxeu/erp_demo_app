import 'package:erp_demo/backend/controller/login/inventory_controller.dart';
import 'package:erp_demo/backend/controller/login/purchase_order_controller.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

class InventoryProvider extends ChangeNotifier {
  List<Map<String, dynamic>> _inventory = [];
  List<Map<String, dynamic>> _transferReceipt = [];
  List<Map<String, dynamic>> _transferReceiptDetail = [];
  List<Map<String, dynamic>> _products = [];
  List<Map<String, dynamic>> _companies = [];
  String? _selectedCustomer;
  Map<String, dynamic>? _selectedInventory;
  Map<String, dynamic>? _orderDetails;

  List<Map<String, dynamic>> get inventory => _inventory;

  List<Map<String, dynamic>> get transferReceipt => _transferReceipt;

  List<Map<String, dynamic>> get transferReceiptDetail => _transferReceiptDetail;

  List<Map<String, dynamic>> get products => _products;

  List<Map<String, dynamic>> get companies => _companies;

  String? get selectedCustomer => _selectedCustomer;

  Map<String, dynamic>? get selectedInventory => _selectedInventory;

  Map<String, dynamic>? get orderDetails => _orderDetails;

  void setSelectedCustomer(String? customerId) {
    _selectedCustomer = customerId;
    notifyListeners();
  }

  void setSelectProduct(Map<String, dynamic>? inventory) {
    _selectedInventory = inventory;
    notifyListeners();
  }

  Future<void> fetchCompanies() async {
    _companies = await PurchaseOrderController().getAllCompanies();
    notifyListeners();
  }

  Future<void> fetchTransferReceiptDetail(int id) async {
    _transferReceiptDetail = await InventoryController().getTransferReceiptDetail(id);
    notifyListeners();
  }

  Future<void> fetchInventory() async {
    _inventory = await InventoryController().getInventory();
    notifyListeners();
  }

  Future<void> addTransferReceipt(
      String fromLocation, String toLocation, TransferStatus status,String SKU,int qty) async {
    await InventoryController()
        .insertIntoTransferReceipt('OUT', fromLocation, toLocation, getTransferStatusString(status));
    _transferReceipt = await InventoryController().getTransferReceipt();
    final isUpdateInventory = status == TransferStatus.DELIVERED;
    await InventoryController().insertIntoTransferItem(_transferReceipt.last['ID'], SKU, qty,isUpdateInventory);
    notifyListeners();
  }

  Future<void> getTransferReceipt(
      ) async {
    _transferReceipt = await InventoryController().getTransferReceipt();
    notifyListeners();
  }
}

enum TransferStatus {
  DELIVERED,
  WAITING,
}

String getTransferStatusString(TransferStatus status) {
  switch (status) {
    case TransferStatus.DELIVERED:
      return "Delivered";
    case TransferStatus.WAITING:
      return "Waiting";
    default:
      return "Unknown";
  }
}