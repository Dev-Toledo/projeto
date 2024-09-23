import 'package:sqflite/sqflite.dart';
import 'package:projeto/database/db.dart';
import 'package:projeto/models/pedido.dart';

class PedidosRepository {
  late Database db;

  PedidosRepository() {
    _initRepository();
  }

  // Inicializa o repositório, garantindo que o banco de dados esteja disponível
  _initRepository() async {
    db = await DB.instance.database;
  }

  // Método para criar um novo pedido no banco de dados
  Future<void> criarPedido(Pedido pedido) async {
    await db.insert('pedidos', pedido.toMap());
  }

  // Método para buscar todos os pedidos no banco de dados
  Future<List<Pedido>> buscarPedidos() async {
    final List<Map<String, dynamic>> maps = await db.query('pedidos');
    return List.generate(maps.length, (i) {
      return Pedido.fromMap(maps[i]);
    });
  }

  // Método para buscar um pedido por ID
  Future<Pedido?> buscarPedidoPorId(int id) async {
    final List<Map<String, dynamic>> maps = await db.query(
      'pedidos',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return Pedido.fromMap(maps.first);
    }
    return null; // Retorna null se o pedido não for encontrado
  }

  // Método para atualizar os dados de um pedido existente
  Future<void> atualizarPedido(Pedido pedido) async {
    await db.update(
      'pedidos',
      pedido.toMap(),
      where: 'id = ?',
      whereArgs: [pedido.id],
    );
  }

  // Método para deletar um pedido pelo ID
  Future<void> deletarPedido(int id) async {
    await db.delete(
      'pedidos',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
