import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DB {
  // Construtor privado para singleton
  DB._();

  static final DB instance = DB._();

  static Database? _database;

  // Getter assíncrono para acessar o banco de dados
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase(); // Chama o método de inicialização
    return _database!;
  }

  // Método para inicializar o banco de dados
  Future<Database> _initDatabase() async {
    // Obtém o caminho do banco de dados no dispositivo
    String path = join(await getDatabasesPath(), 'projeto_restaurante.db');

    // Abre o banco de dados, definindo a versão e chamando os métodos de criação ou atualização
    return await openDatabase(
      path,
      version: 2, // Definimos a versão do banco de dados
      onCreate: _onCreate, // Chamado se o banco de dados ainda não existe
      onUpgrade:
          _onUpgrade, // Chamado se o banco de dados precisa de uma atualização
    );
  }

  // Método chamado na criação do banco de dados
  Future<void> _onCreate(Database db, int version) async {
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
        preco REAL NOT NULL
      );
    ''');
  }

  // Método chamado em caso de atualização de versão do banco de dados
  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
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
  }
}
