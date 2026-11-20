
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/reporte_model.dart';

class ReporteProvider extends ChangeNotifier {
  List<ReporteModel> _reportes = [];

  List<ReporteModel> get reportes => _reportes;

  ReporteProvider() {
    cargarReportes();
  }

  // Recuperar los reportes guardados
  Future<void> cargarReportes() async {
    final prefs = await SharedPreferences.getInstance();

    String? datos = prefs.getString('reportes');

    if (datos != null) {
      List lista = jsonDecode(datos);

      _reportes = lista
          .map((reporte) => ReporteModel.fromJson(reporte))
          .toList();

      notifyListeners();
    }
  }

  // Agregar un reporte nuevo
  Future<void> agregarReporte(ReporteModel reporte) async {
    _reportes.add(reporte);
    notifyListeners();

    await guardarReportes();
  }

  // Guardar los reportes en el dispositivo
  Future<void> guardarReportes() async {
    final prefs = await SharedPreferences.getInstance();

    String datos = jsonEncode(
      _reportes.map((reporte) => reporte.toJson()).toList(),
    );

    await prefs.setString('reportes', datos);
  }
}
