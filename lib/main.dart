import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:projeto/view/login_view.dart';

void main() {
  runApp(
    DevicePreview(builder: (context) => const MainApp()),
  );
}
//git config --global user.name "Caio Toledo de Sousa"
class MainApp extends StatelessWidget {
  const MainApp({super.key});
// teste
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'login',
      routes: {
        'login': (context) => LoginView(),
      },
    );
  }
}