import 'package:shared_preferences/shared_preferences.dart';

/// Returns SharedPref Instance
Future<SharedPreferences> getSharedPref() async {
  return await SharedPreferences.getInstance();
}

/// add a String in SharedPref
Future<void> setString(String key, String value) async {
  await getSharedPref().then((pref) {
    pref.setString(key, value);
  });
}

/// add a Int in SharedPref
Future<void> setInt(String key, int value) async {
  await getSharedPref().then((pref) {
    pref.setInt(key, value);
  });
}

/// add a Bool in SharedPref
Future<void> setBool(String key, bool value) async {
  await getSharedPref().then((pref) {
    pref.setBool(key, value);
  });
}

/// add a Double in SharedPref
Future<void> setDouble(String key, double value) async {
  await getSharedPref().then((pref) {
    pref.setDouble(key, value);
  });
}

/// Returns a String if exists in SharedPref
Future<String> getString(String key, {defaultValue = ''}) async {
  return await getSharedPref().then((pref) {
    return pref.getString(key) ?? defaultValue;
  });
}

/// Returns a Int if exists in SharedPref
Future<int> getInt(String key, {defaultValue = 0}) async {
  return await getSharedPref().then((pref) {
    return pref.getInt(key) ?? defaultValue;
  });
}

/// Returns a Double if exists in SharedPref
Future<double> getDouble(String key, {defaultValue = 0.0}) async {
  return await getSharedPref().then((pref) {
    return pref.getDouble(key) ?? defaultValue;
  });
}

/// Returns a Bool if exists in SharedPref
Future<bool> getBool(String key, {defaultValue = false}) async {
  return await getSharedPref().then((pref) {
    return pref.getBool(key) ?? defaultValue;
  });
}

/// remove key from SharedPref
Future<bool> removeKey(String key) async {
  return await getSharedPref().then((pref) {
    return pref.remove(key);
  });
}

/// clear SharedPref
Future<bool> clearSharedPref() async {
  return await getSharedPref().then((pref) {
    return pref.clear();
  });
}
