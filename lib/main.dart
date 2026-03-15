import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app/app.dart';
import 'app/bindings/initial_binding.dart';

void main() {
  runApp(
    MultiProvider(
      providers: InitialBinding.dependencies,
      child: const MyApp(),
    ),
  );
}
