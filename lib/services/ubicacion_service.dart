
import 'package:geolocator/geolocator.dart';

class UbicacionService {
  Future<Position> obtenerUbicacion() async {
    // Comprobar que el GPS esté activado
    bool activo = await Geolocator.isLocationServiceEnabled();

    if (!activo) {
      throw Exception('El GPS está desactivado');
    }

    // Revisar y solicitar permisos de ubicación
    LocationPermission permiso = await Geolocator.checkPermission();

    if (permiso == LocationPermission.denied) {
      permiso = await Geolocator.requestPermission();
    }

    if (permiso == LocationPermission.denied ||
        permiso == LocationPermission.deniedForever) {
      throw Exception('No se otorgaron permisos de ubicación');
    }

    // Obtener las coordenadas actuales
    Position posicion = await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
      ),
    );

    return posicion;
  }
}
