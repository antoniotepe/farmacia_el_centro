import 'package:farmacia_el_centro/src/pages_admin/salir_appAD.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class inventarioAD extends StatefulWidget {
  const inventarioAD({Key? key}) : super(key: key);

  @override
  State<inventarioAD> createState() => _inventarioADState();
}

class _inventarioADState extends State<inventarioAD> {
  List<Medicamento> listaMedicamentos = [];

  @override
  void initState() {
    super.initState();
    obtenerMedicamentos();
  }


  void descontarCantidadMedicamento(Medicamento medicamento) {
    final currentContext = context;
    showDialog(
      context: currentContext,
      builder: (context) {
        TextEditingController CodigoController = TextEditingController();
        TextEditingController descripcionController = TextEditingController();
        TextEditingController cantidadController = TextEditingController();
        TextEditingController fechaVencimientoController = TextEditingController();
        TextEditingController precioUnitarioController = TextEditingController();
        TextEditingController margenGananciaController = TextEditingController();

        CodigoController.text = medicamento.codigo.toString();
        descripcionController.text = medicamento.descripcion;
        cantidadController.text = medicamento.cantidad.toString();
        fechaVencimientoController.text = DateFormat('dd/MM/yyyy').format(medicamento.fechaVencimiento);
        precioUnitarioController.text = medicamento.precioUnitario.toString();
        margenGananciaController.text = medicamento.margenganancia.toString();

        return AlertDialog(
          title: Text('Descontar Medicamento'),
          content: SingleChildScrollView( 
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: cantidadController,
                decoration: InputDecoration(labelText: 'Cantidad'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Cerrar el cuadro de diálogo
              },
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () async {
                // Actualizar los datos en la base de datos
                final url = 'https://dbfarmacia.herokuapp.com/medicamentos/${medicamento.codigo}';
                final response = await http.put(
                  Uri.parse(url),
                  body: {
                    'codigo' : CodigoController.text,
                    'descripcion': descripcionController.text,
                    'cantidad': cantidadController.text,
                    'fechaVencimiento': DateFormat('yyyy-MM-dd').format(medicamento.fechaVencimiento),
                    'precioUnitario': precioUnitarioController.text,
                    'total': (medicamento.cantidad * medicamento.precioUnitario).toString(),
                    'margenGanancia' : margenGananciaController.text,
                  },
                );

                if (response.statusCode == 200) {
                  // Éxito al actualizar los datos en la base de datos
                  setState(() {
                    // Actualizar los datos localmente
                    medicamento.codigo = int.tryParse(CodigoController.text) ?? 0;
                    medicamento.descripcion = descripcionController.text;
                    medicamento.cantidad = int.tryParse(cantidadController.text) ?? 0;
                    medicamento.fechaVencimiento = DateFormat('dd/MM/yyyy').parse(fechaVencimientoController.text);
                    medicamento.precioUnitario = double.tryParse(precioUnitarioController.text) ?? 0.0;
                    medicamento.total = (medicamento.cantidad * medicamento.precioUnitario) * medicamento.margenganancia;
                    medicamento.margenganancia = double.tryParse(margenGananciaController.text) ?? 0;
                  });
                  Navigator.of(context).pop(); // Cerrar el cuadro de diálogo
                } else {
                  // Manejar error al actualizar los datos en la base de datos
              }
            },
            child: Text('Guardar'),
          ),
          ],
        );
      },
    );
  }





  void editarMedicamento(Medicamento medicamento) {
    final currentContext = context;
    showDialog(
      context: currentContext,
      builder: (context) {
        TextEditingController CodigoController = TextEditingController();
        TextEditingController descripcionController = TextEditingController();
        TextEditingController cantidadController = TextEditingController();
        TextEditingController fechaVencimientoController = TextEditingController();
        TextEditingController precioUnitarioController = TextEditingController();
        TextEditingController margenGananciaController = TextEditingController();

        CodigoController.text = medicamento.codigo.toString();
        descripcionController.text = medicamento.descripcion;
        cantidadController.text = medicamento.cantidad.toString();
        fechaVencimientoController.text = DateFormat('dd/MM/yyyy').format(medicamento.fechaVencimiento);
        precioUnitarioController.text = medicamento.precioUnitario.toString();
        margenGananciaController.text = medicamento.margenganancia.toString();

        return AlertDialog(
          title: Text('Editar Medicamento'),
          content: SingleChildScrollView( 
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(  
                controller: CodigoController,
                decoration: InputDecoration(labelText: 'Codigo'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: descripcionController,
                decoration: InputDecoration(labelText: 'Descripción'),
              ),
              TextFormField(
                controller: cantidadController,
                decoration: InputDecoration(labelText: 'Cantidad'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: fechaVencimientoController,
                decoration: InputDecoration(labelText: 'Fecha de Vencimiento'),
                onTap: () async {
                  final DateTime? fechaSeleccionada = await showDatePicker(
                    context: context,
                    initialDate: medicamento.fechaVencimiento,
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2100),
                  );
                  if (fechaSeleccionada != null) {
                    fechaVencimientoController.text = DateFormat('dd/MM/yyyy').format(fechaSeleccionada);
                  }
                },
              ),
              TextFormField(
                controller: precioUnitarioController,
                decoration: InputDecoration(labelText: 'Precio Unitario'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: margenGananciaController,
                decoration: InputDecoration(labelText: 'Margen de Ganancia'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Cerrar el cuadro de diálogo
              },
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () async {
                // Actualizar los datos en la base de datos
                final url = 'https://dbfarmacia.herokuapp.com/medicamentos/${medicamento.codigo}';
                final response = await http.put(
                  Uri.parse(url),
                  body: {
                    'codigo' : CodigoController.text,
                    'descripcion': descripcionController.text,
                    'cantidad': cantidadController.text,
                    'fechaVencimiento': DateFormat('yyyy-MM-dd').format(medicamento.fechaVencimiento),
                    'precioUnitario': precioUnitarioController.text,
                    'total': (medicamento.cantidad * medicamento.precioUnitario).toString(),
                    'margenGanancia' : margenGananciaController.text,
                  },
                );

                if (response.statusCode == 200) {
                  // Éxito al actualizar los datos en la base de datos
                  setState(() {
                    // Actualizar los datos localmente
                    medicamento.codigo = int.tryParse(CodigoController.text) ?? 0;
                    medicamento.descripcion = descripcionController.text;
                    medicamento.cantidad = int.tryParse(cantidadController.text) ?? 0;
                    medicamento.fechaVencimiento = DateFormat('dd/MM/yyyy').parse(fechaVencimientoController.text);
                    medicamento.precioUnitario = double.tryParse(precioUnitarioController.text) ?? 0.0;
                    medicamento.total = (medicamento.cantidad * medicamento.precioUnitario) * medicamento.margenganancia;
                    medicamento.margenganancia = double.tryParse(margenGananciaController.text) ?? 0;
                  });
                  Navigator.of(context).pop(); // Cerrar el cuadro de diálogo
                } else {
                  // Manejar error al actualizar los datos en la base de datos
              }
            },
            child: Text('Guardar'),
          ),
          ],
        );
      },
    );
  }

  void eliminarMedicamento(Medicamento medicamento) {
    final currentContext = context;
    showDialog(
      context: currentContext,
      builder: (context) {
        return AlertDialog(
          title: Text('Eliminar Medicamento'),
          content: Text('¿Estás seguro de que deseas eliminar este medicamento?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Cerrar el cuadro de diálogo
              },
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  medicamento.eliminado = true;
                  listaMedicamentos.removeWhere((med) => med.codigo == medicamento.codigo); // Eliminar el medicamento de la lista
                });
                Navigator.of(context).pop(); // Cerrar el cuadro de diálogo
              },
              child: Text('Eliminar'),
            ),
          ],
        );
      },
    );
  }

  Future<void> obtenerMedicamentos() async {
    final response = await http.get(Uri.parse('https://dbfarmacia.herokuapp.com/medicamentos'));

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      for (var item in jsonResponse) {
        final medicamento = Medicamento(
          codigo: item['codigo'],
          cantidad: item['cantidad'],
          descripcion: item['descripcion'],
          fechaVencimiento: DateTime.parse(item['fechaVencimiento']),
          precioUnitario: double.tryParse(item['precioUnitario'].toString()) ?? 0.0,
          total: double.tryParse(item['total'].toString()) ?? 0.0,
          margenganancia: double.tryParse(item['margenGanancia'].toString()) ?? 0.0,  
        );
        listaMedicamentos.add(medicamento);
      }
      if (mounted) {
          setState(() {
            // Actualizar la lista de medicamentos y volver a renderizar la interfaz
            listaMedicamentos;
          });
      }
    } else {
      // Manejo de error si la solicitud no fue exitosa
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inventario de Medicamentos'),
        automaticallyImplyLeading: false,
        actions: [
          SalirAppAD(),
        ],
      ),
      body: ListView.builder(
        itemCount: listaMedicamentos.length,
        itemBuilder: (context, index) {
          final medicamento = listaMedicamentos[index];
          if (medicamento.eliminado) {
            return Container(); // No mostrar medicamentos eliminados
          }
          return ListTile(
            title: Text(medicamento.descripcion),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Codigo: ${medicamento.codigo}'),
                Text('Cantidad: ${medicamento.cantidad}'),
                Text('Fecha de vencimiento: ${DateFormat('dd/MM/yyyy').format(medicamento.fechaVencimiento)}'),
                Text('Precio unitario: Q${medicamento.precioUnitario.toStringAsFixed(2)}'),
                Text('Total: Q${medicamento.total.toStringAsFixed(2)}'),
                Text('Margen de Ganancia ${medicamento.margenganancia}'),
              ],
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () => editarMedicamento(medicamento),
                  icon: Icon(Icons.edit_sharp),
                ),
                IconButton(
                  onPressed: () => eliminarMedicamento(medicamento),
                  icon: Icon(Icons.delete_sharp),
                ),
                IconButton(
                  onPressed: () => descontarCantidadMedicamento(medicamento),
                  icon: Icon(Icons.remove),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class Medicamento {
   int codigo;
  int cantidad;
  String descripcion;
  DateTime fechaVencimiento;
  double precioUnitario;
  double total;
  double margenganancia;
  bool eliminado;

  Medicamento({
    required this.codigo,
    required this.cantidad,
    required this.descripcion,
    required this.fechaVencimiento,
    required this.precioUnitario,
    required this.total,
    required this.margenganancia,
    this.eliminado = false,
  });
}
