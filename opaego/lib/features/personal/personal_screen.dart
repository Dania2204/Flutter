import 'package:flutter/material.dart';
import '../../app/theme.dart';
import '../../data/models.dart';
import '../../data/database_helper.dart';

class PersonalScreen extends StatefulWidget {
  const PersonalScreen({super.key});

  @override
  State<PersonalScreen> createState() => _PersonalScreenState();
}

class _PersonalScreenState extends State<PersonalScreen> {
  final _db = DatabaseHelper.instance;
  List<Personal> _lista = [];
  bool _cargando = true;

  @override
  void initState() {
    super.initState();
    _cargarPersonal();
  }

  Future<void> _cargarPersonal() async {
    setState(() => _cargando = true);
    final lista = await _db.obtenerPersonal();
    setState(() {
      _lista = lista;
      _cargando = false;
    });
  }

  Future<void> _eliminar(Personal p) async {
    await _db.eliminarPersonal(p.id!);
    _cargarPersonal();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Personal registrado'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const RegistrarPersonalScreen()),
          );
          _cargarPersonal();
        },
        icon: const Icon(Icons.person_add),
        label: const Text('Registrar'),
        backgroundColor: PaeGoColors.sky,
        foregroundColor: Colors.white,
      ),
      body: _cargando
          ? const Center(child: CircularProgressIndicator())
          : _lista.isEmpty
              ? const Center(
                  child: Text('No hay personal registrado aún.'),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: _lista.length,
                  itemBuilder: (_, i) {
                    final p = _lista[i];
                    return Card(
                      margin: const EdgeInsets.only(bottom: 10),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: PaeGoColors.sky,
                          child: Text(
                            p.nombre[0].toUpperCase(),
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                        title: Text(p.nombreCompleto),
                        subtitle: Text('${p.rol.label} · CC ${p.cedula}'),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete_outline,
                              color: Colors.redAccent),
                          onPressed: () => _confirmarEliminar(p),
                        ),
                      ),
                    );
                  },
                ),
    );
  }

  void _confirmarEliminar(Personal p) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Eliminar personal'),
        content: Text('¿Eliminar a ${p.nombreCompleto}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.pop(context);
              _eliminar(p);
            },
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );
  }
}

// ─── Formulario de registro ────────────────────────────────────────────────
class RegistrarPersonalScreen extends StatefulWidget {
  const RegistrarPersonalScreen({super.key, this.personalEditar});

  final Personal? personalEditar;

  @override
  State<RegistrarPersonalScreen> createState() =>
      _RegistrarPersonalScreenState();
}

class _RegistrarPersonalScreenState extends State<RegistrarPersonalScreen> {
  final _formKey  = GlobalKey<FormState>();
  final _nombre   = TextEditingController();
  final _apellido = TextEditingController();
  final _cedula   = TextEditingController();
  final _telefono = TextEditingController();
  UserRole _rol   = UserRole.conductor;
  bool _guardando = false;

  @override
  void initState() {
    super.initState();
    final p = widget.personalEditar;
    if (p != null) {
      _nombre.text   = p.nombre;
      _apellido.text = p.apellido;
      _cedula.text   = p.cedula;
      _telefono.text = p.telefono;
      _rol           = p.rol;
    }
  }

  @override
  void dispose() {
    _nombre.dispose();
    _apellido.dispose();
    _cedula.dispose();
    _telefono.dispose();
    super.dispose();
  }

  Future<void> _guardar() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _guardando = true);

    final p = Personal(
      id:       widget.personalEditar?.id,
      nombre:   _nombre.text.trim(),
      apellido: _apellido.text.trim(),
      cedula:   _cedula.text.trim(),
      telefono: _telefono.text.trim(),
      rol:      _rol,
    );

    try {
      final db = DatabaseHelper.instance;
      if (widget.personalEditar == null) {
        await db.insertarPersonal(p);
      } else {
        await db.actualizarPersonal(p);
      }
      if (mounted) Navigator.pop(context);
    } catch (e) {
      setState(() => _guardando = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Error: la cédula ya está registrada.'),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final esEdicion = widget.personalEditar != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(esEdicion ? 'Editar personal' : 'Registrar personal'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _campo(_nombre,   'Nombre',   Icons.person),
              const SizedBox(height: 14),
              _campo(_apellido, 'Apellido', Icons.person_outline),
              const SizedBox(height: 14),
              _campo(_cedula,   'Cédula',   Icons.badge,
                  tipo: TextInputType.number),
              const SizedBox(height: 14),
              _campo(_telefono, 'Teléfono', Icons.phone,
                  tipo: TextInputType.phone),
              const SizedBox(height: 14),

              // Selector de rol
              DropdownButtonFormField<UserRole>(
                value: _rol,
                decoration: const InputDecoration(
                  labelText: 'Rol',
                  prefixIcon: Icon(Icons.admin_panel_settings),
                  border: OutlineInputBorder(),
                ),
                items: UserRole.values.map((r) {
                  return DropdownMenuItem(value: r, child: Text(r.label));
                }).toList(),
                onChanged: (v) => setState(() => _rol = v!),
              ),

              const SizedBox(height: 28),

              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: _guardando ? null : _guardar,
                  icon: _guardando
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(
                              strokeWidth: 2, color: Colors.white),
                        )
                      : const Icon(Icons.save),
                  label: Text(esEdicion ? 'Actualizar' : 'Guardar'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _campo(
    TextEditingController ctrl,
    String label,
    IconData icon, {
    TextInputType tipo = TextInputType.text,
  }) {
    return TextFormField(
      controller: ctrl,
      keyboardType: tipo,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: const OutlineInputBorder(),
      ),
      validator: (v) =>
          (v == null || v.trim().isEmpty) ? 'Campo requerido' : null,
    );
  }
}
