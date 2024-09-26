import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart'; // Para obter o caminho no dispositivo móvel
import 'dart:io'; // Para trabalhar com diretórios
import 'package:projeto/database/script_db.dart';

class DB {
  // Construtor privado para singleton
  DB._();

  // Instância única de DB
  static final DB instance = DB._();

  // Instância do banco de dados SQLite
  static Database? _database;

  // Getter assíncrono para acessar o banco de dados
  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  // Método para inicializar o banco de dados
  Future<Database> _initDatabase() async {
    // Caminho para o diretório 'database'
    final dbPath = await getDatabasesPath();
    final directory = Directory(join(dbPath, 'database'));

    // Verifica se o diretório 'database' existe e cria se não existir
    if (!await directory.exists()) {
      await directory.create(recursive: true);
    }

    // Obtém o caminho do banco de dados no diretório 'database'
    String path = join(directory.path, 'projeto.db');

    // Abre ou cria o banco de dados
    return await openDatabase(
      path,
      version: 3, // Versão do banco de dados
      onCreate: (db, version) async {
        // Quando o banco for criado, ele chamará o script_db.dart para criar as tabelas e registros
        await ScriptDB.createTables(db);
        await ScriptDB.insertInitialData(db);
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        // Aqui você pode lidar com upgrades futuros
        if (oldVersion < 3) {
          await ScriptDB.createTables(db);
          await ScriptDB.insertInitialData(db);
        }
      },
    );
  }
}
