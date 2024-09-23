import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DB {
  DB._();

  static final DB instance = DB._();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    return await openDatabase(
      join(await getDatabasesPath(), 'projeto_restaurante.db'),
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute(_usuarios);  // Cria a tabela 'usuarios'
    await db.execute(_pedidos);   // Cria a tabela 'pedidos'
    await db.execute(_itensPedido); // Cria a tabela 'itens_pedido'

    // Inserir dados iniciais na tabela 'usuarios'
    await db.insert('usuarios', {
      'nome': 'Administrador',
      'email': 'admin@podrao.com',
      'senha': '123456', // Em produção, você deveria usar hash para senhas
      'tipo': 'admin',
    });

    await db.insert('usuarios', {
      'nome': 'Cliente Teste',
      'email': 'cliente@podrao.com',
      'senha': '123456',
      'tipo': 'cliente',
    });

    // Inserir dados iniciais na tabela 'itens_pedido' (exemplo de um cardápio inicial)
    await db.insert('itens_pedido', {
      'pedido_id': 1,
      'nome_item': 'X-Burguer',
      'quantidade': 2,
      'preco_unitario': 12.00,
    });

    await db.insert('itens_pedido', {
      'pedido_id': 1,
      'nome_item': 'Coca-Cola',
      'quantidade': 1,
      'preco_unitario': 5.00,
    });
  }

  String get _usuarios => '''
    CREATE TABLE usuarios (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      nome TEXT NOT NULL,
      email TEXT NOT NULL UNIQUE,
      senha TEXT NOT NULL,
      tipo TEXT NOT NULL
    );
  ''';

  String get _pedidos => '''
    CREATE TABLE pedidos (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      usuario_id INTEGER,
      data_pedido TEXT,
      valor_total REAL,
      FOREIGN KEY(usuario_id) REFERENCES usuarios(id)
    );
  ''';

  String get _itensPedido => '''
    CREATE TABLE itens_pedido (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      pedido_id INTEGER,
      nome_item TEXT,
      quantidade INTEGER,
      preco_unitario REAL,
      FOREIGN KEY(pedido_id) REFERENCES pedidos(id)
    );
  ''';
}
