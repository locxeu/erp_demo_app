import 'package:mysql1/mysql1.dart';

class MySQLService{
  static final MySQLService _mySQLService = MySQLService._internal();
  factory MySQLService(){
    return _mySQLService;
  }
  MySQLService._internal();

  final ConnectionSettings _settings = ConnectionSettings(
    host: 'gw.techarrow.asia',
    port: 30231,
    user: 'root',
    password: 'inv3st@Mysql2025',
    db: 'sonhn',
  );

  Future<MySqlConnection> connect() async {
    return await MySqlConnection.connect(_settings);
  }
}