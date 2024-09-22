import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';

class DB {
  // Construtor privado para evitar a criação de múltiplas instâncias da classe
  DB._();

  // Instância única da classe DB (Singleton)
  static final DB instance = DB._();

  // Instância do banco de dados SQLite
  static Database? _database;

  // Getter assíncrono para acessar o banco de dados. Se o banco já foi inicializado, ele é retornado. Caso contrário, ele é inicializado.
  get database async {
    if (_database != null) return _database;

    return await _initDatabase();
  }

  // Método para inicializar o banco de dados. Ele define o caminho do arquivo do banco e o cria, se ainda não existir.
  _initDatabase() async {
    return await openDatabase(
      join(await getDatabasesPath(),
          'projeto.db'), // Define o caminho para o banco de dados
      version: 1, // Versão do banco de dados
      onCreate:
          _onCreate, // Define a função a ser chamada quando o banco é criado pela primeira vez
    );
  }

  // Método chamado na criação do banco de dados para definir a estrutura das tabelas
  _onCreate(Database db, int version) async {
    await db.execute(_usuarios); // Cria a tabela 'usuarios'
    await db.execute(_pedidos); // Cria a tabela 'pedidos'
    await db.execute(_itensPedido); // Cria a tabela 'itens_pedido'
  }

  // Definição da estrutura da tabela 'usuarios', que armazena as informações dos usuários do sistema
  String get _usuarios => '''
    CREATE TABLE usuarios (
      id INTEGER PRIMARY KEY AUTOINCREMENT, // Identificador único do usuário
      nome TEXT NOT NULL, // Nome do usuário
      email TEXT NOT NULL UNIQUE, // E-mail do usuário, deve ser único
      senha TEXT NOT NULL, // Senha do usuário
      tipo TEXT NOT NULL // Tipo do usuário (por exemplo, "admin" ou "cliente")
    );
  ''';

  // Definição da estrutura da tabela 'pedidos', que armazena informações sobre os pedidos realizados pelos usuários
  String get _pedidos => '''
    CREATE TABLE pedidos (
      id INTEGER PRIMARY KEY AUTOINCREMENT, // Identificador único do pedido
      usuario_id INTEGER, // Identificador do usuário que fez o pedido
      data_pedido TEXT, // Data do pedido
      valor_total REAL, // Valor total do pedido
      FOREIGN KEY(usuario_id) REFERENCES usuarios(id) // Chave estrangeira que relaciona o pedido com o usuário
    );
  ''';

  // Definição da estrutura da tabela 'itens_pedido', que armazena os itens individuais de cada pedido
  String get _itensPedido => '''
    CREATE TABLE itens_pedido (
      id INTEGER PRIMARY KEY AUTOINCREMENT, // Identificador único do item de pedido
      pedido_id INTEGER, // Identificador do pedido ao qual o item pertence
      nome_item TEXT, // Nome do item
      quantidade INTEGER, // Quantidade do item no pedido
      preco_unitario REAL, // Preço unitário do item
      FOREIGN KEY(pedido_id) REFERENCES pedidos(id) // Chave estrangeira que relaciona o item com o pedido
    );
  ''';
}
