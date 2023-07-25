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
          ChangeNotifierProvider<MultiplyBy>.value(
            value: MultiplyBy(),
          ),
          ChangeNotifierProvider<X>.value(
            value: X(),
          ),
          ChangeNotifierProvider<X10>(
            create: (context) => X10(),
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

            Selector2<MultiplyBy,X,List<int>>(
              selector: (context, multiplyBy, x) {
                print('selector 2 running');
                return [multiplyBy.x2,x.counter];
              },
              builder: (context, value, child) {
              print('selector 2 builder');
              return    Text('Counter : ${value[0]},X :  ${value[1]} \n\n');
            }, ),


            Selector<MultiplyBy, int>(
              builder: (context, value, child) {
                print('selector builder');
                return Column(
                  children: [
                    child!,
                    Text('$value'),
                  ],
                );
              },
              selector: (context, x) => x.x2,
              // shouldRebuild: (previous, next) => previous != next,
              child : Selector<X, int>(
                  builder: (context, value, child) {
                    print('Counter X builder');
                    return Text('Counter : $value');
                  },
                  selector: (context, x) => x.counter,
                  // shouldRebuild: (previous, next) => previous != next,
                )
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // context.read<MultiplyBy>().increment();
          context.read<X>().increment();
          // context.read<X10>().increment();
          // context.read<X20>().increment();
          // context.read<X30>().increment();
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
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

  void increment() {
    counter * 10;
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

  void increment() {
    counter = counter * 30;
    notifyListeners();
  }
}
