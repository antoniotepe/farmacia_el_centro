import 'package:farmacia_el_centro/src/pages/salir_app.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import 'package:farmacia_el_centro/src/pages/home_page.dart';

class Agregar extends StatefulWidget {
  @override
  State<Agregar> createState() => _AgregarState();
}

class _AgregarState extends State<Agregar> {
  TextEditingController codigoController = TextEditingController();
  TextEditingController descripcionController = TextEditingController();
  TextEditingController cantidadController = TextEditingController();
  TextEditingController fechaVencimientoController = TextEditingController();
  TextEditingController precioUnitarioController = TextEditingController();
  TextEditingController totalController = TextEditingController();
  TextEditingController margenGananciaController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agregar Medicamento'),
        automaticallyImplyLeading: false,
        actions: [
          SalirApp(),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
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
                  initialDate: DateTime.now(),
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
            ElevatedButton(
              onPressed: () async {             
                // Calcular el total
                double margenganancia = double.tryParse(margenGananciaController.text) ?? 0.0;
                double cantidad = double.tryParse(cantidadController.text) ?? 0.0;
                double precioUnitario = double.tryParse(precioUnitarioController.text) ?? 0.0;
                double total = (cantidad * precioUnitario) * margenganancia;

                // Agregar los datos a la base de datos
                final response = await http.post(
                  Uri.parse('https://dbfarmacia.herokuapp.com/medicamentos'),
                  body: {
                    'codigo' : codigoController.text,
                    'descripcion': descripcionController.text,
                    'cantidad': cantidadController.text,
                    'fechaVencimiento': DateFormat('yyyy-MM-dd').format(DateFormat('dd/MM/yyyy').parse(fechaVencimientoController.text)),
                    'precioUnitario': precioUnitarioController.text,
                    'total': total.toStringAsFixed(2), // Convertir el total a una cadena con dos decimales
                    'margenGanancia' : margenGananciaController.text,
                  },
                );

                if (response.statusCode == 201) {
                  // Éxito al agregar los datos a la base de datos
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                  );
                } else {
                  // Manejar error al agregar los datos a la base de datos
                }
              },
              child: Text('Guardar'),
            ),
          ],
        ),
      ),
    );
  }
}
