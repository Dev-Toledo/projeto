import 'package:flutter_test/flutter_test.dart'; // Biblioteca de testes do Flutter
import 'package:sqflite/sqflite.dart'; // Importando o Sqflite
import 'package:projeto/database/db.dart'; // Certifique-se de ajustar o caminho corretamente

void main() {
  // Inicializa o ambiente de teste de widgets
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Database Connection Tests', () {
    test('Test connection to database', () async {
      // Obtém a conexão com o banco de dados
      Database db = await DB.instance.database;

      // Verifica se o banco de dados foi aberto corretamente
      expect(db.isOpen, true); // Valida se o banco foi aberto com sucesso
    });
  });
}
