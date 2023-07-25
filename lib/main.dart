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
        useMaterial3: false,
      ),
      home: MultiProvider(
          providers: [
        ChangeNotifierProvider(
          create: (context) => Counter(),
        ),
        // ChangeNotifierProxyProvider<Counter, X100>(
        //   create: (context) => X100(),
        //   update: (context, counterProvider, x100Provider) => x100Provider!..multiply(counterProvider),
        //
        // ),
        ProxyProvider<Counter, X100>(
          create: (context) => X100(),
          update: (context, counterProvider, x100Provider) => x100Provider!..multiply(counterProvider),
          updateShouldNotify: (previous, current) => true,
        ),
      ], child: const MyHomePage()),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
              'You have pushed the button this many times:',
            ),
            Consumer<Counter>(
              builder: (BuildContext context, value, Widget? child) {
                return  Text(
                  '${value.counter}',
                  style: Theme.of(context).textTheme.headlineMedium,
                );
              },
              child: const Text('hello'),
            ),
            const SizedBox(
              height: 20,
            ),
            Consumer<X100>(
              builder: (BuildContext context, value, Widget? child) {
                return Text(
                  '${value.counterMultiply}',
                  style: Theme.of(context).textTheme.headlineMedium,
                );
              },
              child: const Text('hello'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<Counter>().increment();
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class Counter extends ChangeNotifier {
  int counter = 0;

  increment() {
    counter++;
    notifyListeners();
  }
}

// class X100 extends ChangeNotifier{
//   int counterMultiply = 0;
//
//   void multiply(Counter counter) {
//     counterMultiply = counter.counter * 100;
//     notifyListeners();
//   }
//
// }

class X100 {
  int counterMultiply = 0;
  int x = 0;
  int x10 = 10;
  int x100 = 100;

  void multiply(Counter counter) {
    counterMultiply = counter.counter * 100;
  }

}

