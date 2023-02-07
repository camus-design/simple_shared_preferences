# Simple Shared Preferences

[![pub package](https://img.shields.io/pub/v/simple_shared_preferences.svg)](https://pub.dev/packages/simple_shared_preferences)

A simple wrapper for [SharedPreferences](https://pub.dev/packages/shared_preferences)

Supported data types are `int`, `double`, `bool`, `String` and `List<String>`.

|             | Android | iOS  | Linux | macOS  | Web | Windows     |
|-------------|---------|------|-------|--------|-----|-------------|
| **Support** | SDK 16+ | 9.0+ | Any   | 10.11+ | Any | Any         |

## Usage

To use this package, add `simple_shared_preferences` as a dependency in your pubspec.yaml file.

### Examples

Here are small examples that show you how to use the API.

```dart
import 'package:simple_shared_preferences/simple_shared_preferences.dart';

final simplePreference = await SimpleSharedPreferences().getInstance();

await simplePreference.set('name': 'simple shared preferences');
await simplePreference.set('age': 1);
await simplePreference.set('isDeveloper': true);
await simplePreference.set('height': 1.75);
await simplePreference.set('list': [1, 2, 3]);
await simplePreference.set('map': {'name': 'simple shared preferences'});

final String name = simplePreference.get('name');
final int age = simplePreference.get('age');
final bool isDeveloper = simplePreference.get('isDeveloper');
final double height = simplePreference.get('height');
final List<int> list = simplePreference.get('list');
final Map<String, dynamic> map = simplePreference.get('map');
```

### Use like SharedPreferences

[SharedPreferences Doc](https://pub.dev/packages/shared_preferences)

#### Write data

```dart
// Obtain shared preferences.
final prefs = await SharedPreferences.getInstance();

// Save an integer value to 'counter' key.
await prefs.setInt('counter', 10);
// Save an boolean value to 'repeat' key.
await prefs.setBool('repeat', true);
// Save an double value to 'decimal' key.
await prefs.setDouble('decimal', 1.5);
// Save an String value to 'action' key.
await prefs.setString('action', 'Start');
// Save an list of strings to 'items' key.
await prefs.setStringList('items', <String>['Earth', 'Moon', 'Sun']);
```

#### Read data

```dart
// Try reading data from the 'counter' key. If it doesn't exist, returns null.
final int? counter = prefs.getInt('counter');
// Try reading data from the 'repeat' key. If it doesn't exist, returns null.
final bool? repeat = prefs.getBool('repeat');
// Try reading data from the 'decimal' key. If it doesn't exist, returns null.
final double? decimal = prefs.getDouble('decimal');
// Try reading data from the 'action' key. If it doesn't exist, returns null.
final String? action = prefs.getString('action');
// Try reading data from the 'items' key. If it doesn't exist, returns null.
final List<String>? items = prefs.getStringList('items');
```

#### Remove an entry

```dart
// Remove data for the 'counter' key.
final success = await prefs.remove('counter');
```
