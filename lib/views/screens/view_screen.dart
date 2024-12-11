import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../data/models/models.dart';

class ViewScreen extends StatefulWidget {
  const ViewScreen({super.key});

  @override
  State<ViewScreen> createState() => _ViewScreenState();
}

class _ViewScreenState extends State<ViewScreen> {
  final NumberFormat numberFormat = NumberFormat('#, ##0', 'es_CO');

  @override
  Widget build(BuildContext context) {
    final DataModel dato =
        ModalRoute.of(context)!.settings.arguments as DataModel;
    return Scaffold(
        appBar: AppBar(
          title: const Text('Consulta de un dato Dato'),
        ),
        body: Container(
          padding: const EdgeInsets.all(12),
          child: ListView(
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Título de la consulta',
                        style: TextStyle(
                            fontSize: 25,
                            color: Colors.blueGrey,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 10,
                      ),

                      // motrar el texto con etiqueta en negrilla y valor
                      Row(
                        children: [
                          const Text(
                            'Nombre: ',
                            style: TextStyle(
                                fontSize: 17.5, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            dato.nombre,
                            style: const TextStyle(fontSize: 17.5),
                          )
                        ],
                      ),

                      const SizedBox(
                        height: 10,
                      ),

                      Row(
                        children: [
                          const Text(
                            'Descripcion: ',
                            style: TextStyle(
                                fontSize: 17.5, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            dato.descripcion,
                            style: const TextStyle(fontSize: 17.5),
                          )
                        ],
                      ),

                      const SizedBox(
                        height: 10,
                      ),

                      Row(
                        children: [
                          const Text(
                            'Precio: ',
                            style: TextStyle(
                                fontSize: 17.5, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '\$${numberFormat.format(dato.precio)}',
                            style: const TextStyle(fontSize: 17.5),
                          )
                        ],
                      ),

                      const SizedBox(
                        height: 10,
                      ),

                      // una fila con varios datos (filas)
                      Row(
                        children: [
                          Expanded(
                            // flex: 2,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Ultimo Ingreso: ',
                                  style: TextStyle(
                                      fontSize: 17.5,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  dato.ultimoIngreso,
                                  style: const TextStyle(fontSize: 17.5),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Marca: ',
                                  style: TextStyle(
                                      fontSize: 17.5,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  dato.marca,
                                  style: const TextStyle(fontSize: 17.5),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(
                        height: 10,
                      ),

                      Row(
                        children: [
                          const Text(
                            'Radio botón: ',
                            style: TextStyle(
                                fontSize: 17.5, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            dato.formaIngreso,
                            style: const TextStyle(fontSize: 17.5),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),

                      Row(
                        children: [
                          const Text(
                            'Activo: ',
                            style: TextStyle(
                                fontSize: 17.5, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            dato.activo ? 'Si' : 'No',
                            style: const TextStyle(fontSize: 17.5),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              if (dato.imagen.trim() != '')
                Card(
                  clipBehavior: Clip.antiAlias,
                  child: Image(
                    image: NetworkImage(dato.imagen),
                    height: 300,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
            ],
          ),
        ));
  }
}
