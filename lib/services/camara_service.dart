
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class CamaraService {
  final ImagePicker _picker = ImagePicker();

  Future<String?> tomarFoto() async {
    // Abrir la cámara del dispositivo
    XFile? foto = await _picker.pickImage(
      source: ImageSource.camera,
    );

    if (foto == null) {
      return null;
    }

    // Guardar la fotografía dentro de la aplicación
    final carpeta = await getApplicationDocumentsDirectory();

    final nombre = 'reporte_${DateTime.now().millisecondsSinceEpoch}.jpg';
    final ruta = '${carpeta.path}/$nombre';

    await File(foto.path).copy(ruta);

    return ruta;
  }
}
