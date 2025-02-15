import 'package:erp_demo/backend/services/mysql_service.dart';

class InventoryController {
  Future<void> createInventoryTable() async {
    final conn = await MySQLService().connect();
    try {
      await conn.query('''
      CREATE TABLE IF NOT EXISTS purchaseOrder (
     UniqueID INT PRIMARY KEY AUTO_INCREMENT,
     SKU VARCHAR(255),
     Qty INT,
     Store VARCHAR(255),
      )
    ''');
      await conn.close();
    } catch (e) {
    } finally {
      await conn.close();
    }
  }

  Future<List<Map<String, dynamic>>> getInventory() async {
    final conn = await MySQLService().connect();
    try {
      final results = await conn.query('''
        SELECT p.*, i.Qty, i.Store
        FROM product p
        LEFT JOIN inventory i ON p.SKU = i.SKU
      ''');
      return results.map((row) => row.fields).toList();
    } catch (e) {
      return [];
    } finally {
      await conn.close();
    }
  }

  Future<void> insertIntoTransferReceipt(String type, String fromLocation,
      String toLocation, String status) async {
    final conn = await MySQLService().connect();
    try {
      await conn.query('''
        INSERT INTO transferreceipt (Datetime, type, FromLocation, ToLocation, Status)
        VALUES (CURRENT_TIMESTAMP, ?, ?, ?, ?)
      ''', [type, fromLocation, toLocation, status]);
    } catch (e) {
    } finally {
      await conn.close();
    }
  }

  Future<List<Map<String, dynamic>>> getTransferReceipt() async {
    final conn = await MySQLService().connect();
    try {
      final results = await conn.query('SELECT * FROM transferreceipt');
      return results.map((row) => row.fields).toList();
    } catch (e) {
      return [];
    } finally {
      await conn.close();
    }
  }

  Future<List<Map<String, dynamic>>> getTransferReceiptDetail(int transferId) async {
    final conn = await MySQLService().connect();
    try {
      final results = await conn.query('''
        SELECT tr.*, ti.*, p.*
        FROM TransferReceipt tr
        JOIN TransferItem ti ON tr.ID = ti.transferId
        JOIN product p ON ti.SKU = p.SKU
        WHERE ti.transferId = ?
      ''', [transferId]);
      return results.map((row) => row.fields).toList();
    } catch (e) {
      return [];
    } finally {
      await conn.close();
    }
  }

  Future<void> insertIntoTransferItem(
      int transferId, String sku, int qty, bool isUpdate) async {
    final conn = await MySQLService().connect();
    try {
      await conn.query('''
        INSERT INTO transferitem (TransferID, SKU, Qty)
        VALUES (?, ?, ?)
      ''', [transferId, sku, qty]);

      if (isUpdate) {
        //Update inventory quantity
        await conn.query('''
        UPDATE inventory
        SET Qty = Qty - ?
        WHERE SKU = ?
      ''', [qty, sku]);
      }
    } catch (e) {
    } finally {
      await conn.close();
    }
  }
}
