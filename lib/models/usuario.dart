class Usuario {
  final int id; // Identificador único do usuário
  final String nome; // Nome do usuário
  final String email; // E-mail do usuário (deve ser único)
  final String senha; // Senha do usuário
  final String tipo; // Tipo de usuário (ex: "admin" ou "cliente")

  // Construtor da classe Usuario
  Usuario({
    required this.id,
    required this.nome,
    required this.email,
    required this.senha,
    required this.tipo, // Pode ser usado para diferenciar entre administradores e clientes
  });

  // Converte um mapa (do banco de dados) em um objeto Usuario
  factory Usuario.fromMap(Map<String, dynamic> map) {
    return Usuario(
      id: map['id'],
      nome: map['nome'],
      email: map['email'],
      senha: map['senha'],
      tipo: map['tipo'],
    );
  }

  // Converte um objeto Usuario para um mapa (para salvar no banco de dados)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'email': email,
      'senha': senha,
      'tipo': tipo,
    };
  }
}
