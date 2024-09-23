class Usuario {
  final int? id; // O ID do usuário é opcional (nullable)
  final String nome;
  final String email;
  final String senha;
  final String tipo;

  // Construtor que permite a criação de um usuário, com o id opcional
  Usuario({
    this.id,
    required this.nome,
    required this.email,
    required this.senha,
    required this.tipo,
  });

  // Converte o objeto Usuario para um Map (para inserção no banco de dados)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'email': email,
      'senha': senha,
      'tipo': tipo,
    };
  }

  // Cria um objeto Usuario a partir de um Map (recuperado do banco de dados)
  factory Usuario.fromMap(Map<String, dynamic> map) {
    return Usuario(
      id: map['id'],
      nome: map['nome'],
      email: map['email'],
      senha: map['senha'],
      tipo: map['tipo'],
    );
  }
}
