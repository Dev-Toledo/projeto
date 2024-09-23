class Pedido {
  final int id; // Identificador único do pedido
  final int usuarioId; // ID do usuário que fez o pedido
  final DateTime dataPedido; // Data em que o pedido foi realizado
  final double valorTotal; // Valor total do pedido

  // Construtor da classe Pedido
  Pedido({
    required this.id,
    required this.usuarioId,
    required this.dataPedido,
    required this.valorTotal,
  });

  // Converte um mapa (do banco de dados) em um objeto Pedido
  factory Pedido.fromMap(Map<String, dynamic> map) {
    return Pedido(
      id: map['id'],
      usuarioId: map['usuario_id'],
      dataPedido: DateTime.parse(map['data_pedido']),
      valorTotal: map['valor_total'],
    );
  }

  // Converte um objeto Pedido para um mapa (para salvar no banco de dados)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'usuario_id': usuarioId,
      'data_pedido': dataPedido.toIso8601String(),
      'valor_total': valorTotal,
    };
  }
}
