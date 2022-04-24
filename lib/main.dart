import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'dart:convert';
import 'API.dart' as API;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  String _resultget = '{"initial":true}';
  Map<String, dynamic> _data = {'initial': true};

  Future<void> _incrementCounter() async {
    setState(() {});

    try {
      _counter++;
      print('Contador atual + 1 = ' + _counter.toString());
      _resultget = await API.getInt(_counter);
      _data = json.decode(_resultget);
      if (_data.containsKey('api')) {
        print('Resposta GET: ');
        _data.values.forEach((value) {
          print('  => ' + value);
        });
      } else {
        print('No data.');
      }
    } catch (error, stackTrace) {
      print(error);
      print(stackTrace);
    }
  }

  Future<void> _zerarContator() async {
    setState(() {});

    try {
      _counter = 0;
      print('Contador zerado = ' + _counter.toString());
      _resultget = await API.getInt(_counter);
      print('Resposta GET = ' + _resultget);
    } catch (error, stackTrace) {
      print(error);
      print(stackTrace);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Contandor:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline5,
            ),
          ],
        ),
      ),
      floatingActionButton: SpeedDial(
        child: const Icon(Icons.add),
        children: <SpeedDialChild>[
          SpeedDialChild(
            child: const Icon(Icons.directions_run),
            foregroundColor: Colors.white,
            backgroundColor: Colors.red,
            label: '+ 1',
            onTap: _incrementCounter,
          ),
          SpeedDialChild(
            child: const Icon(Icons.directions_walk),
            foregroundColor: Colors.black,
            backgroundColor: Colors.yellow,
            label: 'Result GET',
            onTap: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('Alert Dialog Example'),
                      content: Text(_resultget),
                      actions: <Widget>[
                        ElevatedButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: Text('OK')),
                      ],
                    );
                  });
            },
          ),
          SpeedDialChild(
            child: const Icon(Icons.directions_bike),
            foregroundColor: Colors.white,
            backgroundColor: Colors.green,
            label: 'Zerar contator!',
            onTap: _zerarContator,
          ),
        ],
        foregroundColor: Colors.white,
        activeForegroundColor: Colors.blue,
        backgroundColor: Colors.blue,
        activeBackgroundColor: Colors.black,
      ),
    );
  }
}
