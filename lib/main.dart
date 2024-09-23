import 'package:flutter/material.dart';
import 'package:projeto/view/login_view.dart';
import 'package:projeto/view/itens_view.dart'; // Importa a tela de itens
import 'package:projeto/view/pedidos_view.dart';
import 'package:device_preview/device_preview.dart';
import 'package:projeto/view/cadastro_view.dart';

void main() {
  runApp(DevicePreview(
    builder: (context) => MainApp(),
  ));
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'login',
      routes: {
        'login': (context) => const LoginView(),
        'itens': (context) => const ItensView(), // Rota para a tela de itens
        'pedidos': (context) => const PedidosView(),
        'cadastro': (context) => const CadastroView(),
      },
      builder: DevicePreview.appBuilder,
    );
  }
}


//git config --global user.name "Nome Completo"
//git config --global user.email "e-mail@dominio.com"
