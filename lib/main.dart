import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_fashion/Screen/Home.dart';
import 'package:open_fashion/bloc/cart_bloc.dart';

void main() {
  runApp(OpenFashionApp());
}

class OpenFashionApp extends StatelessWidget {
  const OpenFashionApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CartBloc(), // Replace with your Bloc class
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomePage(),
      ),
    );
  }
}

// Optional: Bloc Observer for debugging
class AppBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    debugPrint('${bloc.runtimeType} changed: $change');
  }
}
