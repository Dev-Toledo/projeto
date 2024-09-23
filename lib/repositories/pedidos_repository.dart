// lib/repositories/pedidos_repository.dart

import 'package:sqflite/sqflite.dart';
import 'package:projeto/database/db.dart';
import 'package:projeto/models/pedido.dart';

class PedidosRepository {
  // Getter assíncrono para acessar o banco de dados
  Future<Database> get _db async => await DB.instance.database;

  // Método para buscar todos os pedidos no banco de dados
  Future<List<Pedido>> buscarPedidos() async {
    final db = await _db; // Obtém a instância do banco de dados
    // Faz a consulta na tabela 'pedidos' e retorna todos os registros
    final List<Map<String, dynamic>> maps = await db.query('pedidos');
    
    // Converte cada registro do banco de dados em um objeto Pedido
    return List.generate(maps.length, (i) {
      return Pedido.fromMap(maps[i]);
    });
  }

  // Método para deletar um pedido pelo ID
  Future<void> deletarPedido(int id) async {
    final db = await _db; // Obtém a instância do banco de dados
    // Deleta o registro na tabela 'pedidos' com base no ID fornecido
    await db.delete(
      'pedidos',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
