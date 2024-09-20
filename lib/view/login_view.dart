// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  //Identificador do Formulário
  final formKey = GlobalKey<FormState>();

  final primaryColor = Color.fromARGB(255, 0, 0, 0);

  //Controladores dos campos de texto
  final txtValor1 = TextEditingController();
  final txtValor2 = TextEditingController();

  bool _rememberMe = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        //decoration: BoxDecoration(
        // image: DecorationImage(
        // image: AssetImage('lib/images/fundo.jpeg'),
        //fit: BoxFit.cover,
        //colorFilter: ColorFilter.mode(
        //Colors.white.withOpacity(0.6),
        // BlendMode.dstATop,
        //),
        // ),
        //),
        child: Form(
          key: formKey,
          child: Padding(
              padding: const EdgeInsets.fromLTRB(50, 60, 50, 60),
              child: Column(children: [
                SizedBox(height: 50),
                //Icon(Icons.lunch_dining, size: 160, color: primaryColor),
                Image(image: AssetImage("lib/images/logo.png")),

                SizedBox(height: 30),

                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('Login',
                        style: TextStyle(fontSize: 30, color: primaryColor)),
                  ],
                ),

                SizedBox(height: 5),

                TextFormField(
                  controller: txtValor1,
                  style: TextStyle(fontSize: 18),
                  decoration: InputDecoration(
                    labelText: 'Usuário ou e-mail',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),

                SizedBox(height: 20),

                TextFormField(
                  controller: txtValor2,
                  style: TextStyle(fontSize: 18),
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Senha',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Checkbox(
                      value: _rememberMe,
                      onChanged: (bool value) {
                        setState(() {
                          _rememberMe = value;
                        });
                      },
                      activeColor: Colors.blue,
                      checkColor: Colors.white,
                      fillColor: MaterialStateProperty.resolveWith((states) {
                        return states.contains(MaterialState.selected)
                            ? Colors.blue
                            : null;
                      }),
                    ),
                    TextButton(
                      onPressed: () {
                        // Código para tratar o clique em "Esqueci minha senha"
                      },
                      child: Text(
                        "Esqueci minha senha",
                        style: TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 40),

                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(150, 60),
                      backgroundColor: primaryColor,
                      foregroundColor: Colors.white,
                      textStyle: TextStyle(fontSize: 20),
                    ),
                    onPressed: () {},
                    child: Text('Login')),
              ])),
        ),
      ),
    );
  }
}
