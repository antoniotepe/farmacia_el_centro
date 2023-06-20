
import 'package:flutter/material.dart';

import 'package:farmacia_el_centro/src/pages/agregar.dart';
import 'package:farmacia_el_centro/src/pages/inventario.dart';
import 'package:farmacia_el_centro/src/pages/inicio.dart';

class Routes extends StatelessWidget {
  final int index;
  const Routes({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> myList = [
      Inicio(),
      Inventario(),
      Agregar(),
    ];


    return myList[index];
  }
}