import 'package:flutter/material.dart';
import 'package:projeto/view/login_view.dart';
import 'package:projeto/view/password_view.dart';
import 'package:projeto/view/admin_view.dart';
import 'package:projeto/view/itens_view.dart';
import 'package:projeto/view/pedidos_view.dart';
import 'package:projeto/view/cadastro_view.dart';
import 'package:projeto/view/splash_view.dart'; // Importa a tela de splash
import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';

//import 'package:sqflite_common_ffi/sqflite_ffi.dart'; // Import necessário para desktop

void main() {
  // Inicialize o databaseFactory para desktop (sqflite_common_ffi)
  if (!kIsWeb &&
      (defaultTargetPlatform == TargetPlatform.windows ||
          defaultTargetPlatform == TargetPlatform.linux ||
          defaultTargetPlatform == TargetPlatform.macOS)) {
    //sqfliteFfiInit();
    //databaseFactory =
    //databaseFactoryFfi; // Inicializa o factory do banco de dados para desktop (naáo funcion ou
  }

  runApp(DevicePreview(
    enabled: !kReleaseMode, // Desativa o DevicePreview em produção
    builder: (context) =>
        const MainApp(), // Defina const para widgets imutáveis
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key}); // Utiliza o super parameter para a key

  @override
  Widget build(BuildContext context) {
    var textTheme = const TextTheme(
      bodyLarge: TextStyle(
          color: Colors.black, fontSize: 16), // bodyLarge é o texto principal
      bodyMedium: TextStyle(
          color: Colors.black,
          fontSize: 14), // bodyMedium para texto secundário
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'login', // Define a splash view como rota inicial
      routes: {
        'splash': (context) => const SplashView(),
        'login': (context) => const LoginView(),
        'itens': (context) => const ItensView(),
        'pedidos': (context) => const PedidosView(),
        'cadastro': (context) => const CadastroView(),
        'admin': (context) => const AdminView(),
        'senha': (context) => const ForgotPasswordView(),
      },
      builder: DevicePreview.appBuilder,
      theme: ThemeData(
        primarySwatch: Colors.orange,
        textTheme: textTheme,
      ),
      onUnknownRoute: (RouteSettings settings) {
        return MaterialPageRoute(builder: (_) => const LoginView());
      },
    );
  }
}
