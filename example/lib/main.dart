import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_thailand_provinces/flutter_thailand_provinces.dart';
import 'package:flutter_thailand_provinces_example/screens/amphures_list_screen.dart';
import 'package:flutter_thailand_provinces_example/screens/home_screen.dart';
import 'package:flutter_thailand_provinces_example/screens/provinces_list_screen.dart';
import 'package:flutter_thailand_provinces/provider/address_provider.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ThailandProvincesDatabase.init();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: HomeScreen());
  }
}
