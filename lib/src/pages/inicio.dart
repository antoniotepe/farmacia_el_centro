import 'package:farmacia_el_centro/src/pages/salir_app.dart';
import 'package:flutter/material.dart';

class Inicio extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Farmacia El Centro'),
        automaticallyImplyLeading: false,
        centerTitle: true,
        actions: [
          SalirApp(),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 5,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              constraints: BoxConstraints(
                maxWidth: 300, // Establecer el ancho máximo del contenedor
              ),
              child: Image(
                image: AssetImage('assets/logo_de_farmacia.png'),
                fit: BoxFit.contain, // Ajustar la imagen dentro del contenedor
              ),
            ),
            SizedBox(height: 50),
            Text(
              'Bienvenidos',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
