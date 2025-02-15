import 'package:erp_demo/main.dart';
import 'package:mysql1/mysql1.dart';

class MySQLService{
  static final MySQLService _mySQLService = MySQLService._internal();
  factory MySQLService(){
    return _mySQLService;
  }
  MySQLService._internal();

  final ConnectionSettings _settings = ConnectionSettings(
    host: flavorSettings.host,
    port: flavorSettings.port,
    user: flavorSettings.userName,
    password: flavorSettings.password,
    db: flavorSettings.databaseName,
  );

  Future<MySqlConnection> connect() async {
    return await MySqlConnection.connect(_settings);
  }
}