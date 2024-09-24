import 'package:flutter/material.dart';
import 'package:projeto/view/login_view.dart';
import 'package:projeto/view/itens_view.dart';
import 'package:projeto/view/pedidos_view.dart';
import 'package:projeto/view/cadastro_view.dart';
import 'package:projeto/view/splash_view.dart'; // Adicione a importação da tela de carregamento
import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart'; // Import necessário para desktop

void main() {
  // Inicialize o databaseFactory para desktop (sqflite_common_ffi)
  if (!kIsWeb &&
      (defaultTargetPlatform == TargetPlatform.windows ||
          defaultTargetPlatform == TargetPlatform.linux ||
          defaultTargetPlatform == TargetPlatform.macOS)) {
    sqfliteFfiInit();
    databaseFactory =
        databaseFactoryFfi; // Inicializa o factory do banco de dados para desktop
  }

  runApp(DevicePreview(
    enabled: !kReleaseMode,
    builder: (context) => MainApp(),
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

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
      initialRoute: 'splash', // Define a tela inicial como a SplashScreen
      routes: {
        'splash': (context) => const SplashView(), // Rota para a SplashScreen
        'login': (context) => const LoginView(),
        'itens': (context) => const ItensView(),
        'pedidos': (context) => const PedidosView(),
        'cadastro': (context) => const CadastroView(),
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
