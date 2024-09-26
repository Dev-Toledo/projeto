// lib/view/admin_view.dart
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:projeto/database/db.dart';

class AdminView extends StatefulWidget {
  const AdminView({super.key});

  @override
  State<AdminView> createState() => _AdminViewState();
}

class _AdminViewState extends State<AdminView> {
  int? numPedidos;
  int? numItens;

  @override
  void initState() {
    super.initState();
    _verificarDados();
  }

  // Método para verificar o número de pedidos e itens no banco de dados
  Future<void> _verificarDados() async {
    try {
      Database db = await DB.instance.database;

      // Contar número de pedidos
      var pedidosResult =
          await db.rawQuery('SELECT COUNT(*) as total FROM pedidos');
      var itensResult =
          await db.rawQuery('SELECT COUNT(*) as total FROM cardapio');

      setState(() {
        numPedidos = pedidosResult.first['total'] as int?;
        numItens = itensResult.first['total'] as int?;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao verificar o banco de dados: $e')),
      );
    }
  }

  // Método para testar a conexão com o banco de dados
  Future<void> _testarConexao() async {
    try {
      await DB.instance.database;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Conexão com o banco de dados bem-sucedida!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao conectar ao banco de dados: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Administração'),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: _testarConexao,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              child: const Text('Testar Conexão com Banco de Dados'),
            ),
            const SizedBox(height: 20),
            if (numPedidos != null && numItens != null) ...[
              Text('Número de Pedidos: $numPedidos',
                  style: const TextStyle(fontSize: 18)),
              Text('Número de Itens Cadastrados: $numItens',
                  style: const TextStyle(fontSize: 18)),
            ] else ...[
              const Text('Nenhum banco de dados encontrado',
                  style: TextStyle(fontSize: 18)),
            ],
          ],
        ),
      ),
    );
  }
}
