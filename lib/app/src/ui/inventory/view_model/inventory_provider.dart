import 'package:erp_demo/app/src/data/repositories/inventory/inventory_reposiory_remote.dart';
import 'package:erp_demo/app/src/data/repositories/inventory/inventory_repository.dart';
import 'package:erp_demo/app/src/domain/model/inventory/inventory.dart';
import 'package:erp_demo/backend/controller/inventory_controller/inventory_controller.dart';
import 'package:erp_demo/backend/controller/purchase_controller/purchase_order_controller.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

class InventoryProvider extends ChangeNotifier {
  List<Inventory> _inventory = [];
  List<Map<String, dynamic>> _transferReceipt = [];
  List<Map<String, dynamic>> _transferReceiptDetail = [];
  List<Map<String, dynamic>> _products = [];
  List<Map<String, dynamic>> _companies = [];
  String? _selectedCustomer;
  Inventory? _selectedInventory;
  Map<String, dynamic>? _orderDetails;

  List<Inventory> get inventory => _inventory;

  List<Map<String, dynamic>> get transferReceipt => _transferReceipt;

  List<Map<String, dynamic>> get transferReceiptDetail => _transferReceiptDetail;

  List<Map<String, dynamic>> get products => _products;

  List<Map<String, dynamic>> get companies => _companies;

  String? get selectedCustomer => _selectedCustomer;

  Inventory? get selectedInventory => _selectedInventory;

  Map<String, dynamic>? get orderDetails => _orderDetails;

  void setSelectedCustomer(String? customerId) {
    _selectedCustomer = customerId;
    notifyListeners();
  }

  void setSelectProduct(Inventory? inventory) {
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

  Future<List<Inventory>> fetchInventory() async {
    final result = await InventoryRepositoryImpl().getInventoryList();
    _inventory = result.data; 
    notifyListeners();
    return _inventory;
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