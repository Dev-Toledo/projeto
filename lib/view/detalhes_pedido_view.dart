// lib/view/detalhes_pedido_view.dart

import 'package:flutter/material.dart';
import 'package:projeto/models/pedido.dart';
import 'package:projeto/repositories/pedidos_repository.dart';

class DetalhesPedidoView extends StatelessWidget {
  final Pedido pedido;
  final VoidCallback onDelete;

  const DetalhesPedidoView({required this.pedido, required this.onDelete, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes do Pedido #${pedido.id}'),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Pedido #${pedido.id}', style: TextStyle(fontSize: 22)),
            SizedBox(height: 10),
            Text('Usuário ID: ${pedido.usuarioId}'),
            SizedBox(height: 10),
            Text('Data: ${pedido.dataPedido.toIso8601String()}'),
            SizedBox(height: 10),
            Text('Valor Total: R\$ ${pedido.valorTotal.toStringAsFixed(2)}'),
            SizedBox(height: 20),

            // Botão para deletar o pedido
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                // Exibe uma caixa de diálogo para confirmar a exclusão
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Excluir Pedido'),
                    content: Text(
                        'Você tem certeza que deseja excluir o pedido #${pedido.id}?'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(); // Fecha o diálogo
                        },
                        child: Text('Cancelar'),
                      ),
                      TextButton(
                        onPressed: () async {
                          // Deleta o pedido se confirmado
                          await PedidosRepository().deletarPedido(pedido.id);

                          // Volta para a lista de pedidos e chama o callback para atualizar a lista
                          onDelete();
                          Navigator.of(context).pop(); // Fecha o diálogo
                          Navigator.of(context).pop(); // Volta para a lista
                        },
                        child: Text('Excluir'),
                      ),
                    ],
                  ),
                );
              },
              child: Text('Excluir Pedido'),
            ),
          ],
        ),
      ),
    );
  }
}
