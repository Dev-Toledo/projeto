import 'package:sqflite/sqflite.dart';
import 'package:projeto/database/db.dart';
import 'package:projeto/models/usuario.dart';

class UsuariosRepository {
  late Database db;

  UsuariosRepository() {
    _initRepository();
  }

  // Inicializa o repositório, garantindo que o banco de dados esteja disponível
  _initRepository() async {
    db = await DB.instance.database;
  }

  // Método para criar um novo usuário no banco de dados
  Future<void> criarUsuario(Usuario usuario) async {
    await db.insert('usuarios', usuario.toMap());
  }

  // Método para buscar todos os usuários no banco de dados
  Future<List<Usuario>> buscarUsuarios() async {
    final List<Map<String, dynamic>> maps = await db.query('usuarios');
    return List.generate(maps.length, (i) {
      return Usuario.fromMap(maps[i]);
    });
  }

  // Método para buscar um usuário por ID
  Future<Usuario?> buscarUsuarioPorId(int id) async {
    final List<Map<String, dynamic>> maps = await db.query(
      'usuarios',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return Usuario.fromMap(maps.first);
    }
    return null; // Retorna null se o usuário não for encontrado
  }

  // Método para buscar um usuário por e-mail
  Future<Usuario?> buscarUsuarioPorEmail(String email) async {
    final List<Map<String, dynamic>> maps = await db.query(
      'usuarios',
      where: 'email = ?',
      whereArgs: [email],
    );
    if (maps.isNotEmpty) {
      return Usuario.fromMap(maps.first);
    }
    return null; // Retorna null se o usuário não for encontrado
  }

  // Método para atualizar os dados de um usuário existente
  Future<void> atualizarUsuario(Usuario usuario) async {
    await db.update(
      'usuarios',
      usuario.toMap(),
      where: 'id = ?',
      whereArgs: [usuario.id],
    );
  }

  // Método para deletar um usuário pelo ID
  Future<void> deletarUsuario(int id) async {
    await db.delete(
      'usuarios',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}