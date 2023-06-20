import 'package:flutter/material.dart';


class BTNnavigationAD extends StatefulWidget {
  final Function currentIndex;
  const BTNnavigationAD({Key? key, required this.currentIndex}) : super(key: key);

  @override
  State<BTNnavigationAD> createState() => _BTNnavigationADState();
}

class _BTNnavigationADState extends State<BTNnavigationAD> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: index,
      onTap: (int i) {
        setState(() {
          index = i;
          widget.currentIndex(i);
        });
      },
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.lightBlue,
      selectedFontSize: 15.0,
      unselectedFontSize: 12.0,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Inicio ADMIN'
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.inventory_sharp),
          label: 'Inventario ADMIN'
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.add_circle),
          label: 'Agregar ADMIN',
        ),
      ]
    );
  }
}