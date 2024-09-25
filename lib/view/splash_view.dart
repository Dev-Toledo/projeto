import 'package:flutter/material.dart';
import 'package:projeto/database/db.dart'; // Certifique-se de importar a classe do banco de dados
import 'package:projeto/view/login_view.dart'; // Importa a tela de login


class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _inicializarAnimacao();
    _inicializarApp();
  }

  // Inicializa a animação do logo
  void _inicializarAnimacao() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _animation = Tween<double>(begin: -0.05, end: 0.05).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.repeat(reverse: true); // Balança de um lado para o outro
  }

  // Método para inicializar o app
  Future<void> _inicializarApp() async {
    try {
      print("Iniciando inicialização do banco de dados...");
      await DB.instance.database; // Inicializa o banco de dados

      // Simula um tempo de carregamento
      await Future.delayed(const Duration(seconds: 2));

      print("Banco de dados inicializado com sucesso.");
      // Após a inicialização, navega para a tela de login
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginView()),
      );
    } catch (e, stacktrace) {
      print("Erro ao inicializar a aplicação: $e");
      print("Stacktrace: $stacktrace");
      _mostrarErroCarregamento(e);
    }
  }

  void _mostrarErroCarregamento(dynamic erro) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Erro ao carregar a aplicação: $erro'),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Fundo com a imagem backgroud
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('lib/images/fundo2.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo balançando devagar com sombra branca
                AnimatedBuilder(
                  animation: _animationController,
                  builder: (context, child) {
                    return Transform.rotate(
                      angle: _animation.value,
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white.withOpacity(0.7),
                              blurRadius: 20,
                              spreadRadius: 5,
                            ),
                          ],
                        ),
                        child: Image.asset(
                          'lib/images/logo_transparente.png', // Imagem do logo
                          width: 300,
                          height: 300,
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 20),
                const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Carregando...',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
