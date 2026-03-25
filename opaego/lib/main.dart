import 'package:flutter/material.dart';
import 'app/app.dart';
import 'data/database_helper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Inicializa la base de datos al arrancar
  await DatabaseHelper.instance.database;
  runApp(const PaeGoApp());
}
