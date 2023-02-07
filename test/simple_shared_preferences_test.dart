import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
// ignore: depend_on_referenced_packages
import 'package:shared_preferences_platform_interface/shared_preferences_platform_interface.dart';

import 'package:simple_shared_preferences/simple_shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('SimpleSharedPreferences', () {
    const String testString = 'hello world';
    const bool testBool = true;
    const int testInt = 42;
    const double testDouble = 3.14159;
    const List<String> testList = <String>['foo', 'bar'];
    const Map<String, dynamic> testMap = <String, dynamic>{
      'foo': 'bar',
      'baz': 42,
    };
    final Map<String, Object> testReadingValues = <String, Object>{
      'flutter.String': testString,
      'flutter.bool': testBool,
      'flutter.int': testInt,
      'flutter.double': testDouble,
      'flutter.List': testList,
      'flutter.Map': jsonEncode(testMap),
    };

    const String testStringWriting = 'goodbye world';
    const bool testBoolWriting = false;
    const int testIntWriting = 1337;
    const double testDoubleWriting = 2.71828;
    const List<String> testListWriting = <String>['baz', 'quox'];
    const Map<String, dynamic> testMapWriting = <String, dynamic>{
      'baz': 'quox',
      'foo': 1337,
    };

    late FakeSharedPreferencesStore store;
    late SimpleSharedPreferences preferences;
    late SharedPreferences sharedPreferences;

    setUp(() async {
      store = FakeSharedPreferencesStore(testReadingValues);
      SharedPreferencesStorePlatform.instance = store;
      preferences = await SimpleSharedPreferences.getInstance();
      sharedPreferences = await SharedPreferences.getInstance();
      store.log.clear();
    });

    test('reading', () async {
      expect(preferences.getValue<String>('String'), testString);
      expect(preferences.getValue<bool>('bool'), testBool);
      expect(preferences.getValue<int>('int'), testInt);
      expect(preferences.getValue<double>('double'), testDouble);
      expect(preferences.getValue<List<String>>('List'), testList);
      expect(preferences.getValue<Map<String, dynamic>>('Map'), testMap);
      expect(store.log, <Matcher>[]);
    });

    test('writing', () async {
      await preferences.setValue<String>('String', testStringWriting);
      await preferences.setValue<bool>('bool', testBoolWriting);
      await preferences.setValue<int>('int', testIntWriting);
      await preferences.setValue<double>('double', testDoubleWriting);
      await preferences.setValue<List<String>>('List', testListWriting);
      await preferences.setValue<Map<String, dynamic>>('Map', testMapWriting);

      expect(sharedPreferences.getString('String'), testStringWriting);
      expect(sharedPreferences.getBool('bool'), testBoolWriting);
      expect(sharedPreferences.getInt('int'), testIntWriting);
      expect(sharedPreferences.getDouble('double'), testDoubleWriting);
      expect(sharedPreferences.getStringList('List'), testListWriting);
      expect(sharedPreferences.getString('Map'), jsonEncode(testMapWriting));
    });
  });
}

class FakeSharedPreferencesStore implements SharedPreferencesStorePlatform {
  FakeSharedPreferencesStore(Map<String, Object> data)
      : backend = InMemorySharedPreferencesStore.withData(data);

  final InMemorySharedPreferencesStore backend;
  final List<MethodCall> log = <MethodCall>[];

  @override
  bool get isMock => true;

  @override
  Future<bool> clear() {
    log.add(const MethodCall('clear'));
    return backend.clear();
  }

  @override
  Future<Map<String, Object>> getAll() {
    log.add(const MethodCall('getAll'));
    return backend.getAll();
  }

  @override
  Future<bool> remove(String key) {
    log.add(MethodCall('remove', key));
    return backend.remove(key);
  }

  @override
  Future<bool> setValue(String valueType, String key, Object value) {
    log.add(MethodCall('setValue', <dynamic>[valueType, key, value]));
    return backend.setValue(valueType, key, value);
  }
}
