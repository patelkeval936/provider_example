import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
   const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return Provider<Counter>(
      create : (context) => Counter(),
      child: MaterialApp(
        title: 'Provider',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: MyHomePage(),
      ),
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
              'You have pushed the button this many times : ',
            ),
            Consumer<Counter>(
              builder: (BuildContext context, value, Widget? child) {
                print('--------------${value.counter}');
                return Text(
                  '${value.counter}',
                  style: Theme.of(context).textTheme.headlineMedium,
                );
              },
              child: const Text('hello'),
            ),
            Consumer<Counter>(
              builder: (_, value, child) {
                return Text('${context.read<Counter>().counter}');
              },)
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

class Counter extends ChangeNotifier{
  int counter = 0;

  increment() {
    counter++;
    notifyListeners();
    print(counter);
  }
}
