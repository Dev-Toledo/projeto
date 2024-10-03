// lib/models/pedido.dart

import 'package:projeto/models/item.dart';

class Pedido {
  final int id; // Identificador do pedido
  final int usuarioId; // ID do usuário que fez o pedido
  final DateTime dataPedido; // Data do pedido
  final List<Item> itens; // Lista de itens no pedido
  final double valorTotal; // Valor total do pedido

  Pedido({
    required this.id,
    required this.usuarioId,
    required this.dataPedido,
    required this.itens,
    required this.valorTotal,
  });

  // Cria um objeto a partir de um mapa (se quiser adicionar persistência futura)
  factory Pedido.fromMap(Map<String, dynamic> map) {
    return Pedido(
      id: map['id'],
      usuarioId: map['usuario_id'],
      dataPedido: DateTime.parse(map['data_pedido']),
      itens: List<Item>.from(map['itens'].map((item) => Item.fromMap(item))),
      valorTotal: map['valor_total'],
    );
  }

  // Converte o objeto para um mapa (se quiser adicionar persistência futura)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'usuario_id': usuarioId,
      'data_pedido': dataPedido.toIso8601String(),
      'itens': itens.map((item) => item.toMap()).toList(),
      'valor_total': valorTotal,
    };
  }
}
