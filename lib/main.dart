import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    // ProviderScope obligatoire pour initialiser Riverpod
    const ProviderScope(
      child: EcommerceApp(),
    ),
  );
}
