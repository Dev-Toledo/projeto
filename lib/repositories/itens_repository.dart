import 'package:sqflite/sqflite.dart';
import 'package:projeto/database/db.dart';
import 'package:projeto/models/item.dart';

class ItemRepository {
  late Database db;

  ItemRepository() {
    _initRepository();
  }

  // Inicializa o repositório, garantindo que o banco de dados esteja disponível
  _initRepository() async {
    db = await DB.instance.database;
  }

  // Método para adicionar um item no banco de dados
  Future<void> criarItem(Item item) async {
    await db.insert('itens_pedido', item.toMap());
  }

  // Método para buscar todos os itens
  Future<List<Item>> buscarItens() async {
    final List<Map<String, dynamic>> maps = await db.query('itens_pedido');
    return List.generate(maps.length, (i) {
      return Item.fromMap(maps[i]);
    });
  }

  // Método para buscar um item por ID
  Future<Item?> buscarItemPorId(int id) async {
    final List<Map<String, dynamic>> maps = await db.query(
      'itens_pedido',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return Item.fromMap(maps.first);
    }
    return null; // Retorna null se não encontrar o item
  }

  // Método para atualizar um item existente
  Future<void> atualizarItem(Item item) async {
    await db.update(
      'itens_pedido',
      item.toMap(),
      where: 'id = ?',
      whereArgs: [item.id],
    );
  }

  // Método para deletar um item
  Future<void> deletarItem(int id) async {
    await db.delete(
      'itens_pedido',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
