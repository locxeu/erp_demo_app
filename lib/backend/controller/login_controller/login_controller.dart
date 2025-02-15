import 'package:erp_demo/backend/services/mysql_service.dart';
import 'package:erp_demo/backend/utils/utils.dart';

class LoginController {
  Future<void> createUsersTable() async {
    final conn = await MySQLService().connect();
    await conn.query('''
      CREATE TABLE IF NOT EXISTS users (
        id INT AUTO_INCREMENT PRIMARY KEY,
        name VARCHAR(100) NOT NULL,
        email VARCHAR(100) UNIQUE NOT NULL,
        password VARCHAR(255) NOT NULL,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
      )
    ''');
    await conn.close();
  }

  Future<void> insertUser(String name, String email, String password) async {
    final conn = await MySQLService().connect();
    final encryptPassword = Utils.hashPassword(password);
    try {
      await conn.query(
        'INSERT INTO users (name, email, password) VALUES (?, ?, ?)',
        [name, email, encryptPassword],
      );
    } catch (e) {
    } finally {
      await conn.close();
    }
  }

  Future<List<Map<String, dynamic>>> getUsers() async {
    final conn = await MySQLService().connect();
    List<Map<String, dynamic>> users = [];
    try {
      var results = await conn.query('SELECT * FROM users');
      for (var row in results) {
        users.add({
          'id': row['id'],
          'name': row['name'],
          'email': row['email'],
          'password': row['password'],
          'created_at': row['created_at'].toString(),
        });
      }
    } catch (e) {
    } finally {
      await conn.close();
    }
    return users;
  }

  Future<bool> checkUserLogin(String name, String password) async {
    final conn = await MySQLService().connect();
    final hashPassword = Utils.hashPassword(password);
    bool exists = false;
    try {
      var results = await conn.query(
        'SELECT * FROM users WHERE name = ? AND password = ?',
        [name, hashPassword],
      );
      if (results.isNotEmpty) {
        exists = true;
        return true;
      }
      return false;
    } catch (e) {
    } finally {
      await conn.close();
    }
    return exists;
  }
}
