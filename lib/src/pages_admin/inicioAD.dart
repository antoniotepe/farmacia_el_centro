import 'package:farmacia_el_centro/src/pages_admin/salir_appAD.dart';
import 'package:flutter/material.dart';


class inicioAD extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Farmacia El centro'),
        automaticallyImplyLeading: false,
        centerTitle: true,
        actions: [
          SalirAppAD()
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
                  ) 
                ]
              ),
              constraints: BoxConstraints(
                maxHeight: 300 // Establecer el ancho maximo del contenedor
              ),
              child: Image(
                image: AssetImage('assets/logo_de_farmacia.png'),
                fit: BoxFit.contain, // Ajustar la imagen dentro del contenedor,
              ),
            ),
            SizedBox(height: 50),
            Text(
              'Bienvenido Administrador',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}