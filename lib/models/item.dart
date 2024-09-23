class Item {
  final int id;
  final String nome;
  final double preco;
  final String descricao;
  final String icone;
  final String imagem; // Campo para armazenar o caminho da imagem

  Item({
    required this.id,
    required this.nome,
    required this.preco,
    required this.descricao,
    required this.icone,
    required this.imagem, // Certifique-se de que o campo 'imagem' está presente
  });

  // Converte o objeto em um Map (para armazenar no banco de dados)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'preco': preco,
      'descricao': descricao,
      'icone': icone,
      'imagem': imagem, // Inclui a imagem no Map
    };
  }

  // Cria um objeto Item a partir de um Map (para recuperar do banco de dados)
  factory Item.fromMap(Map<String, dynamic> map) {
    return Item(
      id: map['id'],
      nome: map['nome'],
      preco: map['preco'],
      descricao: map['descricao'],
      icone: map['icone'],
      imagem: map['imagem'], // Recupera a imagem do Map
    );
  }
}

