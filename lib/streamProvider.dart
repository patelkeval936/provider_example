import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Stream<CounterValue> getStream() {
    return Stream.periodic(Duration(seconds: 1), (computationCount) => CounterValue(computationCount));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Provider',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MultiProvider(
        providers: [

          // StreamProvider<CounterValue>(
          //   create: (context) => getStream(),
          //   initialData: CounterValue(0),
          //   // updateShouldNotify: (previous, current) => true,
          // ),

          FutureProvider<CounterValue>(
            create: (context) => Future.delayed(Duration(seconds: 3), () => CounterValue(100000)),
            initialData: CounterValue(0),
            // updateShouldNotify: (previous, current) => true,
          ),

        ],
        child: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Provider'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times : ',
            ),
            Consumer<CounterValue>(
              builder: (context, value, child) {
                return Text('${value.counter}');
              },
            ),
          ],
        ),
      ),
    );
  }
}

class CounterValue extends ChangeNotifier {
  int? counter;
  CounterValue(int value) {
    counter = value;
  }
}

class X extends ChangeNotifier {
  int counter = 1;

  void increment() {
    counter++;
    notifyListeners();
  }
}
