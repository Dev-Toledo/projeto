// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  // Identificador do Formulário
  final formKey = GlobalKey<FormState>();

  final primaryColor = Color.fromARGB(255, 0, 0, 0);

  // Controladores dos campos de texto
  final txtValor1 = TextEditingController();
  final txtValor2 = TextEditingController();

  bool _rememberMe = false;
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Plano de Fundo
      body: Container(
        color: const Color.fromARGB(255, 240, 239, 234),

        /*decoration: BoxDecoration(
          image: DecorationImage(
           image: AssetImage('lib/images/fundo2.png'),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
          Colors.white.withOpacity(0.6),
           BlendMode.dstATop,
          ),
         ),
        ),*/

        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(50, 60, 50, 60),
            child: Column(children: [
              SizedBox(height: 20),

              // Logo
              Image(
                image: AssetImage("lib/images/logo4.png"),
                width: 200,
              ),

              SizedBox(height: 30),

              // Texto de identificação de tela => Login
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('Login',
                      style: TextStyle(fontSize: 25, color: primaryColor)),
                ],
              ),

              SizedBox(height: 5),

              // Campo e-mail ou usuário
              TextFormField(
                controller: txtValor1,
                style: TextStyle(fontSize: 18),
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  labelText: 'Usuário ou e-mail',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Informe seu e-mail ou nome de usuário';
                  }
                  return null;
                },
              ),

              SizedBox(height: 20),

              // Campo Senha
              TextFormField(
                controller: txtValor2,
                style: TextStyle(fontSize: 18),
                obscureText: _obscureText,
                decoration: InputDecoration(
                  labelText: 'Senha',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Informe sua senha';
                  } else if (value.length < 6) {
                    return 'A senha deve ter pelo menos 6 caracteres';
                  }
                  return null;
                },
              ),

              SizedBox(height: 10),

              // Lembre de mim e Esqueci a senha
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // Checkbox Lembre de mim
                      Checkbox(
                        value: _rememberMe,
                        onChanged: (bool? value) {
                          setState(() {
                            _rememberMe = value!;
                          });
                        },
                        activeColor: Colors.blue,
                        checkColor: Colors.white,
                      ),
                      Text('Lembre de mim'),
                    ],
                  ),
                  SizedBox(width: 30),
                  // TextButton Esqueci a senha
                  TextButton(
                    onPressed: () {
                      // Código para tratar o clique em "Esqueci minha senha"
                    },
                    child: Text(
                      "Esqueci a senha",
                      style: TextStyle(
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 50),

              // Botão de Login
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(300, 60),
                  backgroundColor: const Color(0xFFF04A00),
                  foregroundColor: Colors.white,
                  textStyle: TextStyle(fontSize: 20),
                ),
                onPressed: () {
                  // Validação
                  if (formKey.currentState!.validate()) {
                    String username = txtValor1.text;
                    String password = txtValor2.text;

                    // Verifica se o login é do administrador
                    if ((username == 'admin' && password == '123456') ||
                        RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(username)) {
                      // Redireciona para a tela de itens ou página de administração
                      Navigator.pushNamed(context, '/itens');
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Login ou senha inválidos'),
                        ),
                      );
                    }
                  }
                },
                child: Text('Login'),
              ),

              SizedBox(height: 15),

              // Botão Cadastro
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(300, 60),
                  backgroundColor: const Color.fromARGB(255, 122, 124, 125),
                  foregroundColor: Colors.white,
                  textStyle: TextStyle(fontSize: 20),
                ),
                onPressed: () {
                  // Redirecionar para a tela de cadastro
                  Navigator.pushNamed(context, '/cadastro');
                },
                child: Text('Cadastrar'),
              ),

              SizedBox(height: 20),

              // Botão pequeno para ver itens sem login
              TextButton(
                onPressed: () {
                  // Redirecionar para a tela de itens sem login
                  Navigator.pushNamed(context, '/itens');
                },
                child: Text(
                  'Ver Itens sem Login',
                  style: TextStyle(
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
