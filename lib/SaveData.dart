import 'package:shared_preferences/shared_preferences.dart';

class SaveData
{
  storeString(String key,String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

  Future<String?> getSavedString(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? stringValue = prefs.getString(key);
    return stringValue;
  }

  Future<bool> checkValue(String key) async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool CheckValue = prefs.containsKey(key);
    return CheckValue;
  }

  Future<bool> clearData() async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.clear();
  }

}