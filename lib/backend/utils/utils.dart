import 'package:crypt/crypt.dart';

class Utils{
  static String hashPassword(String password){
    return Crypt.sha256(password,salt: 'login').toString();
  }
}