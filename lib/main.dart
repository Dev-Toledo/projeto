import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:projeto/view/login_view.dart';
import 'package:projeto/view/itens_view.dart'; // Adicione esta linha para a tela de itens
import 'package:projeto/view/cadastro_view.dart'; // Adicione esta linha para a tela de cadastro

void main() {
  runApp(
    DevicePreview(builder: (context) => const MainApp()),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'login',
      routes: {
        'login': (context) => const LoginView(),
        'itens': (context) => const ItensView(), // Rota para a tela de itens
        'cadastro': (context) =>
            const CadastroView(), // Rota para a tela de cadastro
      },
      builder: DevicePreview.appBuilder, // Adiciona o builder do DevicePreview
    );
  }
}
