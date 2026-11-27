
class ReporteModel {
  final String tipo;
  final String descripcion;
  final String foto;
  final double latitud;
  final double longitud;
  final String direccion;
  final DateTime fecha;
  final String estado;

  ReporteModel({
    required this.tipo,
    required this.descripcion,
    required this.foto,
    required this.latitud,
    required this.longitud,
    required this.fecha,
    this.direccion = 'Dirección no disponible',
    this.estado = 'Pendiente',
  });

  Map<String, dynamic> toJson() {
    return {
      'tipo': tipo,
      'descripcion': descripcion,
      'foto': foto,
      'latitud': latitud,
      'longitud': longitud,
      'direccion': direccion,
      'fecha': fecha.toIso8601String(),
      'estado': estado,
    };
  }

  factory ReporteModel.fromJson(Map<String, dynamic> json) {
    return ReporteModel(
      tipo: json['tipo'],
      descripcion: json['descripcion'],
      foto: json['foto'],
      latitud: (json['latitud'] as num).toDouble(),
      longitud: (json['longitud'] as num).toDouble(),
      direccion: json['direccion'] ?? 'Dirección no disponible',
      fecha: DateTime.parse(json['fecha']),
      estado: json['estado'] ?? 'Pendiente',
    );
  }
}
