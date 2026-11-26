import 'package:entrega_final/entities/demonio.dart';
import 'package:material_ui/material_ui.dart';

class Detalle extends StatelessWidget {
  const Detalle({super.key, required this.demon});

  final Demonio demon;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(demon.nombre)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: SizedBox(
                height: 240,
                child: demon.foto.isEmpty
                    ? const Icon(Icons.person, size: 96)
                    : Image.network(
                        demon.foto,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(Icons.broken_image, size: 96);
                        },
                      ),
              ),
            ),
            const SizedBox(height: 20),
            _Atributo(titulo: 'Nombre', valor: demon.nombre),
            _Atributo(titulo: 'Descripción', valor: demon.descripcion),
            _Atributo(
              titulo: 'Apariciones',
              valor: demon.apariciones.toString(),
            ),
            _Atributo(titulo: 'Rango', valor: demon.rango),
          ],
        ),
      ),
    );
  }
}

class _Atributo extends StatelessWidget {
  const _Atributo({this.titulo, required this.valor});

  final String? titulo;
  final String valor;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(titulo!),
        subtitle: Text(valor.isEmpty ? 'Sin información' : valor),
      ),
    );
  }
}