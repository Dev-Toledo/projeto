class Item {
  final int id;
  final String nome;
  final double preco;
  final String descricao;
  final String icone;
  final String imagem; // Certifique-se de que o campo 'imagem' existe

  Item({
    required this.id,
    required this.nome,
    required this.preco,
    required this.descricao,
    required this.icone,
    required this.imagem, // Certifique-se de que o campo 'imagem' está presente no construtor
  });

  // Método para converter o objeto em Map (usado no banco de dados)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'preco': preco,
      'descricao': descricao,
      'icone': icone,
      'imagem': imagem, // Certifique-se de que o campo 'imagem' é incluído no Map
    };
  }

  // Método para criar um objeto Item a partir de um Map (usado no banco de dados)
  factory Item.fromMap(Map<String, dynamic> map) {
    return Item(
      id: map['id'],
      nome: map['nome'],
      preco: map['preco'],
      descricao: map['descricao'],
      icone: map['icone'],
      imagem: map['imagem'], // Certifique-se de que o campo 'imagem' é incluído aqui também
    );
  }

  
}

Item item = Item(
  id: 1,
  nome: 'X-Burguer',
  preco: 12.00,
  descricao: 'Hambúrguer com queijo, alface, tomate e maionese.',
  icone: 'fastfood',
  imagem: 'lib/images/x_burguer.png', // Certifique-se de que o campo 'imagem' tem um valor válido
);