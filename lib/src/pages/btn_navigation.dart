import 'package:flutter/material.dart';


class BTNnavigation extends StatefulWidget {
  final Function currentIndex;
  const BTNnavigation({Key? key, required this.currentIndex}) : super(key: key);

  @override
  State<BTNnavigation> createState() => _BTNnavigationState();
}

class _BTNnavigationState extends State<BTNnavigation> {
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
          label: 'Inicio'
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.inventory_sharp),
          label: 'Inventario'
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.add_circle),
          label: 'Agregar',
        ),
      ]
    );
  }
}