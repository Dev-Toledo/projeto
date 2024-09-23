import 'package:flutter/material.dart';

class ItensView extends StatelessWidget {
  const ItensView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Itens Disponíveis'),
      ),
      body: Center(
        child: Text('Lista de Itens...'), // Aqui vai sua lista de itens
      ),
    );
  }
}
