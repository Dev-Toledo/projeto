// splash_view.dart
import 'package:flutter/material.dart';
import 'package:projeto/database/db.dart'; // Certifique-se de importar a classe do banco de dados
import 'package:projeto/view/login_view.dart'; // Importa a tela de login

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    _inicializarApp();
  }

  // Método para inicializar os elementos do app (como o banco de dados)
  Future<void> _inicializarApp() async {
    // Exibe o processo de inicialização do banco de dados
    await DB.instance.database; // Utilize a instância da classe DB

    // Simula um tempo de carregamento para exibir a tela de splash (opcional)
    await Future.delayed(Duration(seconds: 3));

    // Após a inicialização, navega para a tela de login
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginView()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange, // Cor de fundo da splash view
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo ou ícone da sua aplicação
            Icon(Icons.restaurant_menu, size: 100, color: Colors.white),
            SizedBox(height: 20),
            // Indicador de progresso (carregamento)
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
            SizedBox(height: 20),
            // Texto que indica o progresso
            Text(
              'Carregando...',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
