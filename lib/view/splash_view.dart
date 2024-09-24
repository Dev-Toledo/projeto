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
      duration: Duration(seconds: 2),
    );
    _animation = Tween<double>(begin: -0.05, end: 0.05).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.repeat(
        reverse: true); // Balança de um lado para o outro
  }

  // Método para inicializar os elementos do app (como o banco de dados)
  Future<void> _inicializarApp() async {
    try {
      await DB.instance.database; // Inicializa o banco de dados
      // Simula um tempo de carregamento
      await Future.delayed(Duration(seconds: 2));

      // Após a inicialização, navega para a tela de login
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginView()),
      );
    } catch (e) {
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
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('lib/images/fundo2.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Conteúdo da splash view
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
                          shape: BoxShape.circle, // Define o formato da sombra
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white.withOpacity(
                                  0.7), // Cor branca com transparência
                              blurRadius:
                                  20, // Aumente ou diminua o raio da sombra
                              spreadRadius:
                                  9, // Aumenta o efeito de expansão da sombra
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
                SizedBox(height: 20),
                CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
                SizedBox(height: 20),
                Text(
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
