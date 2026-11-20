
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/reporte_model.dart';
import '../providers/reporte_provider.dart';
import '../services/ubicacion_service.dart';
import '../services/camara_service.dart';

class RegistroScreen extends StatefulWidget {
  const RegistroScreen({super.key});

  @override
  State<RegistroScreen> createState() => _RegistroScreenState();
}

class _RegistroScreenState extends State<RegistroScreen> {
  final TextEditingController _tipoController = TextEditingController();
  final TextEditingController _descripcionController = TextEditingController();

  final UbicacionService _ubicacionService = UbicacionService();
  final CamaraService _camaraService = CamaraService();

  String _foto = '';
  double _latitud = 0;
  double _longitud = 0;
  String _mensaje = '';
  bool _cargando = false;

  Future<void> _obtenerUbicacion() async {
    try {
      final posicion = await _ubicacionService.obtenerUbicacion();
      if (!mounted) return;

      setState(() {
        _latitud = posicion.latitude;
        _longitud = posicion.longitude;
        _mensaje = 'Ubicación obtenida correctamente';
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _mensaje = 'Error al obtener ubicación: $e';
      });
    }
  }

  Future<void> _tomarFoto() async {
    try {
      final foto = await _camaraService.tomarFoto();
      if (!mounted) return;

      if (foto != null) {
        setState(() {
          _foto = foto;
          _mensaje = 'Fotografía guardada';
        });
      }
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _mensaje = 'Error al tomar fotografía: $e';
      });
    }
  }

  Future<void> _guardarReporte() async {
    if (_tipoController.text.trim().isEmpty ||
        _descripcionController.text.trim().isEmpty ||
        _foto.isEmpty ||
        (_latitud == 0 && _longitud == 0)) {
      setState(() {
        _mensaje = 'Completa los campos, fotografía y ubicación';
      });
      return;
    }

    setState(() {
      _cargando = true;
      _mensaje = '';
    });

    try {
      final reporte = ReporteModel(
        tipo: _tipoController.text.trim(),
        descripcion: _descripcionController.text.trim(),
        foto: _foto,
        latitud: _latitud,
        longitud: _longitud,
        fecha: DateTime.now(),
      );

      await context.read<ReporteProvider>().agregarReporte(reporte);
      if (!mounted) return;

      Navigator.pop(context);
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _mensaje = 'Error al guardar el reporte: $e';
      });
    } finally {
      if (mounted) {
        setState(() {
          _cargando = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _tipoController.dispose();
    _descripcionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nuevo reporte'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Registrar incidencia',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),

            TextField(
              controller: _tipoController,
              decoration: const InputDecoration(
                labelText: 'Tipo de incidencia',
                hintText: 'Ejemplo: Bache',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: _descripcionController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'Descripción',
                hintText: 'Describe el problema',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton.icon(
              onPressed: _obtenerUbicacion,
              icon: const Icon(Icons.location_on),
              label: const Text('Obtener ubicación GPS'),
            ),

            const SizedBox(height: 10),

            Text(
              'Latitud: $_latitud\nLongitud: $_longitud',
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 20),

            ElevatedButton.icon(
              onPressed: _tomarFoto,
              icon: const Icon(Icons.camera_alt),
              label: const Text('Tomar fotografía'),
            ),

            const SizedBox(height: 15),

            if (_foto.isNotEmpty)
              Image.file(
                File(_foto),
                height: 180,
                fit: BoxFit.cover,
              ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: _cargando ? null : _guardarReporte,
              child: const Text('Guardar reporte'),
            ),

            const SizedBox(height: 15),

            if (_cargando)
              const Center(child: CircularProgressIndicator()),

            Text(
              _mensaje,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.blue),
            ),
          ],
        ),
      ),
    );
  }
}
