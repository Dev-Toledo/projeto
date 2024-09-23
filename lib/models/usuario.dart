class Usuario {
  final int? id; // Torne o id opcional (nullable)
  final String nome;
  final String email;
  final String senha;
  final String tipo;

  Usuario({
    this.id, // O id agora é opcional
    required this.nome,
    required this.email,
    required this.senha,
    required this.tipo,
  });

  // Converte o objeto em um Map (útil para o banco de dados)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'email': email,
      'senha': senha,
      'tipo': tipo,
    };
  }

  // Cria um objeto a partir de um Map
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