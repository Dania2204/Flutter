import 'package:flutter/material.dart';
import '../../app/theme.dart';
import '../dashboard/dashboard_screen.dart';

enum UserRole { superAdmin, admin, rector, conductor }

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.onToggleTheme});

  final VoidCallback onToggleTheme;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  UserRole _role = UserRole.superAdmin;

  String get _roleDescription {
    switch (_role) {
      case UserRole.superAdmin:
        return 'Acceso total. Puede ver y gestionar todo el sistema PAE.';
      case UserRole.admin:
        return 'Gestiona entregas y conductores de su municipio.';
      case UserRole.rector:
        return 'Consulta el estado de las entregas de su colegio.';
      case UserRole.conductor:
        return 'Toma órdenes disponibles e inicia rutas de entrega.';
    }
  }

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('PAEGo'),
            Text('Programa de Alimentación Escolar',
                style: TextStyle(fontSize: 12)),
          ],
        ),
        actions: [
          IconButton(
            onPressed: widget.onToggleTheme,
            icon: Icon(dark ? Icons.light_mode : Icons.dark_mode),
            tooltip: 'Cambiar tema',
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Selecciona tu rol',
                  style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),

              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: UserRole.values.map((role) {
                  return ChoiceChip(
                    label: Text(_roleLabel(role)),
                    selected: _role == role,
                    onSelected: (_) => setState(() => _role = role),
                    avatar: Icon(
                      _roleIcon(role),
                      size: 18,
                      color: _role == role ? PaeGoColors.skyDeep : Colors.grey,
                    ),
                  );
                }).toList(),
              ),

              const SizedBox(height: 24),

              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: [
                      Icon(_roleIcon(_role), size: 40, color: PaeGoColors.skyDeep),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(_roleLabel(_role),
                                style: Theme.of(context).textTheme.titleMedium),
                            const SizedBox(height: 6),
                            Text(_roleDescription),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const Spacer(),

              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => DashboardScreen(
                          role: _role,
                          onToggleTheme: widget.onToggleTheme,
                        ),
                      ),
                    );
                  },
                  icon: const Icon(Icons.arrow_forward),
                  label: const Text('Continuar'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _roleLabel(UserRole role) {
    switch (role) {
      case UserRole.superAdmin: return 'Super Admin';
      case UserRole.admin:      return 'Admin';
      case UserRole.rector:     return 'Rector';
      case UserRole.conductor:  return 'Conductor';
    }
  }

  IconData _roleIcon(UserRole role) {
    switch (role) {
      case UserRole.superAdmin: return Icons.admin_panel_settings;
      case UserRole.admin:      return Icons.manage_accounts;
      case UserRole.rector:     return Icons.school;
      case UserRole.conductor:  return Icons.local_shipping;
    }
  }
}
