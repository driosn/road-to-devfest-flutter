import 'package:cloud_firestore/cloud_firestore.dart';

class Nota {
  Nota({
    required this.titulo,
    required this.contenido,
    required this.colorAlpha,
    required this.colorRed,
    required this.colorBlue,
    required this.colorGreen,
  });

  final String titulo;
  final String contenido;
  final int colorAlpha;
  final int colorRed;
  final int colorGreen;
  final int colorBlue;

  factory Nota.desdeDocumentSnapshot(DocumentSnapshot documentSnapshot) {
    final json = documentSnapshot.data() as Map<String, dynamic>;

    return Nota(
      titulo: json['titulo'],
      contenido: json['contenido'],
      colorAlpha: json['colorAlpha'],
      colorRed: json['colorRed'],
      colorBlue: json['colorBlue'],
      colorGreen: json['colorGreen'],
    );
  }

  Map<String, dynamic> aJson() {
    return {
      'titulo': titulo,
      'contenido': contenido,
      'colorAlpha': colorAlpha,
      'colorRed': colorRed,
      'colorBlue': colorBlue,
      'colorGreen': colorGreen,
    };
  }
}
