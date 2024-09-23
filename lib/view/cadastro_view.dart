import 'package:flutter/material.dart';

class CadastroView extends StatelessWidget {
  const CadastroView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro'),
      ),
      body: Center(
        child: Text(
            'Tela de Cadastro'), // Aqui você coloca o formulário de cadastro
      ),
    );
  }
}
