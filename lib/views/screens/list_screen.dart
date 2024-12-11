import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../data/models/models.dart';
import '../../data/services/services.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({super.key});

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  DataServices dataServices = DataServices();
  late Future<List<DataModel>> datosFuture;

  final NumberFormat numberFormat = NumberFormat('#,##0', 'es_CO');

  void cargarDatos() async {
    datosFuture = dataServices.getAll();
    setState(() {});
  }

  List<DataModel> datos = [];

  @override
  initState() {
    super.initState();
    cargarDatos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Listado de datos'),
      ),
      body: FutureBuilder(
        future: datosFuture,
        builder: (context, snapshot) {
          const textStyle = TextStyle(fontSize: 18);
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error al carcar datos, \nError: ${snapshot.error}',
                style: textStyle,
              ),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
                child: Text(
              'No hay datos disponibles',
              style: textStyle,
            ));
          }
          final datos = snapshot.data!;
          return Container(
            margin: const EdgeInsets.all(10),
            child: ListView.builder(
              itemCount: datos.length,
              itemBuilder: (context, index) {
                DataModel dato = datos[index];

                return Dismissible(
                  key: UniqueKey(),
                  direction: DismissDirection.startToEnd,
                  onDismissed: (direction) {
                    dataServices.delete(dato.id);
                  },
                  background: Container(
                    padding: const EdgeInsets.only(left: 15),
                    child: const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'eliminando',
                          style: TextStyle(color: Colors.red, fontSize: 16),
                        )),
                  ),
                  confirmDismiss: (direction) async {
                    bool resp = false;
                    resp = await showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Seguro de eliminar el dato'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                return Navigator.pop(context, false);
                              },
                              child: const Text('NO'),
                            ),
                            TextButton(
                              onPressed: () {
                                return Navigator.pop(context, true);
                              },
                              child: const Text('Si'),
                            )
                          ],
                        );
                      },
                    );
                    return resp;
                  },
                  child: Card(
                    margin: const EdgeInsets.all(5),
                    child: ListTile(
                      title: Text(
                        'Nombre: ${dato.nombre}',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Nombre: ${dato.nombre}'),
                          Text('Precio: \$ ${numberFormat.format(dato.precio)}')
                        ],
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.pushNamed(context, 'viewscreen',
                                      arguments: dato)
                                  .then(
                                (value) => setState(() {
                                  cargarDatos();
                                }),
                              );
                            },
                            icon: const Icon(Icons.remove_red_eye),
                          ),
                          IconButton(
                            onPressed: () {
                              Navigator.pushNamed(context, 'formscreen',
                                      arguments: dato)
                                  .then(
                                (value) => setState(() {
                                  cargarDatos();
                                }),
                              );
                            },
                            icon: const Icon(Icons.edit),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(
              context,
              'formscreen',
              arguments: DataModel.Empty(),
            ).then((value) => setState(() {
                  cargarDatos();
                }));
          },
          child: const Icon(Icons.add)),
    );
  }
}
