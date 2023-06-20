import 'package:flutter/material.dart';
import 'package:farmacia_el_centro/src/pages_admin/btn_navigationAD.dart';
import 'package:farmacia_el_centro/src/pages_admin/routesAD.dart';

class HomePageAdmin extends StatefulWidget {
  const HomePageAdmin({super.key});

  @override
  State<HomePageAdmin> createState() => _HomePageAdminState();
}

class _HomePageAdminState extends State<HomePageAdmin> {
  int index = 0;
  BTNnavigationAD ?myBTN;

  @override
  void initState() {
    myBTN = BTNnavigationAD(currentIndex: (i){
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
      body: RoutesAD(index: index),
    );
  }
}