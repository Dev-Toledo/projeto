import 'package:sqflite/sqflite.dart';
import 'package:projeto/database/db.dart';
import 'package:projeto/models/usuario.dart';

class UsuariosRepository {
  // Getter assíncrono para acessar o banco de dados
  Future<Database> get _db async => await DB.instance.database;

  // Método para criar um novo usuário no banco de dados
  Future<void> criarUsuario(Usuario usuario) async {
    final db = await _db;

    // Verifica se o e-mail já existe no banco de dados
    final usuarioExistente = await buscarUsuarioPorEmail(usuario.email);
    if (usuarioExistente != null) {
      throw Exception('O e-mail já está cadastrado.');
    }

    // Insere o novo usuário no banco de dados
    await db.insert('usuarios', usuario.toMap());
  }

  // Método para buscar todos os usuários no banco de dados
  Future<List<Usuario>> buscarUsuarios() async {
    final db = await _db;
    
    // Realiza a consulta no banco de dados para todos os usuários
    final List<Map<String, dynamic>> maps = await db.query('usuarios');
    
    // Converte a lista de Mapas em uma lista de objetos Usuario
    return List.generate(maps.length, (i) {
      return Usuario.fromMap(maps[i]);
    });
  }

  // Método para buscar um usuário por ID
  Future<Usuario?> buscarUsuarioPorId(int id) async {
    final db = await _db;
    
    // Realiza a consulta no banco de dados para o usuário com o ID especificado
    final List<Map<String, dynamic>> maps = await db.query(
      'usuarios',
      where: 'id = ?',
      whereArgs: [id],
    );
    
    // Se encontrar um usuário, retorna o objeto Usuario correspondente
    if (maps.isNotEmpty) {
      return Usuario.fromMap(maps.first);
    }
    return null; // Retorna null se o usuário não for encontrado
  }

  // Método para buscar um usuário por e-mail
  Future<Usuario?> buscarUsuarioPorEmail(String email) async {
    final db = await _db;
    
    // Realiza a consulta no banco de dados para o usuário com o e-mail especificado
    final List<Map<String, dynamic>> maps = await db.query(
      'usuarios',
      where: 'email = ?',
      whereArgs: [email],
    );
    
    // Se encontrar um usuário, retorna o objeto Usuario correspondente
    if (maps.isNotEmpty) {
      return Usuario.fromMap(maps.first);
    }
    return null; // Retorna null se o usuário não for encontrado
  }

  // Método para atualizar os dados de um usuário existente
  Future<void> atualizarUsuario(Usuario usuario) async {
    final db = await _db;
    
    // Atualiza o usuário no banco de dados com base no ID
    await db.update(
      'usuarios',
      usuario.toMap(),
      where: 'id = ?',
      whereArgs: [usuario.id],
    );
  }

  // Método para deletar um usuário pelo ID
  Future<void> deletarUsuario(int id) async {
    final db = await _db;
    
    // Deleta o usuário do banco de dados com base no ID
    await db.delete(
      'usuarios',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
