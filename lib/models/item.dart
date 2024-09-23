class Item {
  final int? id;
  final String nome;
  final double preco;
  final String descricao;
  final String? icone; // Tornar icone opcional
  final String? imagem; // Tornar imagem opcional

  Item({
    this.id, // Tornar id opcional também se necessário
    required this.nome,
    required this.preco,
    required this.descricao,
    this.icone, // Agora é opcional
    this.imagem, // Agora é opcional
  });

  // Método para converter o objeto em Map (usado no banco de dados)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'preco': preco,
      'descricao': descricao,
      'icone': icone,
      'imagem': imagem,
    };
  }

  // Método para criar um objeto a partir de um Map (usado no banco de dados)
  factory Item.fromMap(Map<String, dynamic> map) {
    return Item(
      id: map['id'],
      nome: map['nome'],
      preco: map['preco'],
      descricao: map['descricao'],
      icone: map['icone'],
      imagem: map['imagem'],
    );
  }
}
