
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/reporte_provider.dart';
import 'screens/inicio_screen.dart';
import 'screens/registro_screen.dart';
import 'screens/detalle_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    ChangeNotifierProvider(
      create: (context) => ReporteProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Reporte Ciudadano',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const InicioScreen(),
        '/registro': (context) => const RegistroScreen(),
        '/detalle': (context) => const DetalleScreen(),
      },
    );
  }
}
