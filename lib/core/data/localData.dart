import 'dart:convert';
import 'package:g20newapp/modules/login/models/credentials.dart';
import 'package:shared_preferences/shared_preferences.dart';


class LocalData{
  static Future<bool> saveLocalCredentials(Credentials credentials)async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool result = await prefs.setString('credentials', jsonEncode(credentials));
    return result;
  }
static Future<Credentials> getLocalCredentials()async {
    try{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String credentialsPref = prefs.getString('credentials');
      Map<String,dynamic> userMap = jsonDecode(credentialsPref) as Map<String, dynamic>;
      return Credentials.fromJson(userMap);
    }catch(e){
      return throw 'erro ao pegar user';
    }
}
  static deleteLocalCredentials()async {
    try{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove('credentials');
    }catch(e){
      return throw 'erro ao remover';
    }
  }

}

