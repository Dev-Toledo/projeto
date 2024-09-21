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
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      // Plano de Fundo
      body: Container(
         decoration: BoxDecoration(
          image: DecorationImage(
           image: AssetImage('lib/images/fundo2.png'),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
          Colors.white.withOpacity(0.6),
           BlendMode.dstATop,
          ),
         ),
        ),


        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(50, 60, 50, 60),
            child: Column(children: [

              SizedBox(height: 20),

              // Logo
              Image(image: AssetImage("lib/images/logo2.png"),
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

              // Campo usuário ou e-mail
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
                validator: (value){
                    if (value == null){
                      return 'Informe seu usuário ou e-mail';
                    } else if (value.isEmpty){
                      return 'Informe seu usuário ou e-mail';
                    } else if (double.tryParse(value)==null){
                      return 'Informe um valor NUMÉRICO';
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
                validator: (value){
                    if (value == null){
                      return 'Informe sua senha';
                    } else if (value.isEmpty){
                      return 'Informe sua senha';
                    } else if (double.tryParse(value)==null){
                      return 'Informe um valor NUMÉRICO';
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
                        fillColor: WidgetStateProperty.resolveWith((states) {
                          return states.contains(WidgetState.selected)
                              ? Colors.blue
                              : null;
                        }),
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

              SizedBox(height: 40),

              // Botão de Login
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(150, 60),
                    backgroundColor: primaryColor,
                    foregroundColor: Colors.white,
                    textStyle: TextStyle(fontSize: 20),
                  ),
                  onPressed: () {
                    // Validação
                    if(formKey.currentState!.validate()){}
                  },
                  child: Text('Login')),
            ]),
          ),
        ),
      ),
    );
  }
}