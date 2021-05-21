import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsUtil {
  // Keys
  static const String favorites = 'favorites';

  // Function to save data
  Future<void> set(String key, value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    if (value is bool) {
      sharedPreferences.setBool(key, value);
    } else if (value is String) {
      sharedPreferences.setString(key, value);
    } else if (value is double) {
      sharedPreferences.setDouble(key, value);
    } else if (value is int) {
      sharedPreferences.setInt(key, value);
    } else if (value is List<String>) {
      sharedPreferences.setStringList(key, value);
    }
  }

  // Function to load data
  Future<dynamic> get(String key, {dynamic defaultValue}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return await sharedPreferences.get(key) ?? defaultValue;
  }

  Future<void> setFavorite(String value) async {
    List<String> userFav = await getFavorites() ?? <String>[];
    userFav.add(value);
    return await set(favorites, userFav);
  }

  Future<List<String>> getFavorites() async {
    List<dynamic> data = await get(favorites, defaultValue: <String>[]);

    return data.map((e) => e.toString()).toList();
  }

  Future<void> removeFavorite(String value) async {
    List<String> userFav = await getFavorites() ?? <String>[];
    userFav.remove(value);
    return await set(favorites, userFav);
  }
}
