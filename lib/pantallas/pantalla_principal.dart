import 'package:app_road_to_devfest/modelos/nota.dart';
import 'package:app_road_to_devfest/pantallas/pantalla_nueva_nota.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PantallaPrincipal extends StatelessWidget {
  const PantallaPrincipal({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.add,
        ),
        onPressed: () async {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) {
                return PantallaNuevaNota();
              },
            ),
          );
        },
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('notas').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final querySnapshots = snapshot.data!;
            final documentSnapshots = querySnapshots.docs;
            List<Nota> notas = [];
            for (var document in documentSnapshots) {
              final nota = Nota.desdeDocumentSnapshot(document);
              notas.add(nota);
            }

            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  notas.length,
                  (index) {
                    final nota = notas[index];
                    return cardNota(nota);
                  },
                ),
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Widget cardNota(Nota nota) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 12,
        horizontal: 24,
      ),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: Color.fromARGB(
            nota.colorAlpha,
            nota.colorRed,
            nota.colorGreen,
            nota.colorBlue,
          ),
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              offset: Offset(3, 3),
              color: Colors.black12,
              spreadRadius: 3,
              blurRadius: 3,
            )
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            nota.titulo,
            textAlign: TextAlign.start,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Text(
            nota.contenido,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),
    );
  }
}
