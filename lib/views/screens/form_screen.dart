import 'package:data_management/config/themes/app_themes.dart';
import 'package:data_management/data/models/data_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../data/services/data_services.dart';
import '../widgets/widgets.dart';

const List<String> opciones = [
  "Automoviles",
  "Camion",
  "Moto",
];

class FormScreen extends StatelessWidget {
  const FormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final DataModel dataModel =
        ModalRoute.of(context)!.settings.arguments as DataModel;
    return FormData(dataModel: dataModel);
  }
}

class FormData extends StatefulWidget {
  final DataModel dataModel;
  const FormData({
    super.key,
    required this.dataModel,
  });

  @override
  State<FormData> createState() => _FormDataState();
}

class _FormDataState extends State<FormData> {
  final GlobalKey<FormState> formKey = GlobalKey();
  DataServices dataServices = DataServices();

  final nombreController = TextEditingController();
  final descripcionController = TextEditingController();
  final precioController = TextEditingController();
  final existenciaController = TextEditingController();
  final porcentajeDescuentoController = TextEditingController();
  final valoracionController = TextEditingController();
  final marcaController = TextEditingController();
  final modeloController = TextEditingController();
  final formaIngresoController = TextEditingController();
  final categoria = TextEditingController();
  final ultimoIngresoController = TextEditingController();
  final imagenController = TextEditingController();

  String opcion = opciones.first;
  String radio1 = "Compra";
  bool suiche = false;

  void inicializar(DataModel dataModel) {
    nombreController.text = dataModel.nombre;
    descripcionController.text = dataModel.descripcion;
    precioController.text = dataModel.precio.toString();
    existenciaController.text = dataModel.existencia.toString();
    porcentajeDescuentoController.text =
        dataModel.porcentajeDescuento.toString();
    valoracionController.text = dataModel.valoracion.toString();
    marcaController.text = dataModel.marca;
    modeloController.text = dataModel.modelo;
    formaIngresoController.text = dataModel.formaIngreso;
    ultimoIngresoController.text = dataModel.ultimoIngreso;
    imagenController.text = dataModel.imagen;
  }

  @override
  void initState() {
    if (widget.dataModel.id != null) {
      inicializar(widget.dataModel);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nuevo Producto'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              const SizedBox(height: 8),
              CustomText(
                labelText: "Nombre del producto",
                controller: nombreController,
                validator: validarText,
              ),
              const SizedBox(height: 8),
              CustomText(
                labelText: "Descripcion",
                controller: descripcionController,
                validator: validarText,
              ),
              const SizedBox(height: 8),
              dropdownOpcionesCategorias(),
              const SizedBox(height: 8),
              fecha(),
              const SizedBox(height: 8),
              CustomText(
                labelText: "Precio",
                keyboardType: TextInputType.number,
                controller: precioController,
                validator: validarValor,
              ),
              const SizedBox(height: 8),
              CustomText(
                labelText: " % descuento",
                keyboardType: TextInputType.number,
                controller: porcentajeDescuentoController,
                validator: validarValor,
              ),
              const SizedBox(height: 8),
              CustomText(
                labelText: "Existencia",
                keyboardType: TextInputType.number,
                controller: existenciaController,
                validator: validarValor,
              ),
              const SizedBox(height: 8),
              CustomText(
                labelText: "Valoracion",
                keyboardType: TextInputType.number,
                controller: valoracionController,
                validator: validarValor,
              ),
              const SizedBox(height: 8),
              CustomText(
                labelText: "Marca",
                controller: marcaController,
                validator: validarText,
              ),
              const SizedBox(height: 8),
              CustomText(
                labelText: "Modelo",
                controller: modeloController,
                validator: validarText,
              ),
              const SizedBox(height: 8),
              radios(),
              const SizedBox(height: 8),
              campoSuiche(),
              const SizedBox(height: 8),
              CustomText(
                labelText: 'Url de la imagen',
                controller: imagenController,
              ),
              customButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget dropdownOpcionesCategorias() {
    return DropdownButtonFormField(
      value: opcion,
      items: opciones.map((op) {
        return DropdownMenuItem(value: op, child: Text(op));
      }).toList(),
      onChanged: (value) {
        setState(() {
          opcion = value as String;
        });
      },
      decoration: const InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 2),
          labelText: "Categoria",
          border: OutlineInputBorder()),
      validator: (value) =>
          value == null ? "debe seleccionar una opcion." : null,
    );
  }

