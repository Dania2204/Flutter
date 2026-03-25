import 'package:flutter/material.dart';
import '../../app/theme.dart';
import '../home/home_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({
    super.key,
    required this.role,
    required this.onToggleTheme,
  });

  final UserRole role;
  final VoidCallback onToggleTheme;

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(_roleLabel(role)),
            const Text('Panel principal', style: TextStyle(fontSize: 12)),
          ],
        ),
        actions: [
          IconButton(
            onPressed: onToggleTheme,
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
              // Encabezado de bienvenida
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: [
                      Icon(_roleIcon(role), size: 48, color: PaeGoColors.skyDeep),
                      const SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Bienvenido',
                              style: Theme.of(context).textTheme.labelMedium),
                          Text(_roleLabel(role),
                              style: Theme.of(context).textTheme.titleLarge),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              Text('Módulos disponibles',
                  style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 12),

              // Opciones según rol
              ..._menuItems(role).map(
                (item) => Card(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: ListTile(
                    leading: Icon(item.icon, color: PaeGoColors.skyDeep),
                    title: Text(item.label),
                    subtitle: Text(item.description),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('${item.label} — próximamente')),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<_MenuItem> _menuItems(UserRole role) {
    switch (role) {
      case UserRole.superAdmin:
        return [
          _MenuItem(Icons.map,            'Mapa en tiempo real',   'Ver todos los vehículos activos'),
          _MenuItem(Icons.list_alt,       'Órdenes',               'Gestionar todas las entregas'),
          _MenuItem(Icons.people,         'Usuarios',              'Administrar conductores y rectores'),
          _MenuItem(Icons.bar_chart,      'Reportes',              'Estadísticas del sistema'),
        ];
      case UserRole.admin:
        return [
          _MenuItem(Icons.map,            'Mapa',                  'Ver vehículos de su municipio'),
          _MenuItem(Icons.list_alt,       'Órdenes',               'Gestionar entregas asignadas'),
          _MenuItem(Icons.people,         'Conductores',           'Ver conductores disponibles'),
        ];
      case UserRole.rector:
        return [
          _MenuItem(Icons.local_shipping, 'Mi entrega',            'Ver estado de la entrega de hoy'),
          _MenuItem(Icons.history,        'Historial',             'Entregas anteriores'),
        ];
      case UserRole.conductor:
        return [
          _MenuItem(Icons.search,         'Órdenes disponibles',   'Ver entregas sin asignar'),
          _MenuItem(Icons.route,          'Mi ruta activa',        'Continuar ruta en curso'),
          _MenuItem(Icons.history,        'Mis entregas',          'Historial personal'),
        ];
    }
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

class _MenuItem {
  const _MenuItem(this.icon, this.label, this.description);
  final IconData icon;
  final String label;
  final String description;
}
