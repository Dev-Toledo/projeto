class Item {
  final int id; // Identificador único do item
  final String nome; // Nome do item (ex.: nome do prato ou bebida)
  final double preco; // Preço unitário do item
  final String descricao; // Descrição do item (opcional)

  // Construtor da classe Item
  Item({
    required this.id,
    required this.nome,
    required this.preco,
    this.descricao = '', // A descrição é opcional e tem um valor padrão vazio
  });

  // Converte os dados de um mapa (do banco de dados) para um objeto Item
  factory Item.fromMap(Map<String, dynamic> map) {
    return Item(
      id: map['id'],
      nome: map['nome'],
      preco: map['preco'],
      descricao: map['descricao'] ?? '', // Descrição pode ser nula
    );
  }

  // Converte um objeto Item para um mapa (para armazenar no banco de dados)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'preco': preco,
      'descricao': descricao,
    };
  }
}
