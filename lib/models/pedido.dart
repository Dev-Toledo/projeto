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
      'usuarioId': usuarioId,
      'dataPedido': dataPedido.toIso8601String(),
      'valorTotal': valorTotal,
    };
  }

  // Cria um pedido a partir de um Map (usado para recuperar do banco de dados)
  factory Pedido.fromMap(Map<String, dynamic> map) {
    return Pedido(
      id: map['id'],
      usuarioId: map['usuarioId'],
      dataPedido: DateTime.parse(map['dataPedido']),
      valorTotal: map['valorTotal'],
    );
  }
}
