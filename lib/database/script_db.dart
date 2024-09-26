import 'package:sqflite/sqflite.dart';


class ScriptDB {
  // Método para criar as tabelas
  static Future<void> createTables(Database db) async {
    await db.execute('''
      CREATE TABLE usuarios (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome TEXT NOT NULL,
        email TEXT NOT NULL UNIQUE,
        senha TEXT NOT NULL,
        tipo TEXT NOT NULL
      );
    ''');

    await db.execute('''
      CREATE TABLE pedidos (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        usuario_id INTEGER,
        data_pedido TEXT,
        valor_total REAL,
        FOREIGN KEY(usuario_id) REFERENCES usuarios(id)
      );
    ''');

    await db.execute('''
      CREATE TABLE cardapio (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome TEXT NOT NULL,
        descricao TEXT NOT NULL,
        preco REAL NOT NULL,
        icone TEXT NOT NULL
      );
    ''');

    await db.execute('''
      CREATE TABLE itens_pedido (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        pedido_id INTEGER,
        cardapio_id INTEGER,
        quantidade INTEGER,
        preco_unitario REAL,
        FOREIGN KEY(pedido_id) REFERENCES pedidos(id),
        FOREIGN KEY(cardapio_id) REFERENCES cardapio(id)
      );
    ''');
  }

  // Método para inserir dados iniciais no cardápio
  static Future<void> insertInitialData(Database db) async {
    List<Map<String, dynamic>> cardapioItems = [
      {
        'nome': 'Podrão da Casa',
        'descricao': 'Hambúrguer de picanha bovina completo com queijo, bacon, ovo, ovo de codorna, presunto, alface, pickles, banana, palmito, cebola, rúcula, tomate, maionese e batata-palha. Porção com 5 nuggets de frango empanados.',
        'preco': 45.00,
        'icone': 'new_releases',
      },
      {
        'nome': 'X-Burguer',
        'descricao': 'Hambúrguer com queijo, alface, tomate e maionese.',
        'preco': 12.00,
        'icone': 'fastfood',
      },
      {
        'nome': 'X-Salada',
        'descricao': 'Hambúrguer com queijo, salada de alface, tomate, cebola e maionese.',
        'preco': 14.00,
        'icone': 'restaurant',
      },
      {
        'nome': 'X-Bacon',
        'descricao': 'Hambúrguer com queijo, bacon crocante, alface, tomate e maionese.',
        'preco': 16.00,
        'icone': 'bacon',
      },
      {
        'nome': 'X-Tudo',
        'descricao': 'Hambúrguer completo com queijo, bacon, ovo, presunto, alface, tomate e maionese.',
        'preco': 18.00,
        'icone': 'dining',
      },
      {
        'nome': 'Cachorro-Quente',
        'descricao': 'Pão de hot dog com salsicha, purê de batata, milho, ervilha e molho de tomate.',
        'preco': 10.00,
        'icone': 'hotdog',
      },
      // Bebidas
      {
        'nome': 'Coca-Cola 350ml',
        'descricao': 'Refrigerante Coca-Cola lata 350ml.',
        'preco': 5.00,
        'icone': 'local_drink',
      },
      {
        'nome': 'Guaraná Antarctica 350ml',
        'descricao': 'Refrigerante Guaraná lata 350ml.',
        'preco': 5.00,
        'icone': 'local_drink',
      },
      {
        'nome': 'Suco de Laranja Natural',
        'descricao': 'Suco de laranja natural feito na hora.',
        'preco': 7.00,
        'icone': 'emoji_food_beverage',
      },
      // Acompanhamentos
      {
        'nome': 'Batata Frita',
        'descricao': 'Porção de batatas fritas crocantes.',
        'preco': 8.00,
        'icone': 'fries',
      },
      {
        'nome': 'Onion Rings',
        'descricao': 'Anéis de cebola empanados e fritos.',
        'preco': 9.00,
        'icone': 'circle',
      },
      {
        'nome': 'Nuggets de Frango',
        'descricao': 'Porção com 10 nuggets de frango empanados.',
        'preco': 10.00,
        'icone': 'restaurant_menu',
      },
      // Desafio Podrão
      {
        'nome': 'Desafio Podrão',
        'descricao': 'Comeu tudo, não paga nada e ganha R\$20 da casa. Se não comer, paga R\$80.',
        'preco': 80.00,
        'icone': 'star',
      }
    ];

    // Inserir os itens no banco
    for (var item in cardapioItems) {
      await db.insert('cardapio', item);
    }
  }
}
