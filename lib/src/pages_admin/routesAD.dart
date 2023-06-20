import 'package:flutter/material.dart';

import 'package:farmacia_el_centro/src/pages_admin/agregarAD.dart';
import 'package:farmacia_el_centro/src/pages_admin/inventarioAD.dart';
import 'package:farmacia_el_centro/src/pages_admin/inicioAD.dart';


class RoutesAD extends StatelessWidget {
  final int index;
  const RoutesAD({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> myList = [
      inicioAD(),
      inventarioAD(),
      agregarAD(),
    ];


    return myList[index];
  }
}