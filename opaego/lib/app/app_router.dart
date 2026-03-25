import 'package:flutter/material.dart';
import '../features/home/home_screen.dart';
import '../features/dashboard/dashboard_screen.dart';

enum UserRole { superAdmin, admin, rector, conductor }

class AppRouter {
  static const String home      = '/';
  static const String dashboard = '/dashboard';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(
          builder: (_) => const _HomeWrapper(),
        );
      case dashboard:
        final role = settings.arguments as UserRole;
        return MaterialPageRoute(
          builder: (_) => DashboardScreen(role: role),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => const _NotFoundScreen(),
        );
    }
  }
}

// Wrapper para inyectar el toggle de tema desde el árbol
class _HomeWrapper extends StatelessWidget {
  const _HomeWrapper();

  @override
  Widget build(BuildContext context) {
    // El toggle llega por el callback registrado en app.dart
    return const SizedBox.shrink(); // reemplazado en app.dart
  }
}

class _NotFoundScreen extends StatelessWidget {
  const _NotFoundScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Página no encontrada')),
      body: const Center(child: Text('Ruta no existe')),
    );
  }
}
