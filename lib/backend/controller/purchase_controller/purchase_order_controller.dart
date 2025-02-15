import 'package:erp_demo/backend/services/mysql_service.dart';

class PurchaseOrderController {
  Future<List<Map<String, dynamic>>> getAllCompanies() async {
    final conn = await MySQLService().connect();
    try {
      final results = await conn.query('SELECT * FROM company');
      return results.map((row) => row.fields).toList();
    } catch (e) {
      return [];
    } finally {
      await conn.close();
    }
  }

  Future<void> createOrderItemTable() async {
    final conn = await MySQLService().connect();
    try {
      await conn.query('''
      CREATE TABLE IF NOT EXISTS orderItem (
       OrderItemID INT PRIMARY KEY AUTO_INCREMENT,
    OrderID INT,
    SKU VARCHAR(255),
    Unit VARCHAR(255),
    Qty INT NOT NULL,
    Price DECIMAL(10, 2),
    Tax DECIMAL(10, 2),
    Discount DECIMAL(10, 2),
    Subtotal DECIMAL(10, 2),
    OriginPrice DECIMAL(10, 2),
    FOREIGN KEY (OrderID) REFERENCES purchaseOrder(OrderID),
    FOREIGN KEY (SKU) REFERENCES Product(SKU)
      )
    ''');
      await conn.close();
    } catch (e) {
    } finally {
      await conn.close();
    }
  }

  Future<void> insertOrderItem(Map<String, dynamic> orderItemData) async {
    final conn = await MySQLService().connect();
    final isExist = await checkTableExists('orderItem');
    if (!isExist) {
      await createOrderItemTable();
    }
    try {
      await conn.query(
        '''
        INSERT INTO orderItem (
          OrderID, SKU, Unit, Qty, Price, Tax, Discount, Subtotal, OriginPrice
        ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)
        ''',
        [
          orderItemData['OrderID'],
          orderItemData['SKU'],
          orderItemData['Unit'],
          orderItemData['Qty'],
          orderItemData['Price'],
          orderItemData['Tax'],
          orderItemData['Discount'],
          orderItemData['Subtotal'],
          orderItemData['OriginPrice']
        ],
      );
    } catch (e) {
    } finally {
      await conn.close();
    }
  }

  Future<void> createPurchaseOrderTable() async {
    final conn = await MySQLService().connect();
    try {
      await conn.query('''
      CREATE TABLE IF NOT EXISTS purchaseOrder (
    OrderID INT PRIMARY KEY AUTO_INCREMENT,
        CompanyID INT,
        DateIssued DATE,
        DeliveryAddress TEXT,
        ShippingMethod VARCHAR(255),
        PaymentType VARCHAR(255),
        Status VARCHAR(50),
        GrandTotal DECIMAL(10, 2),
        Discount DECIMAL(10, 2),
        TotalTax DECIMAL(10, 2),
        Note TEXT,
        Commission DECIMAL(10, 2),
        FOREIGN KEY (CompanyID) REFERENCES Company(CompanyID)
      )
    ''');
      await conn.close();
    } catch (e) {
    } finally {
      await conn.close();
    }
  }

  Future<void> insertPurchaseOrder(Map<String, dynamic> orderData) async {
    final conn = await MySQLService().connect();
    final isExist = await checkTableExists('purchaseOrder');
    if (!isExist) {
      await createPurchaseOrderTable();
    }
    try {
      await conn.query(
        '''
        INSERT INTO purchaseOrder (
          CompanyID, DateIssued, DeliveryAddress, ShippingMethod,
          PaymentType, Status, GrandTotal, Discount, TotalTax, Note, Commission
        ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
        ''',
        [
          orderData['CompanyID'],
          orderData['DateIssued'],
          orderData['DeliveryAddress'],
          orderData['ShippingMethod'],
          orderData['PaymentType'],
          orderData['Status'],
          orderData['GrandTotal'],
          orderData['Discount'],
          orderData['TotalTax'],
          orderData['Note'],
          orderData['Commission']
        ],
      );
    } catch (e) {
    } finally {
      await conn.close();
    }
  }

  Future<List<Map<String, dynamic>>> getAllPurchaseOrders() async {
    final conn = await MySQLService().connect();
    try {
      final results = await conn.query('SELECT * FROM purchaseOrder');
      return results.map((row) => row.fields).toList();
    } catch (e) {
      return [];
    } finally {
      await conn.close();
    }
  }

  Future<List<Map<String, dynamic>>> getSaleOrder() async {
    final conn = await MySQLService().connect();
    try {
      final results = await conn.query(
          'SELECT * FROM purchaseOrder WHERE Status = \'purchase order\'');
      return results.map((row) => row.fields).toList();
    } catch (e) {
      return [];
    } finally {
      await conn.close();
    }
  }

  Future<Map<String, dynamic>> getOrderDetails(int orderId) async {
    final conn = await MySQLService().connect();
    try {
      final results = await conn.query(
        '''
          SELECT po.*, oi.*, p.*
      FROM purchaseOrder po
      LEFT JOIN orderItem oi ON po.OrderID = oi.OrderID
      LEFT JOIN product p ON oi.SKU = p.SKU
      WHERE po.OrderID = ?
        ''',
        [orderId],
      );

      if (results.isEmpty) {
        return {};
      }

      final purchaseOrder = results.first.fields;
      return purchaseOrder;
    } catch (e) {
      return {};
    } finally {
      await conn.close();
    }
  }

  Future<bool> checkTableExists(String tableName) async {
    final conn = await MySQLService().connect();
    try {
      var result = await conn.query(
        '''
        SELECT COUNT(*)
        FROM information_schema.tables 
        WHERE table_schema = DATABASE() 
        AND table_name = ?
        ''',
        [tableName],
      );
      return result.first[0] > 0;
    } catch (e) {
      return false;
    } finally {
      await conn.close();
    }
  }
}
