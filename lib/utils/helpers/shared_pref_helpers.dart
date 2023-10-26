import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsHelpers {
  SharedPrefsHelpers._();

  // -------------------- String values handler --------------------- //
  static setStringValuesSF(key, val) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, val);
  }

  static getStringValuesSF(key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String stringValue = prefs.getString(key) ?? "";
    return stringValue;
  }

  // -------------------- boolean value handler --------------------- //
  static setBooleanValuesSF(key, val) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(key, val);
  }

  static getBoolValuesSF(key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool boolValue = prefs.getBool(key) ?? false;
    return boolValue;
  }

  // -------------------- Integer value handler --------------------- //
  static setIntegerValuesSF(key, val) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(key, val);
  }

  static getIntValuesSF(key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int intValue = prefs.getInt(key) ?? 0;
    return intValue;
  }

  static removeSF(key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }

  static clearSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}
