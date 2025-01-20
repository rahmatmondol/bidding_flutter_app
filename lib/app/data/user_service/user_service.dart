import 'package:shared_preferences/shared_preferences.dart';

class UserService {
  SharedPreferences? prefs;

  // Server server = Server();

  saveString({String? key, String? value}) async {
    prefs = await SharedPreferences.getInstance();
    return await prefs!.setString(key!, value!);
  }

  saveStringProvider({String? key, String? value}) async {
    prefs = await SharedPreferences.getInstance();
    return await prefs!.setString(key!, value!);
  }

  getString({String? key}) async {
    prefs = await SharedPreferences.getInstance();
    return prefs!.getString(key!);
  }

  Future<bool> saveBoolean({required String key, required bool value}) async {
    prefs = await SharedPreferences.getInstance();
    return await prefs!.setBool(key, value);
  }

  Future<bool> saveBooleanProvider(
      {required String key, required bool value}) async {
    prefs = await SharedPreferences.getInstance();
    return await prefs!.setBool(key, value);
  }

  saveDouble({String? key, double? value}) async {
    prefs = await SharedPreferences.getInstance();
    return await prefs!.setDouble(key!, value!);
  }

  getDouble({String? key}) async {
    prefs = await SharedPreferences.getInstance();
    return prefs!.getDouble(key!);
  }

  saveInt({String? key, int? value}) async {
    prefs = await SharedPreferences.getInstance();
    return await prefs!.setInt(key!, value!);
  }

  getInt({String? key}) async {
    prefs = await SharedPreferences.getInstance();
    return prefs!.getInt(key!);
  }

  isUser() async {
    prefs = await SharedPreferences.getInstance();
    print(prefs!.getBool('is-user'));
    if (prefs!.getBool('is-user') != null) {
      return prefs!.getBool('is-user');
    } else {
      return false;
    }
  }

  isProvider() async {
    prefs = await SharedPreferences.getInstance();
    print(prefs!.getBool('is-user-provider'));
    if (prefs!.getBool('is-user-provider') != null) {
      return prefs!.getBool('is-user-provider');
    } else {
      return false;
    }
  }

  Future<bool?> getBool() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    bool? b = prefs.getBool('is-user');
    print(b);
    return b;
  }

  Future<bool?> getBoolProvider() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    bool? b = prefs.getBool('is-user-provider');
    print(b);
    return b;
  }

  getUserId() async {
    print("came here");
    prefs = await SharedPreferences.getInstance();
    if (prefs!.getString('user-id') != null) {
      return prefs!.getString('user-id').toString();
    } else {
      return null;
    }
  }

  getToken() async {
    prefs = await SharedPreferences.getInstance();
    if (prefs!.getString('token') != null) {
      String? token = prefs!.getString('token');
      return "Bearer ${token!}";
    } else {
      return null;
    }
  }

  getTokenProvider() async {
    prefs = await SharedPreferences.getInstance();
    if (prefs!.getString('token-provider') != null) {
      String? token = prefs!.getString('token-provider');
      return "Bearer ${token!}";
    } else {
      return null;
    }
  }

  removeSharedPreferenceData() async {
    prefs = await SharedPreferences.getInstance();
    prefs!.remove('is-user');
    prefs!.remove('is-user-provider');
    prefs!.remove('user-id');
    prefs!.remove('token');
    prefs!.remove('token-provider');
  }
}
