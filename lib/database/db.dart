import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';

class DB {
  DB._();

  static final DB instance = DB._();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  // Método para inicializar o banco de dados e definir as tabelas
  Future<Database> _initDatabase() async {
    return await openDatabase(
      join(await getDatabasesPath(), 'projeto.db'),
      version: 3, // Atualizamos para a versão 2
      onCreate: _onCreate,
      onUpgrade: _onUpgrade, // Adicionamos suporte para upgrade
    );
  }

  // Método para criar as tabelas
  Future<void> _onCreate(Database db, int version) async {
    await db.execute(_usuarios); // Cria a tabela 'usuarios'
    await db.execute(_pedidos); // Cria a tabela 'pedidos'
    await db.execute(_cardapio); // Cria a tabela 'cardapio'
    await db.execute(_itensPedido); // Cria a tabela 'itens_pedido'

    // Inserir dados iniciais na tabela 'usuarios'
    await db.insert('usuarios', {
      'nome': 'Administrador',
      'email': 'admin@podrao.com',
      'senha': hashPassword('123456'), // Armazenando a senha com hash
      'tipo': 'admin',
    });

    await db.insert('usuarios', {
      'nome': 'Cliente Teste',
      'email': 'cliente@podrao.com',
      'senha': hashPassword('123456'),
      'tipo': 'cliente',
    });

    // Inserir dados iniciais no cardápio
    await db.insert('cardapio', {
      'nome': 'X-Burguer',
      'descricao': 'Hambúrguer com queijo, alface, tomate e maionese.',
      'preco': 12.00,
    });

    await db.insert('cardapio', {
      'nome': 'Coca-Cola',
      'descricao': 'Refrigerante lata 350ml',
      'preco': 5.00,
    });
  }

  // Método que lida com upgrades no banco de dados
  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      // Caso atualize da versão 1 para 2, crie a tabela de cardápio
      await db.execute(_cardapio);
    }
  }

  // Função para hashear a senha (usando SHA-256)
  String hashPassword(String password) {
    var bytes = utf8.encode(password);
    var digest = sha256.convert(bytes);
    return digest.toString();
  }

  // Definição da tabela 'usuarios' que armazena os dados dos usuários
  String get _usuarios => '''
    CREATE TABLE usuarios (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      nome TEXT NOT NULL,
      email TEXT NOT NULL UNIQUE,
      senha TEXT NOT NULL,
      tipo TEXT NOT NULL
    );
  ''';

  // Definição da tabela 'pedidos' que armazena os dados dos pedidos
  String get _pedidos => '''
    CREATE TABLE pedidos (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      usuario_id INTEGER,
      data_pedido TEXT,
      valor_total REAL,
      FOREIGN KEY(usuario_id) REFERENCES usuarios(id)
    );
  ''';

  // Definição da tabela 'cardapio' que armazena os itens do cardápio
  String get _cardapio => '''
    CREATE TABLE cardapio (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      nome TEXT NOT NULL,
      descricao TEXT NOT NULL,
      preco REAL NOT NULL
    );
  ''';

  // Definição da tabela 'itens_pedido' que armazena os itens de cada pedido
  String get _itensPedido => '''
    CREATE TABLE itens_pedido (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      pedido_id INTEGER,
      cardapio_id INTEGER,
      quantidade INTEGER,
      preco_unitario REAL,
      FOREIGN KEY(pedido_id) REFERENCES pedidos(id),
      FOREIGN KEY(cardapio_id) REFERENCES cardapio(id)
    );
  ''';
}
