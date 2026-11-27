
import 'dart:io';
import 'package:flutter/material.dart';
import '../models/reporte_model.dart';

class DetalleScreen extends StatelessWidget {
  const DetalleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final reporte =
        ModalRoute.of(context)!.settings.arguments as ReporteModel;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalles del reporte'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Información de la incidencia',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            if (reporte.foto.isNotEmpty)
              Image.file(
                File(reporte.foto),
                height: 220,
                width: double.infinity,
                fit: BoxFit.cover,
              ),

            const SizedBox(height: 20),

            Text(
              'Tipo: ${reporte.tipo}',
              style: const TextStyle(fontSize: 18),
            ),

            const SizedBox(height: 10),

            Text(
              'Descripción: ${reporte.descripcion}',
              style: const TextStyle(fontSize: 16),
            ),

            const SizedBox(height: 10),

            Text(
              'Estado: ${reporte.estado}',
              style: const TextStyle(fontSize: 16),
            ),

            const SizedBox(height: 10),

            Text(
              'Latitud: ${reporte.latitud}',
              style: const TextStyle(fontSize: 16),
            ),

            const SizedBox(height: 10),

            Text(
              'Longitud: ${reporte.longitud}',
              style: const TextStyle(fontSize: 16),
            ),

            const SizedBox(height: 10),

            Text(
              'Dirección: ${reporte.direccion}',
              style: const TextStyle(fontSize: 16),
            ),

            const SizedBox(height: 10),

            Text(
              'Fecha: ${reporte.fecha.day}/${reporte.fecha.month}/${reporte.fecha.year}',
              style: const TextStyle(fontSize: 16),
            ),

            const SizedBox(height: 25),

            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Regresar'),
            ),
          ],
        ),
      ),
    );
  }
}
