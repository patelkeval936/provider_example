
import 'package:flutter/material.dart';

class Example extends InheritedWidget {
  const Example({
    super.key,
    required Widget child,
  }) : super(child: child);

  static Example of(BuildContext context) {
    final Example? result = context.dependOnInheritedWidgetOfExactType<Example>();
    assert(result != null, 'No Example found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(Example old) {
    return true;
  }
}
