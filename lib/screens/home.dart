//import 'package:go_router/go_router.dart';
import 'package:entrega_final/entities/demonio.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';
import 'package:entrega_final/providers/demonprovider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Home extends ConsumerStatefulWidget {
  const Home({super.key, required this.nombre});

  final String nombre;

  @override
  ConsumerState<Home> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  @override
  void initState() {
    super.initState();
    if (ref.read(demonProvider).isEmpty) {
      ref.read(demonProvider.notifier).getAllDemons();
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Demonio> listaDemonios = ref.watch(demonProvider);
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Lista de demonios de Supernatural de ${widget.nombre.toUpperCase()}",
                style: TextStyle(color: Colors.black, fontSize: 30),
              ),

              SizedBox(height: 20),

              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: listaDemonios.length,
                    itemBuilder: (context, index) {
                      final demon = listaDemonios[index];
                      return _Elemento(elemento: demon);
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(height: 15);
                    },
                  ),
                ),
              ),

              SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      context.push('/agregar');
                    },
                    icon: const Icon(Icons.add),
                  ),
                  ElevatedButton.icon(
                    onPressed: () async {
                      await FirebaseAuth.instance.signOut();
                      if (context.mounted) {
                        context.go('/inicio');
                      }
                    },
                    icon: const Icon(Icons.logout),
                    label: const Text('Cerrar sesión'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Elemento extends ConsumerWidget {
  const _Elemento({required this.elemento});

  final Demonio elemento;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        color: Color(0xFFA3F0D3),
      ),
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: SizedBox(
            width: 56,
            height: 56,
            child: elemento.foto.isEmpty
                ? Icon(Icons.person)
                : Image.network(
                    elemento.foto,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(Icons.broken_image);
                    },
                  ),
          ),
        ),
        title: Text(elemento.nombre),
        subtitle: Text(elemento.rango),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: (){
                context.push('/modificar',extra: elemento);
              },
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                ref.read(demonProvider.notifier).deleteDemon(elemento);
              },
            ),
          ],
        ),
        onTap: () {
          context.push('/detalle', extra: elemento);
        },
      ),
    );
  }
}
