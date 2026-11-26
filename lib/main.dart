import 'package:material_ui/material_ui.dart';
import 'package:entrega_final/core/routers.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    ProviderScope(
      child: const MainApp()
    )
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  @override

  Widget build(BuildContext context) {
    return MaterialApp.router(routerConfig: router);
  }
}
