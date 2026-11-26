import 'package:entrega_final/entities/demonio.dart';
import 'package:entrega_final/providers/demonprovider.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Modificar extends ConsumerStatefulWidget {
  const Modificar({super.key, required this.demon});

  final Demonio demon;

  @override
  ConsumerState<Modificar> createState() => _ModificarState();
}

class _ModificarState extends ConsumerState<Modificar> {
  late final TextEditingController nombreController;
  late final TextEditingController descController;
  late final TextEditingController aparicionesController;
  late final TextEditingController rangoController;
  late final TextEditingController fotoController;

  @override
  void initState() {
    super.initState();
    nombreController = TextEditingController(text: widget.demon.nombre);
    descController = TextEditingController(text: widget.demon.descripcion);
    aparicionesController = TextEditingController(
      text: widget.demon.apariciones.toString(),
    );
    rangoController = TextEditingController(text: widget.demon.rango);
    fotoController = TextEditingController(text: widget.demon.foto);
  }

  @override
  void dispose() {
    nombreController.dispose();
    descController.dispose();
    aparicionesController.dispose();
    rangoController.dispose();
    fotoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20),

              Text('Agregar demonio', style: TextStyle(fontSize: 24)),

              SizedBox(height: 30),

              TextField(
                controller: nombreController,
                decoration: InputDecoration(labelText: 'Nombre'),
              ),

              SizedBox(height: 40),

              TextField(
                controller: descController,
                decoration: InputDecoration(labelText: 'Descripcion'),
              ),

              SizedBox(height: 40),

              TextField(
                controller: rangoController,
                decoration: InputDecoration(labelText: 'Rango'),
              ),

              SizedBox(height: 40),

              TextField(
                controller: aparicionesController,
                decoration: InputDecoration(labelText: 'Apariciones'),
              ),

              SizedBox(height: 40),

              TextField(
                controller: fotoController,
                decoration: InputDecoration(labelText: 'Foto'),
              ),

              SizedBox(height: 10),

              ElevatedButton(
                onPressed: () {
                  bool vacio =
                      nombreController.text.isEmpty ||
                      descController.text.isEmpty ||
                      rangoController.text.isEmpty ||
                      aparicionesController.text.isEmpty ||
                      fotoController.text.isEmpty;

                  if (vacio) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Los campos no pueden estar vacios'),
                      ),
                    );
                  } else {
                    ref.read(demonProvider.notifier).modifyDemon(
                      Demonio(
                        id: widget.demon.id,
                        nombre: nombreController.text.trim(),
                        descripcion: descController.text.trim(),
                        apariciones: int.parse(aparicionesController.text.trim()),
                        rango: rangoController.text.trim(),
                        foto: fotoController.text.trim()
                      )
                    );

                    context.pop();
                  }
                },
                child: Text('Guardar cambios'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
