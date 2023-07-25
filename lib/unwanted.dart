import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext myAppPosition) {
    return MaterialApp(
        title: 'Provider',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const HomePage());
  }
}

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext homepagePositon) {
    return ChangeNotifierProvider<X>(
      create: (_) => X(),
      child: Scaffold(
        body: Builder(
          builder: (builderPosition) {
            return Text(Provider.of<X>(builderPosition,listen: true).counter.toString());
          }
        ),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            FloatingActionButton(
              onPressed: () {
                homepagePositon.read<X>().increment();
              },
              tooltip: 'Increment',
              child: const Icon(Icons.add),
            ),
          ],
        ),
      ),
    );
  }
}

class X extends ChangeNotifier {
  int counter = 1;

  void increment() {
    counter++;
    notifyListeners();
  }
}
