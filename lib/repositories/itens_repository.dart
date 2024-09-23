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

  // Método para inserir os itens iniciais do cardápio "Podrão Lanches"
  Future<void> inserirItensIniciais() async {
    List<Item> itensIniciais = [
      Item(
          nome: 'Podrão da Casa',
          preco: 25.00,
          descricao:
              'Lanche completo com hambúrguer duplo, bacon, queijo cheddar, cebola caramelizada e molho especial.',
          icone: 'lunch_dining',
          imagem: 'lib/images/podrao_da_casa.png'),
      Item(
          nome: 'X-Burguer',
          preco: 12.00,
          descricao: 'Hambúrguer com queijo, alface, tomate e maionese.',
          icone: 'fastfood',
          imagem: 'lib/images/x_burguer.png'),
      Item(
          nome: 'X-Salada',
          preco: 14.00,
          descricao:
              'Hambúrguer com queijo, salada de alface, tomate, cebola e maionese.',
          icone: 'restaurant',
          imagem: 'lib/images/x_salada.png'),
      Item(
          nome: 'X-Bacon',
          preco: 16.00,
          descricao:
              'Hambúrguer com queijo, bacon crocante, alface, tomate e maionese.',
          icone: 'lunch_dining',
          imagem: 'lib/images/x_bacon.png'),
      Item(
          nome: 'X-Tudo',
          preco: 18.00,
          descricao:
              'Hambúrguer completo com queijo, bacon, ovo, presunto, alface, tomate e maionese.',
          icone: 'dining',
          imagem: 'lib/images/x_tudo.png'),
      Item(
          nome: 'Cachorro-Quente',
          preco: 10.00,
          descricao:
              'Pão de hot dog com salsicha, purê de batata, milho, ervilha e molho de tomate.',
          icone: 'hotdog',
          imagem: 'lib/images/cachorro_quente.png'),
      Item(
          nome: 'Coca-Cola 350ml',
          preco: 5.00,
          descricao: 'Refrigerante Coca-Cola lata 350ml.',
          icone: 'local_drink',
          imagem: 'lib/images/coca_cola.png'),
      Item(
          nome: 'Guaraná Antarctica 350ml',
          preco: 5.00,
          descricao: 'Refrigerante Guaraná lata 350ml.',
          icone: 'local_drink',
          imagem: 'lib/images/guarana.png'),
      Item(
          nome: 'Suco de Laranja Natural',
          preco: 7.00,
          descricao: 'Suco de laranja natural feito na hora.',
          icone: 'emoji_food_beverage',
          imagem: 'lib/images/suco_laranja.png'),
      Item(
          nome: 'Batata Frita',
          preco: 8.00,
          descricao: 'Porção de batatas fritas crocantes.',
          icone: 'fries',
          imagem: 'lib/images/batata_frita.png'),
      Item(
          nome: 'Onion Rings',
          preco: 9.00,
          descricao: 'Anéis de cebola empanados e fritos.',
          icone: 'circle',
          imagem: 'lib/images/onion_rings.png'),
      Item(
          nome: 'Nuggets de Frango',
          preco: 10.00,
          descricao: 'Porção com 10 nuggets de frango empanados.',
          icone: 'restaurant_menu',
          imagem: 'lib/images/nuggets.png'),
    ];

    for (var item in itensIniciais) {
      await criarItem(item); // Insere cada item no banco de dados
    }
  }
}
