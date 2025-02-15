import 'package:flutter_dotenv/flutter_dotenv.dart';

class FlavorSettings {
  final String host;
  final int port;
  final String userName;
  final String password;
  final String databaseName;

  FlavorSettings({
    required this.host,
    required this.port,
    required this.userName,
    required this.password,
    required this.databaseName,
  });

  static Future<FlavorSettings> fromEnv() async {
    await dotenv.load(fileName: ".env");
    final host = dotenv.get('HOST', fallback: '');
    final port = dotenv.getInt('PORT', fallback: 0);
    final userName = dotenv.get('USER', fallback: '');
    final pw = dotenv.get('PASSWORD', fallback: '');
    final database = dotenv.get('DATABASE', fallback: '');
    return FlavorSettings(
      host: host,
      port: port,
      userName: userName,
      password: pw,
      databaseName: database,
    );
  }
}