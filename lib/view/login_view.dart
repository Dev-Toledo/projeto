import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  // Identificador do Formulário
  final formKey = GlobalKey<FormState>();

  final primaryColor = const Color.fromARGB(255, 0, 0, 0);

  // Controladores dos campos de texto
  final txtValor1 = TextEditingController();
  final txtValor2 = TextEditingController();

  bool _rememberMe = false;
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Plano de Fundo
      body: Container(
        color: const Color.fromARGB(255, 240, 239, 234),
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(50, 60, 50, 60),
            child: Column(
              children: [
                const SizedBox(height: 20),

                // Logo
                const Image(
                  image: AssetImage("lib/images/logo4.png"),
                  width: 200,
                ),
                const SizedBox(height: 30),

                // Texto de identificação de tela => Login
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('Login',
                        style: TextStyle(fontSize: 25, color: primaryColor)),
                  ],
                ),
                const SizedBox(height: 5),

                // Campo e-mail ou usuário
                TextFormField(
                  controller: txtValor1,
                  style: const TextStyle(fontSize: 18),
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    labelText: 'Usuário ou e-mail',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Informe seu e-mail ou nome de usuário';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                // Campo Senha
                TextFormField(
                  controller: txtValor2,
                  style: const TextStyle(fontSize: 18),
                  obscureText: _obscureText,
                  decoration: InputDecoration(
                    labelText: 'Senha',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureText ? Icons.visibility_off : Icons.visibility,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Informe sua senha';
                    } else if (value.length < 6) {
                      return 'A senha deve ter pelo menos 6 caracteres';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                SizedBox(height: 10),

                // Lembre de mim e Esqueci a senha
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        // Checkbox Lembre de mim
                        Checkbox(
                          value: _rememberMe,
                          onChanged: (bool? value) {
                            setState(() {
                              _rememberMe = value!;
                            });
                          },
                          activeColor: Colors.blue,
                          checkColor: Colors.white,
                          fillColor: WidgetStateProperty.resolveWith((states) {
                            return states.contains(WidgetState.selected)
                                ? Colors.blue
                                : null;
                          }),
                        ),
                        Text('Lembre de mim'),
                      ],
                    ),

                    SizedBox(width: 30),

                    // TextButton Esqueci a senha
                    TextButton(
                      onPressed: () {
                        // Código para tratar o clique em "Esqueci minha senha"
                      },
                      child: Text(
                        "Esqueci a senha",
                        style: TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 40),
                // Botão de Login
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(300, 60),
                    backgroundColor: const Color(0xFFF04A00),
                    foregroundColor: Colors.white,
                    textStyle: const TextStyle(fontSize: 20),
                  ),
                  onPressed: () {
                    // Validação do formulário
                    if (formKey.currentState!.validate()) {
                      String username = txtValor1.text;
                      String password = txtValor2.text;

                      // Verifica se o login é do administrador (usuário: admin, senha: 123456)
                      if (username == 'admin' && password == '123456') {
                        // Redireciona para a tela de admin
                        Navigator.pushNamed(context, 'admin');
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Login ou senha inválidos')),
                        );
                      }
                    }
                  },
                  child: const Text('Login'),
                ),
                const SizedBox(height: 15),

                // Botão Cadastro
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(300, 60),
                    backgroundColor: const Color.fromRGBO(122, 124, 125, 1),
                    foregroundColor: Colors.white,
                    textStyle: const TextStyle(fontSize: 20),
                  ),
                  onPressed: () {
                    // Redirecionar para a tela de cadastro
                    Navigator.pushNamed(context, 'cadastro');
                  },
                  child: const Text('Cadastrar'),
                ),

                const SizedBox(height: 20),

                // Botão pequeno para ver itens sem login
                TextButton(
                  onPressed: () {
                    // Redirecionar para a tela de itens sem login
                    Navigator.pushNamed(context, 'itens');
                  },
                  child: const Text(
                    'Ver Itens sem Login',
                    style: TextStyle(
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
