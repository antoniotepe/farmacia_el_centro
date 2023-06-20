import 'package:flutter/material.dart';
import 'package:farmacia_el_centro/src/pages/home_page.dart';
import '../pages_admin/home_page2.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      appBar: AppBar(
        title: Text('Login'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
        padding: EdgeInsets.all(20.0),
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
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Usuario',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20.0),
            TextFormField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Contraseña',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                String email = _emailController.text;
                String password = _passwordController.text;

                // Verificar las credenciales ingresadas
                if (email == 'gabriela' && password == '1234') {
                  // Navegar a la página de inicio si las credenciales son correctas
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomePage(),
                    ),
                  );
                } else if(email == 'admin' && password == '12345') {
                  // Navegar a la página inicio2 de admin si las credenciales son correctas
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomePageAdmin(),
                    ),
                  );
                } else {
                  // Mostrar un diálogo de error si las credenciales son incorrectas
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Error de inicio de sesión'),
                      content: Text('Credenciales incorrectas. Por favor, inténtalo de nuevo.'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text('Aceptar'),
                        ),
                      ],
                    ),
                  );
                }
              },
              child: Text('Login'),
            ),
          ],
        ),
      ),
    ),
    );
  }
}
