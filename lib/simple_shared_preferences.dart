library simple_shared_preferences;

import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

/// A simple wrapper for [SharedPreferences] that supports
/// string, int, double, bool, List<String>, and Map<String, dynamic> types.
class SimpleSharedPreferences {
  /// Returns the [SimpleSharedPreferences] instance.
  /// Call getInstance() first.
  factory SimpleSharedPreferences() {
    if (_singleton == null) {
      throw Exception(
          'SimpleSharedPreferences is not initialized, call getInstance() first');
    }

    return _singleton!;
  }
  SimpleSharedPreferences._internal(this._sp);

  /// Loads and parses the [SharedPreferences] for this app from disk.
  ///
  /// Because this is reading from disk, it shouldn't be awaited in
  /// performance-sensitive blocks.
  static Future<SimpleSharedPreferences> getInstance() async {
    if (_singleton == null) {
      final SharedPreferences sp = await SharedPreferences.getInstance();
      _singleton = SimpleSharedPreferences._internal(sp);
    }
    return _singleton!;
  }

  final SharedPreferences? _sp;
  static SimpleSharedPreferences? _singleton;

  /// Saves a string, int, double, bool, List<String>, or Map<String, dynamic> [value] to persistent storage in the background.
  Future<bool> setValue<T>(String key, T value) async {
    if (value is String) {
      return await _sp!.setString(key, value);
    }
    if (value is int) {
      return await _sp!.setInt(key, value);
    }
    if (value is double) {
      return await _sp!.setDouble(key, value);
    }
    if (value is bool) {
      return await _sp!.setBool(key, value);
    }
    if (value is List<String>) {
      return await _sp!.setStringList(key, value);
    }
    if (value is Map<String, dynamic>) {
      final String jsonString = jsonEncode(value);
      return await _sp!.setString(key, jsonString);
    }
    throw Exception('Unsupported type');
  }

  /// Saves a Data [value] to persistent storage in the background.
  ///  This is a convenience method for [setValue].
  Future<bool> set(String key, Object value) async {
    final String jsonString = jsonEncode(value);
    return await _sp!.setString(key, jsonString);
  }

  /// Reads a value from persistent storage
  T getValue<T>(String key) {
    if (T == String) {
      return _sp!.getString(key) as T;
    }
    if (T == int) {
      return _sp!.getInt(key) as T;
    }
    if (T == double) {
      return _sp!.getDouble(key) as T;
    }
    if (T == bool) {
      return _sp!.getBool(key) as T;
    }
    if (T == List<String>) {
      return _sp!.getStringList(key) as T;
    }
    if (T == Map<String, dynamic>) {
      final String? jsonString = _sp!.getString(key);
      if (jsonString == null) {
        return <String, dynamic>{} as T;
      }
      return jsonDecode(jsonString) as T;
    }

    throw Exception('Unsupported type');
  }

  /// Reads a Data from persistent storage
  /// This is a convenience method for [getValue].
  dynamic get(String key) {
    final String? jsonString = _sp!.getString(key);
    if (jsonString == null) {
      return <String, dynamic>{};
    }
    return jsonDecode(jsonString);
  }

  /// Removes an entry from persistent storage.
  Future<bool> removeValue(String key) async {
    return await _sp!.remove(key);
  }

  /// Completes with true once the user preferences for the app has been cleared.
  Future<bool> clear() async {
    return await _sp!.clear();
  }

  /// Fetches the latest values from the host platform.
  ///
  /// Use this method to observe modifications that were made in native code
  /// (without using the plugin) while the app is running.
  Future<void> reload() async {
    await _sp!.reload();
  }
}
