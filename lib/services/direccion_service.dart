
import 'dart:convert';
import 'package:http/http.dart' as http;

class DireccionService {
  Future<String> obtenerDireccion(
    double latitud,
    double longitud,
  ) async {
    try {
      final url = Uri.https(
        'nominatim.openstreetmap.org',
        '/reverse',
        {
          'lat': latitud.toString(),
          'lon': longitud.toString(),
          'format': 'json',
          'zoom': '18',
        },
      );

      // Consultar la API para obtener la dirección
      final respuesta = await http.get(
        url,
        headers: {
          'User-Agent': 'ReporteCiudadanoEscolar/1.0',
        },
      );

      if (respuesta.statusCode == 200) {
        final Map<String, dynamic> datos =
            jsonDecode(respuesta.body);

        return datos['display_name'] ??
            'Dirección no disponible';
      } else {
        return 'No se pudo obtener la dirección';
      }
    } catch (e) {
      return 'Error de conexión';
    }
  }
}
