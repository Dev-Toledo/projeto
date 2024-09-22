import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DB {
  // Construtor privado para garantir que haja apenas uma instância de DB (Singleton)
  DB._();

  // Instância única de DB
  static final DB instance = DB._();

  // Instância do banco de dados SQLite
  static Database? _database;

  // Getter assíncrono para acessar o banco de dados
  Future<Database> get database async {
    if (_database != null) return _database!;

    // Se o banco de dados ainda não foi inicializado, inicialize-o
    _database = await _initDatabase();
    return _database!;
  }

  // Método para inicializar o banco de dados e definir as tabelas
  Future<Database> _initDatabase() async {
    return await openDatabase(
      join(await getDatabasesPath(),
          'projeto_restaurante.db'), // Caminho para o banco de dados
      version: 1, // Versão do banco de dados
      onCreate: _onCreate, // Chama o método que cria as tabelas
    );
  }

  // Método que cria as tabelas quando o banco de dados é inicializado pela primeira vez
  Future<void> _onCreate(Database db, int version) async {
    await db.execute(_usuarios); // Cria a tabela 'usuarios'
    await db.execute(_pedidos); // Cria a tabela 'pedidos'
    await db.execute(_itensPedido); // Cria a tabela 'itens_pedido'
  }

  // Definição da tabela 'usuarios' que armazena os dados dos usuários
  String get _usuarios => '''
    CREATE TABLE usuarios (
      id INTEGER PRIMARY KEY AUTOINCREMENT,  // Identificador único do usuário
      nome TEXT NOT NULL,  // Nome do usuário
      email TEXT NOT NULL UNIQUE,  // E-mail do usuário, único
      senha TEXT NOT NULL,  // Senha do usuário
      tipo TEXT NOT NULL  // Tipo do usuário (ex.: admin ou cliente)
    );
  ''';

  // Definição da tabela 'pedidos' que armazena os dados dos pedidos
  String get _pedidos => '''
    CREATE TABLE pedidos (
      id INTEGER PRIMARY KEY AUTOINCREMENT,  // Identificador único do pedido
      usuario_id INTEGER,  // ID do usuário que fez o pedido
      data_pedido TEXT,  // Data do pedido
      valor_total REAL,  // Valor total do pedido
      FOREIGN KEY(usuario_id) REFERENCES usuarios(id)  // Relaciona o pedido com o usuário
    );
  ''';

  // Definição da tabela 'itens_pedido' que armazena os itens de cada pedido
  String get _itensPedido => '''
    CREATE TABLE itens_pedido (
      id INTEGER PRIMARY KEY AUTOINCREMENT,  // Identificador único do item de pedido
      pedido_id INTEGER,  // ID do pedido ao qual o item pertence
      nome_item TEXT,  // Nome do item
      quantidade INTEGER,  // Quantidade do item no pedido
      preco_unitario REAL,  // Preço unitário do item
      FOREIGN KEY(pedido_id) REFERENCES pedidos(id)  // Relaciona o item com o pedido
    );
  ''';
}
