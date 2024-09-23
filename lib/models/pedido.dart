// lib/models/pedido.dart

class Pedido {
  final int id;
  final int usuarioId;
  final DateTime dataPedido;
  final double valorTotal;

  Pedido({
    required this.id,
    required this.usuarioId,
    required this.dataPedido,
    required this.valorTotal,
  });

  // Converte um pedido para Map (usado para armazenar no banco de dados)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'usuario_id': usuarioId, // Nome da coluna no banco de dados
      'data_pedido': dataPedido.toIso8601String(), // Armazena data como string ISO 8601
      'valor_total': valorTotal, // Nome da coluna no banco de dados
    };
  }

  // Cria um pedido a partir de um Map (usado para recuperar do banco de dados)
  factory Pedido.fromMap(Map<String, dynamic> map) {
    return Pedido(
      id: map['id'],
      usuarioId: map['usuario_id'], // Correspondente ao nome da coluna no banco de dados
      dataPedido: DateTime.parse(map['data_pedido']), // Converte string para DateTime
      valorTotal: map['valor_total'], // Nome da coluna no banco de dados
    );
  }
}
