import 'package:flutter/material.dart';

class BlocProvider extends InheritedWidget {
  BlocProvider({
    Key key,
    child,
  }) : super(key: key, child: child);

  static BlocProvider of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType(aspect: BlocProvider)
        as BlocProvider);
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;
}
