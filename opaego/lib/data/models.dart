// ─── Rol del usuario ───────────────────────────────────────────────────────
enum UserRole { superAdmin, admin, rector, conductor }

extension UserRoleX on UserRole {
  String get label {
    switch (this) {
      case UserRole.superAdmin: return 'Super Admin';
      case UserRole.admin:      return 'Admin';
      case UserRole.rector:     return 'Rector';
      case UserRole.conductor:  return 'Conductor';
    }
  }

  static UserRole fromString(String value) {
    return UserRole.values.firstWhere((e) => e.name == value);
  }
}

// ─── Personal (conductor, admin, rector, etc.) ─────────────────────────────
class Personal {
  Personal({
    this.id,
    required this.nombre,
    required this.apellido,
    required this.cedula,
    required this.telefono,
    required this.rol,
  });

  final int? id;
  final String nombre;
  final String apellido;
  final String cedula;
  final String telefono;
  final UserRole rol;

  String get nombreCompleto => '$nombre $apellido';

  Map<String, dynamic> toMap() => {
    if (id != null) 'id': id,
    'nombre':   nombre,
    'apellido': apellido,
    'cedula':   cedula,
    'telefono': telefono,
    'rol':      rol.name,
  };

  factory Personal.fromMap(Map<String, dynamic> map) => Personal(
    id:       map['id'] as int?,
    nombre:   map['nombre'] as String,
    apellido: map['apellido'] as String,
    cedula:   map['cedula'] as String,
    telefono: map['telefono'] as String,
    rol:      UserRoleX.fromString(map['rol'] as String),
  );

  Personal copyWith({
    int? id,
    String? nombre,
    String? apellido,
    String? cedula,
    String? telefono,
    UserRole? rol,
  }) =>
      Personal(
        id:       id       ?? this.id,
        nombre:   nombre   ?? this.nombre,
        apellido: apellido ?? this.apellido,
        cedula:   cedula   ?? this.cedula,
        telefono: telefono ?? this.telefono,
        rol:      rol      ?? this.rol,
      );
}
