import 'package:flutter/material.dart';
import 'package:projeto/view/login_view.dart';
import 'package:projeto/view/itens_view.dart';
import 'package:projeto/view/pedidos_view.dart';
import 'package:projeto/view/cadastro_view.dart';
import 'package:projeto/view/splash_view.dart'; // Importa a tela de splash
import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart'; // Importa para usar kReleaseMode

void main() {
  runApp(DevicePreview(
    enabled: !kReleaseMode, // Desativa o DevicePreview em produção
    builder: (context) => const MainApp(), // Defina const para widgets imutáveis
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key}); // Utiliza o super parameter para a key

  @override
  Widget build(BuildContext context) {
    var textTheme = const TextTheme(
      bodyLarge: TextStyle(color: Colors.black, fontSize: 16), // bodyLarge é o texto principal
      bodyMedium: TextStyle(color: Colors.black, fontSize: 14), // bodyMedium para texto secundário
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'splash', // Define a splash view como rota inicial
      routes: {
        'splash': (context) => const SplashView(),
        'login': (context) => const LoginView(),
        'itens': (context) => const ItensView(),
        'pedidos': (context) => const PedidosView(),
        'cadastro': (context) => const CadastroView(),
      },
      builder: DevicePreview.appBuilder,
      theme: ThemeData(
        primarySwatch: Colors.orange, // Define o tema principal
        textTheme: textTheme,
      ),
      onUnknownRoute: (RouteSettings settings) {
        return MaterialPageRoute(builder: (_) => const LoginView());
      },
    );
  }
}





//git config --global user.name "Nome Completo"
//git config --global user.email "e-mail@dominio.com"
