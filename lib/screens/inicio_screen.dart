
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/reporte_provider.dart';

class InicioScreen extends StatelessWidget {
  const InicioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final reporteProvider = context.watch<ReporteProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Reporte Ciudadano'),
        centerTitle: true,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: reporteProvider.reportes.isEmpty
          ? const Center(
              child: Text(
                'Todavía no hay reportes registrados',
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
            )
          : ListView.builder(
              itemCount: reporteProvider.reportes.length,
              itemBuilder: (context, index) {
                final reporte = reporteProvider.reportes[index];

                return Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    leading: const Icon(
                      Icons.report_problem,
                      color: Colors.orange,
                    ),
                    title: Text(reporte.tipo),
                    subtitle: Text(reporte.descripcion),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        '/detalle',
                        arguments: reporte,
                      );
                    },
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushNamed(context, '/registro');
        },
        icon: const Icon(Icons.add),
        label: const Text('Nuevo reporte'),
      ),
    );
  }
}
