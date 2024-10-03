// lib/repositories/pedidos_repository.dart

import 'package:projeto/models/pedido.dart';

class PedidosRepository {
  // Lista em memória para armazenar os pedidos
  final List<Pedido> _pedidos = [];

  // Método para buscar todos os pedidos
  Future<List<Pedido>> buscarPedidos() async {
    return _pedidos; // Retorna a lista de pedidos armazenada em memória
  }

  // Método para adicionar um pedido
  Future<void> adicionarPedido(Pedido pedido) async {
    _pedidos.add(pedido); // Adiciona o pedido à lista em memória
  }

  // Método para deletar um pedido pelo ID
  Future<void> deletarPedido(int id) async {
    _pedidos.removeWhere((pedido) => pedido.id == id); // Remove o pedido com o ID fornecido
  }
}

