class DataModel {
  final int? id;
  final String nombre;
  final String descripcion;
  final int precio;
  final int existencia;
  final int porcentajeDescuento;
  final int valoracion;
  final String marca;
  final String modelo;
  final String formaIngreso;
  final String categoria;
  final String ultimoIngreso;
  final bool activo;
  final String imagen;

  DataModel({
    this.id,
    required this.nombre,
    required this.descripcion,
    required this.precio,
    required this.existencia,
    required this.porcentajeDescuento,
    required this.valoracion,
    required this.marca,
    required this.modelo,
    required this.formaIngreso,
    required this.categoria,
    required this.ultimoIngreso,
    required this.activo,
    required this.imagen,
  });

  DataModel.Empty({
    this.id = 0,
    this.nombre = '',
    this.descripcion = '',
    this.precio = 0,
    this.existencia = 0,
    this.porcentajeDescuento = 0,
    this.valoracion = 0,
    this.marca = '',
    this.modelo = '',
    this.formaIngreso = '',
    this.categoria = '',
    this.ultimoIngreso = '',
    this.activo = false,
    this.imagen = '',
  });

  DataModel.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        nombre = map['nombre'],
        descripcion = map['descripcion'],
        precio = map['precio'],
        existencia = map['existencia'],
        porcentajeDescuento = map['porcentajeDescuento'],
        valoracion = map['valoracion'],
        marca = map['marca'],
        modelo = map['modelo'],
        formaIngreso = map['formaIngreso'],
        categoria = map['categoria'],
        ultimoIngreso = map['ultimoIngreso'],
        activo = map['activo'] == 1,
        imagen = map['imagen'];

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nombre': nombre,
      'descripcion': descripcion,
      'precio': precio,
      'existencia': existencia,
      'porcentajeDescuento': porcentajeDescuento,
      'valoracion': valoracion,
      'marca': marca,
      'modelo': modelo,
      'formaIngreso': formaIngreso,
      'categoria': categoria,
      'ultimoIngreso': ultimoIngreso,
      'activo': activo ? 1 : 0,
      'imagen': imagen,
    };
  }

  @override
  String toString() {
    return 'Nombre: $nombre, descripcion $descripcion, precio $precio, existencia $existencia, porcentajeDescuento $porcentajeDescuento, valoracion $valoracion, marca $marca, modelo $modelo, formaIngreso $formaIngreso';
  }
}
