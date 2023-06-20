import 'package:flutter/material.dart';

import 'package:farmacia_el_centro/src/pages/login_page.dart';

void main() => runApp( MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Farmacia El Centro',
      theme: ThemeData(
        primaryColor: Colors.deepPurpleAccent
      ),
      debugShowCheckedModeBanner: false,

      home: LoginPage(),
    );
  }
}