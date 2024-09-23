// lib/repositories/pedidos_repository.dart

import 'package:sqflite/sqflite.dart';
import 'package:projeto/database/db.dart';
import 'package:projeto/models/pedido.dart';

class PedidosRepository {
  late Database db;

  PedidosRepository() {
    _initRepository();
  }

  _initRepository() async {
    db = await DB.instance.database;
  }

  Future<List<Pedido>> buscarPedidos() async {
    final List<Map<String, dynamic>> maps = await db.query('pedidos');
    return List.generate(maps.length, (i) {
      return Pedido.fromMap(maps[i]);
    });
  }

  Future<void> deletarPedido(int id) async {
    await db.delete(
      'pedidos',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
