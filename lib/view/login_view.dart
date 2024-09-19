// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {

  //Identificador do Formulário
  var formKey = GlobalKey<FormState>();

  var primaryColor = Color.fromARGB(255, 0, 0, 0);

  //Controladores dos campos de texto
  var txtValor1 = TextEditingController();
  var txtValor2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: 
      Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('lib/images/fundo2.jpg'),
             fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.white.withOpacity(0.6), 
              BlendMode.dstATop,
           ),
          ),
        ),
        child: Form(key: formKey, child: Padding(
            padding: const EdgeInsets.fromLTRB(50,60,50,60),
            child: Column(
              children: [
                //Icon(Icons.lunch_dining, size: 160, color: primaryColor),
                Image(image: AssetImage("lib/images/logo.png")),
        
                Text('Podrão Gourmet', style: TextStyle(fontSize: 30, color: primaryColor)),
                
                SizedBox(height: 30),
          
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
        
                  onPressed: (){}, 
                  child: Text('Login')
                ),
              ]
            )
          ),
        ),
      ),
    );
  }
}