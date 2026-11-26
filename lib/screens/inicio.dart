import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';


class Inicio extends StatelessWidget {
  const Inicio({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 50),
          
              const Text(
                'Bienvenido a la aplicación de demonios de Supernatural',
                style: TextStyle(fontSize: 24),
              ),
          
              const SizedBox(height: 150),
          
              SizedBox(
                height: 50,
                width: 200,
                child: ElevatedButton(
                  onPressed: () {
                    context.push('/registro');
                  },
                  child: const Text('Registrarse'),
                ),
              ),
          
              const SizedBox(height: 50),
          
              SizedBox(
                height: 50,
                width: 200,
                child: ElevatedButton(
                  onPressed: () {
                    context.push('/login');
                  },
                  child: const Text('Iniciar sesión'),
                ),
              ),
            ]
          ),
        ),
      ),
    );
  }
}