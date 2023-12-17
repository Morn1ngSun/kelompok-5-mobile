import 'package:app_kepin/brake.dart';
import 'package:app_kepin/dashboard.dart';
import 'package:app_kepin/exhaust.dart';
import 'package:app_kepin/history.dart';
import 'package:app_kepin/login.dart';
import 'package:app_kepin/product.dart';
import 'package:app_kepin/registration.dart';
import 'package:app_kepin/suspension.dart';
import 'package:app_kepin/tire.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginPage(),
        '/regis': (context) => RegistrationPage(),
        '/dashboard': (context) => DashboardPage(),
        '/susp': (context) => SuspensionPage(),
        '/tire': (context) => TirePage(),
        '/brake': (context) => BrakePage(),
        '/exh': (context) => ExhaustPage(),
        '/product': (context) => ProductPage(),
        '/hist': (context) => HistoryPage(),
        // '/detail': (context) => DetailProductPage(),
      },
    );
  }
}
