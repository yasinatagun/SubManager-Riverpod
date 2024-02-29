import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<String?> getString(String key) async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getString(key);
  }

  Future<void> setString(String key, String value) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setString(key, value);
  }
// In SharedPreferencesService
Future<void> saveUserEmail(String email) async {
  await setString('userEmail', email);
}

Future<String?> getUserEmail() async {
  return getString('userEmail');
}
  // Add other methods for different data types as needed (getInt, setInt, etc.)
}