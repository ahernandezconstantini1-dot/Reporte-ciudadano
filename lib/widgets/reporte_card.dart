
import 'dart:io';
import 'package:flutter/material.dart';
import '../models/reporte_model.dart';

class ReporteCard extends StatefulWidget {
  final ReporteModel reporte;
  final VoidCallback onTap;

  const ReporteCard({
    super.key,
    required this.reporte,
    required this.onTap,
  });

  @override
  State<ReporteCard> createState() => _ReporteCardState();
}

class _ReporteCardState extends State<ReporteCard> {
  bool _seleccionado = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _seleccionado = !_seleccionado;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: const EdgeInsets.all(10),
        padding: EdgeInsets.all(_seleccionado ? 15 : 8),
        decoration: BoxDecoration(
          color: _seleccionado ? Colors.blue[50] : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: _seleccionado ? Colors.blue : Colors.grey.shade300,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                if (widget.reporte.foto.isNotEmpty)
                  Image.file(
                    File(widget.reporte.foto),
                    height: 160,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  )
                else
                  Container(
                    height: 160,
                    color: Colors.grey[300],
                    child: const Center(
                      child: Icon(Icons.image, size: 50),
                    ),
                  ),
                Positioned(
                  bottom: 10,
                  left: 10,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    color: Colors.black54,
                    child: Text(
                      widget.reporte.tipo,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            ListTile(
              title: Text(widget.reporte.descripcion),
              subtitle: Text('Estado: ${widget.reporte.estado}'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: widget.onTap,
            ),
          ],
        ),
      ),
    );
  }
}
