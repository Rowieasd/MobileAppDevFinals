import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testappesoleva/screens/auth/signinpage.dart';
import 'providers/cart_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(create: (_) => CartProvider(), child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SigninScreen(), // ✅ KEEP THIS
    );
  }
}
