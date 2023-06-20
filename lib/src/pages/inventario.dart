import 'package:farmacia_el_centro/src/pages/salir_app.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class Inventario extends StatefulWidget {
  const Inventario({Key? key}) : super(key: key);

  @override
  State<Inventario> createState() => _InventarioState();
}

class _InventarioState extends State<Inventario> {
  List<Medicamento> listaMedicamentos = [];

  @override
  void initState() {
    super.initState();
    obtenerMedicamentos();
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
          SalirApp(),
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
                Text('Cantidad: ${medicamento.cantidad}'),
                Text('Fecha de vencimiento: ${DateFormat('dd/MM/yyyy').format(medicamento.fechaVencimiento)}'),
                Text('Precio unitario: Q${medicamento.precioUnitario.toStringAsFixed(2)}'),
                Text('Total: Q${medicamento.total.toStringAsFixed(2)}'),
              ],
            ),
          );
        },
      ),
    );
  }
}

class Medicamento {
  final int codigo;
  int cantidad;
  String descripcion;
  DateTime fechaVencimiento;
  double precioUnitario;
  double total;
  bool eliminado;

  Medicamento({
    required this.codigo,
    required this.cantidad,
    required this.descripcion,
    required this.fechaVencimiento,
    required this.precioUnitario,
    required this.total,
    this.eliminado = false,
  });
}
