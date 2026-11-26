// ignore_for_file: use_build_context_synchronously

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:entrega_final/providers/usersprovider.dart';
import 'package:entrega_final/entities/user.dart';

class Registro extends ConsumerStatefulWidget {
  const Registro({super.key});

  @override
  ConsumerState<Registro> createState() => _RegistroState();
}

class _RegistroState extends ConsumerState<Registro> {
  late final TextEditingController nameController;
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late final TextEditingController confirmPasswordController;

  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    ref.read(userProvider.notifier).getAllUsers();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
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
              const SizedBox(height: 50),
              const Text('Registro', style: TextStyle(fontSize: 24)),
              const SizedBox(height: 100),
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Nombre'),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: passwordController,
                decoration: const InputDecoration(labelText: 'Contraseña'),
                obscureText: true,
              ),
              const SizedBox(height: 20),
              TextField(
                controller: confirmPasswordController,
                decoration: const InputDecoration(
                  labelText: 'Confirmar Contraseña',
                ),
                obscureText: true,
              ),

              const SizedBox(height: 50),

              SizedBox(
                height: 50,
                width: 200,
                child: ElevatedButton(
                  onPressed: () async {
                    if (passwordController.text ==
                        confirmPasswordController.text) {
                      final credential = await auth
                          .createUserWithEmailAndPassword(
                            email: emailController.text,
                            password: passwordController.text,
                          );

                      final userId = credential.user?.uid;

                      if (userId == null) {
                        return;
                      }

                      await ref
                          .read(userProvider.notifier)
                          .addUser(
                            Usuario(
                              id: userId,
                              name: nameController.text,
                              email: emailController.text,
                            ),
                          );
                      context.push('/login');
                    } else {
                      // Las contraseñas no coinciden
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Las contraseñas no coinciden"),
                          duration: const Duration(seconds: 2),
                        ),
                      );
                    }
                  },
                  child: const Text(
                    'Registrarse',
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
