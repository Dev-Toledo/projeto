import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:projeto/database/db.dart'; // Certifique-se de ter importado seu arquivo de banco de dados

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await testarConexaoComBancoDeDados(); // Teste de conexão ao iniciar o app
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Teste de Conexão com Banco de Dados'),
        ),
        body: const Center(
          child: Text('Conexão bem-sucedida! Verifique o log para mais detalhes.'),
        ),
      ),
    );
  }
}

// Função para testar a conexão com o banco de dados
Future<void> testarConexaoComBancoDeDados() async {
  try {
    Database db = await DB.instance.database;
    print('Conexão com o banco de dados estabelecida com sucesso.');
    // Você pode executar uma consulta simples para garantir que a conexão está funcionando
    var resultado = await db.rawQuery('SELECT 1');
    print('Resultado da consulta: $resultado');
  } catch (e) {
    print('Erro ao conectar com o banco de dados: $e');
  }
}
