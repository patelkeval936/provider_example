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
          ChangeNotifierProvider<X>.value(value: X(),),
          ChangeNotifierProvider<X10>(create: (context) => X10(),),
          ChangeNotifierProvider<X20>(create: (context) => X20(10),),
          ListenableProvider<X30>(create: (context) => X30(),),
        ],
        child : const MyHomePage(),
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
            Consumer2<X,X10>(
              builder: (context, value, value2, child) {
              return Text(
                'X : ${value.counter}\n'
                    'X10 : ${value2.counter}\n',
                style: Theme.of(context).textTheme.headlineMedium,
              );
            },),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<X>().increment();
          context.read<X10>().increment();
          context.read<X20>().increment();
          context.read<X30>().increment();
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

  void increment(){
    x2*=2;
    x3*=3;
    x4*=4;
    x5*=5;
    notifyListeners();
  }

}

class X extends ChangeNotifier {
  int counter = 1;

  void increment(){
    counter++;
    notifyListeners();
  }

}


class X10 extends ChangeNotifier {
  int counter = 1;

  void increment(){
    counter = counter * 10;
    notifyListeners();
  }
}

class X20 extends ValueNotifier {

  X20(super.value);

  void increment(){
    value = value * 20;
    notifyListeners();
  }
}

class X30 extends ChangeNotifier {
  int counter = 1;

  void increment(){
    counter = counter * 30;
    notifyListeners();
  }
}
