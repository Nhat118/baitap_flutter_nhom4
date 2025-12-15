import 'package:flutter/material.dart';
import 'package:flutter_baitap_nhom4/NgoQuyLongNhat.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isDark = false;

  void _toggleTheme() {
    setState(() => _isDark = !_isDark);
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData light = ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
    );

    final ThemeData dark = ThemeData.dark().copyWith(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple, brightness: Brightness.dark),
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: light,
      darkTheme: dark,
      themeMode: _isDark ? ThemeMode.dark : ThemeMode.light,
      home: Ngoquylongnhat(isDark: _isDark, onToggleTheme: _toggleTheme),
    );
  }
}