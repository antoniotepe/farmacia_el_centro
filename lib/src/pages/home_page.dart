import 'package:flutter/material.dart';
import 'package:farmacia_el_centro/src/pages/btn_navigation.dart';
import 'package:farmacia_el_centro/src/pages/routes.dart';


class HomePage extends StatefulWidget {

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int index = 0;
  BTNnavigation ?myBTN;

  @override
  void initState() {

    myBTN = BTNnavigation(currentIndex: (i){
      setState(() {
        index = i;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: myBTN,
      body: Routes(index: index),
    );
  }
}