  Widget radios() {
    return Container(
      child: InputDecorator(
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          labelText: "Forma de Ingreso",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
        ),
        child: Column(
          children: [
            RadioListTile(
              contentPadding: const EdgeInsets.all(0),
              title: const Text("Compra"),
              value: "Compra",
              groupValue: radio1,
              onChanged: (value) {
                setState(() {
                  radio1 = value ?? "Compra";
                });
              },
            ),
            RadioListTile(
              contentPadding: const EdgeInsets.all(0),
              title: const Text("Intercambio"),
              value: "Intercambio",
              groupValue: radio1,
              onChanged: (value) {
                setState(() {
                  radio1 = value ?? "Intercambio";
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget fecha() {
    return TextFormField(
      controller: ultimoIngresoController,
      decoration: const InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 2),
        labelText: 'Ultimo ingreso',
      ),
      readOnly: true,
      onTap: () async {
        DateTime? fechaPicker = await showDatePicker(
            context: context,
            firstDate: DateTime(2024),
            lastDate: DateTime(2025),
            initialDate: DateTime.now());
        if (fechaPicker != null) {
          String fecha = DateFormat('yyyy-MM-dd').format(fechaPicker);
          setState(() {
            ultimoIngresoController.text = fecha;
          });
        } else {
          print('No se ha seleccionado ninguna fecha');
        }
      },
    );
  }

  Widget campoSuiche() {
    return InputDecorator(
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          labelText: "Estado de la venta",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
          )),
      child: SwitchListTile(
        activeColor: AppThemes.primary,
        value: suiche,
        title: const Text("Activo"),
        onChanged: (value) {
          setState(() {
            suiche = value;
          });
        },
      ),
    );
  }

  String? validarText(String? value) {
    if (value == null || value.isEmpty) {
      return 'Debe digitar un texto';
    } else if (value.length < 3) {
      return 'El texto debe tener más de 5 caracteres';
    } else {
      return null;
    }
  }

  String? validarValor(String? value) {
    if (value == null || value.isEmpty) {
      return 'Debe digitar un valor';
    } else if (int.parse(value) < 0) {
      return 'El valor debe ser positivo';
    } else {
      return null;
    }
  }

  FractionallySizedBox customButton() {
    return FractionallySizedBox(
      widthFactor: 1.0,
      child: ElevatedButton(
        onPressed: () {
          if (!formKey.currentState!.validate()) {
            return;
          }
          DataModel dataModel = desdeFormulario();
          if (widget.dataModel.id != null) {
            dataServices.update(dataModel);
          } else {
            dataServices.insert(dataModel);
          }
          print(desdeFormulario().toString());
          Navigator.pop(context);
        },
        child: const Text(
          'Guardar',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }

  DataModel desdeFormulario() {
    return DataModel(
      id: widget.dataModel.id,
      nombre: nombreController.text,
      descripcion: descripcionController.text,
      precio: int.parse(precioController.text),
      existencia: int.parse(existenciaController.text),
      porcentajeDescuento: int.parse(porcentajeDescuentoController.text),
      valoracion: int.parse(valoracionController.text),
      marca: marcaController.text,
      modelo: modeloController.text,
      formaIngreso: radio1,
      categoria: opcion,
      ultimoIngreso: ultimoIngresoController.text,
      activo: suiche,
      imagen: imagenController.text,
    );
  }
}
