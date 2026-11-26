import 'package:go_router/go_router.dart';
import 'package:entrega_final/screens/inicio.dart';
import 'package:entrega_final/screens/registro.dart';
import 'package:entrega_final/screens/login.dart';
import 'package:entrega_final/screens/home.dart';
import 'package:entrega_final/screens/agregar.dart';
import 'package:entrega_final/screens/modificar.dart';
import 'package:entrega_final/screens/detalle.dart';
import 'package:entrega_final/entities/demonio.dart';

GoRouter router = GoRouter(
  initialLocation: '/inicio',
  routes: [
    GoRoute(
      path: '/inicio',
      builder: (context, state) => const Inicio(),
    ),

    GoRoute(
      path: '/registro', 
      builder: (context, state) => Registro()
    ),

    GoRoute(
      path: '/login',
      builder: (context,state) => Login()
    ),

    GoRoute(
      path: '/home',
      builder: (context, state) => Home(nombre: state.extra as String)
    ),

    GoRoute(
      path: '/agregar',
      builder: (context,state) => Agregar()
    ),

    GoRoute(
      path: '/modificar',
      builder: (context,state) => Modificar(demon: state.extra as Demonio)
    ),

    GoRoute(
      path: '/detalle',
      builder: (context, state) => Detalle(demon: state.extra as Demonio),
    )
  ]
);