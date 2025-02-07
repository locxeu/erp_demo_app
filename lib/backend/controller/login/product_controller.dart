import 'package:erp_demo/backend/services/mysql_service.dart';

class ProductController {
  Future<void> createProduct() async {
    final conn = await MySQLService().connect();
    await conn.query('''
      CREATE TABLE IF NOT EXISTS product (
        SKU VARCHAR(255) PRIMARY KEY,  
        Name VARCHAR(255) NOT NULL,
        Description TEXT,
        ImageUrl VARCHAR(255),  
        Price DECIMAL(10, 2) NOT NULL 
      )
    ''');
    await conn.close();
  }

  Future<void> insertProducts() async {
    final conn = await MySQLService().connect();
    try {
      for (int i = 1; i <= 20; i++) {
        await conn.query(
          'INSERT INTO product (SKU, Name, Description, ImageUrl, Price) VALUES (?, ?, ?, ?, ?)',
          [
            'SKU$i',
            'Product $i',
            'Description for Product $i',
            'http://example.com/image$i.png',
            (i * 10.0)
          ],
        );
      }
    } catch (e) {
    } finally {
      await conn.close();
    }
  }

  Future<List<Map<String, dynamic>>> getAllProducts() async {
    final conn = await MySQLService().connect();
    try {
      final results = await conn.query('SELECT * FROM product');
      return results.map((row) => row.fields).toList();
    } catch (e) {
      return [];
    } finally {
      await conn.close();
    }
  }
}
