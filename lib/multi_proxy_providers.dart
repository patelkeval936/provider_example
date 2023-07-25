import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
          ChangeNotifierProvider<X>(create: (_) => X()),
          ChangeNotifierProvider<X10>(create: (context) => X10()),
          ChangeNotifierProxyProvider2<X, X10, X30>(
            create: (_) => X30(),
            update: (_, xProvider, x10Provider, x30Provider) {
              return x30Provider!..increment(xProvider.counter);
            },
          ),
          // ChangeNotifierProxyProvider<X,X10>(
          //   create: (context) => X10(),
          //   update: (context, value, previous) {
          //   print('x is ${value.counter} x10 is ${previous?.counter}');
          //   return X10();
          // },
          // )
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
            Consumer<X>(
              builder: (context, value, child) {
                return Text('${value.counter}');
              },
            ),
            Consumer<X10>(
              builder: (context, value, child) {
                return Text('${value.counter}');
              },
            ),
            Consumer<X30>(
              builder: (context, value, child) {
                return Text('${value.counter}');
              },
            )
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          FloatingActionButton(
            onPressed: () {
              context.read<X>().increment();
              // context.read<X10>().increment();
              // context.read<X20>().increment();
              // context.read<X30>().increment();
            },
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),

          FloatingActionButton(
            onPressed: () {
              // context.read<X>().increment();
              context.read<X10>().increment();
              // context.read<X20>().increment();
              // context.read<X30>().increment();
            },
            tooltip: 'Increment',
            child: const Icon(Icons.one_k),
          ),
        ],
      ),
    );
  }
}

class MultiplyBy extends ChangeNotifier {
  int x2 = 1;
  int x3 = 1;
  int x4 = 1;
  int x5 = 1;

  void increment() {
    x2 *= 2;
    x3 *= 3;
    x4 *= 4;
    x5 *= 5;
    notifyListeners();
  }
}

class X extends ChangeNotifier {
  int counter = 1;

  void increment() {
    counter++;
    notifyListeners();
  }
}

class X10 extends ChangeNotifier {
  int counter = 1;

  void update(int value) {
    counter = value * 10;
    notifyListeners();
  }

  void increment() {
    counter = counter * 10;
    notifyListeners();
  }
}

class X20 extends ValueNotifier {
  X20(super.value);

  void increment() {
    value = value * 20;
    notifyListeners();
  }
}

class X30 extends ChangeNotifier {
  int counter = 1;

  void increment(int value) {
    print('called');
    print(value);
    counter = value * 30;
    notifyListeners();
  }

  void plus1(int value) {
    counter = value + 1;
    notifyListeners();
  }

  void plus2(int value) {
    counter = value  + 2;
    notifyListeners();
  }
}
