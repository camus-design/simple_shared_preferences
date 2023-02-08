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

final simplePreference = await SimpleSharedPreferences.getInstance();

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
final simplePreference = await SimpleSharedPreferences.getInstance();

// Save an integer value to 'counter' key.
await simplePreference.setValue<int>('counter', 10);
// Save an boolean value to 'repeat' key.
await simplePreference.setValue<bool>('repeat', true);
// Save an double value to 'decimal' key.
await simplePreference.setValue<double>('decimal', 1.5);
// Save an String value to 'action' key.
await simplePreference.setValue<String>('action', 'Start');
// Save an list of strings to 'items' key.
await simplePreference.setValue<List<String>>('items', <String>['Earth', 'Moon', 'Sun']);

// Save an map - simple preference
await simplePreference.setValue<Map<String, dynamic>>('map', <String, dynamic>{
  'name': 'simple shared preferences',
  'age': 1,
  'isDeveloper': true,
  'height': 1.75,
  'list': [1, 2, 3],
});
```

#### Read data

```dart
// Try reading data from the 'counter' key. If it doesn't exist, returns null.
final int? counter = simplePreference.getValue<int>('counter');
// Try reading data from the 'repeat' key. If it doesn't exist, returns null.
final bool? repeat = simplePreference.getValue<bool>('repeat');
// Try reading data from the 'decimal' key. If it doesn't exist, returns null.
final double? decimal = simplePreference.getValue<double>('decimal');
// Try reading data from the 'action' key. If it doesn't exist, returns null.
final String? action = simplePreference.getValue<String>('action');
// Try reading data from the 'items' key. If it doesn't exist, returns null.
final List<String>? items = simplePreference.getValue<List<String>>('items');

// Try reading data from the 'map' key. If it doesn't exist, returns null
final Map<String, dynamic>? map = simplePreference.getValue<Map<String, dynamic>>('map');
```

#### Remove an entry

```dart
// Remove data for the 'counter' key.
final success = await simplePreference.remove('counter');
```
