import 'package:app_road_to_devfest/modelos/nota.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PantallaNuevaNota extends StatefulWidget {
  const PantallaNuevaNota({super.key});

  @override
  State<PantallaNuevaNota> createState() => _PantallaNuevaNotaState();
}

class _PantallaNuevaNotaState extends State<PantallaNuevaNota> {
  List<Color> coloresAElegir = Colors.primaries;
  Color? colorSeleccionado;

  final TextEditingController _tituloController = TextEditingController();
  final TextEditingController _contenidoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            final titulo = _tituloController.text;
            final contenido = _contenidoController.text;
            final colorAlpha = colorSeleccionado?.alpha ?? 0;
            final colorRed = colorSeleccionado?.red ?? 0;
            final colorGreen = colorSeleccionado?.green ?? 0;
            final colorBlue = colorSeleccionado?.blue ?? 0;

            final nuevaNota = Nota(
              titulo: titulo,
              contenido: contenido,
              colorAlpha: colorAlpha,
              colorRed: colorRed,
              colorBlue: colorBlue,
              colorGreen: colorGreen,
            );

            await FirebaseFirestore.instance
                .collection('notas')
                .add(nuevaNota.aJson());

            // ignore: use_build_context_synchronously
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.save,
            color: Colors.white,
          ),
        ),
        backgroundColor: colorSeleccionado?.withOpacity(1),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: colorSeleccionado != null ? Colors.white : Colors.black,
            ),
          ),
          title: Text(
            'Nueva Nota',
            style: TextStyle(
              color: colorSeleccionado != null ? Colors.white : Colors.black,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(2.0),
                decoration: BoxDecoration(
                    border: Border.all(
                  color: Colors.white,
                )),
                child: DropdownButton<Color>(
                  isExpanded: true,
                  items: coloresAElegir.map((color) {
                    return DropdownMenuItem(
                      value: color,
                      child: Container(
                        height: 20,
                        width: double.infinity,
                        color: color,
                      ),
                    );
                  }).toList(),
                  value: colorSeleccionado,
                  hint: Text('Selecciona un color'),
                  onChanged: (nuevoColorSeleccionado) {
                    setState(() {
                      colorSeleccionado = nuevoColorSeleccionado;
                    });
                  },
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              TextField(
                controller: _tituloController,
                decoration: InputDecoration(hintText: 'Título de la nota'),
              ),
              const SizedBox(
                height: 16.0,
              ),
              TextField(
                controller: _contenidoController,
                decoration: InputDecoration(hintText: 'Contenido de la nota'),
              )
            ],
          ),
        ));
  }
}
