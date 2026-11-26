import 'package:entrega_final/entities/user.dart';
import 'package:entrega_final/providers/usersprovider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:material_ui/material_ui.dart ';
import 'package:go_router/go_router.dart';

class Login extends ConsumerStatefulWidget {
  const Login({super.key});

  @override
  ConsumerState<Login> createState() => _LoginState();
}

class _LoginState extends ConsumerState<Login> {
  late final TextEditingController emailController;
  late final TextEditingController passController;
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passController = TextEditingController();
    ref.read(userProvider.notifier).getAllUsers();
  }

  @override
  void dispose() {
    emailController.dispose();
    passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Usuario> listaUsuario = ref.watch(userProvider);
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) => SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('Inicio de sesion', style: TextStyle(fontSize: 24)),

                    SizedBox(height: 100),

                    TextField(
                      controller: emailController,
                      decoration: InputDecoration(label: Text('Email')),
                    ),

                    SizedBox(height: 20),

                    TextField(
                      controller: passController,
                      decoration: InputDecoration(label: Text('Contraseña')),
                      obscureText: true,
                    ),

                    SizedBox(height: 50),

                    SizedBox(
                      height: 50,
                      width: 200,
                      child: ElevatedButton(
                        onPressed: () async {
                          String mensaje;
                          if (emailController.text.isEmpty ||
                              passController.text.isEmpty) {
                            mensaje = 'Los campos no pueden estar vacios';
                          } else if (!listaUsuario.any(
                            (user) => emailController.text == user.email,
                          )) {
                            mensaje = 'El email proporcionado no esta asociado a ninguna cuenta. Registrate';
                          } else {
                            try {
                              await auth.signInWithEmailAndPassword(
                                email: emailController.text,
                                password: passController.text,
                              );

                              Usuario user = listaUsuario.firstWhere(
                                (user) => auth.currentUser!.uid == user.id,
                              );
                              String nombre = user.name;
                              // ignore: use_build_context_synchronously
                              context.push('/home', extra: nombre);
                              return;
                            } on FirebaseAuthException catch (error) {
                              mensaje =
                                  error.code == 'wrong-password' ||
                                      error.code == 'invalid-credential'
                                  ? 'La contraseña no es correcta'
                                  : 'No se pudo iniciar sesion';
                            }
                          }

                          if (!context.mounted) return;
                          ScaffoldMessenger.of(context)
                              .showSnackBar(SnackBar(content: Text(mensaje)));
                        },
                        child: Text('Iniciar sesion'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
