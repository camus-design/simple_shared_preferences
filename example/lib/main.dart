import 'package:flutter/material.dart';
import 'package:simple_shared_preferences/simple_shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SimpleSharedPreferences Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SimpleSharedPreferencesDemo(
        title: 'SimpleSharedPreferences Demo Page',
      ),
    );
  }
}

class SimpleSharedPreferencesDemo extends StatefulWidget {
  const SimpleSharedPreferencesDemo({
    required this.title,
    Key? key,
  }) : super(key: key);

  final String title;

  @override
  State<SimpleSharedPreferencesDemo> createState() =>
      _SimpleSharedPreferencesDemoState();
}

class _SimpleSharedPreferencesDemoState
    extends State<SimpleSharedPreferencesDemo> {
  final Future<SimpleSharedPreferences> _preferences =
      SimpleSharedPreferences.getInstance();
  late Future<int> _counter;

  Future<void> _incrementCounter() async {
    final SimpleSharedPreferences preferences = await _preferences;
    final int counter = (preferences.get('counter') ?? 0) + 1;

    setState(() {
      _counter = preferences.set('counter', counter).then((_) => counter);
    });
  }

  @override
  void initState() {
    super.initState();
    _counter = _preferences.then((SimpleSharedPreferences preferences) {
      return preferences.get('counter') ?? 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: FutureBuilder<int>(
          future: _counter,
          builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return const CircularProgressIndicator();
              case ConnectionState.active:
              case ConnectionState.done:
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }
                return Text(
                  'You have pushed the button this many times: ${snapshot.data}',
                  style: Theme.of(context).textTheme.headline4,
                );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
