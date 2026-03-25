import 'package:flutter/material.dart';
import 'theme.dart';
import '../features/home/home_screen.dart';

class PaeGoApp extends StatefulWidget {
  const PaeGoApp({super.key});

  @override
  State<PaeGoApp> createState() => _PaeGoAppState();
}

class _PaeGoAppState extends State<PaeGoApp> {
  ThemeMode _themeMode = ThemeMode.light;

  void _toggleTheme() {
    setState(() {
      _themeMode =
          _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PAEGo',
      debugShowCheckedModeBanner: false,
      theme: buildPaeGoLightTheme(),
      darkTheme: buildPaeGoDarkTheme(),
      themeMode: _themeMode,
      home: HomeScreen(onToggleTheme: _toggleTheme),
    );
  }
}
