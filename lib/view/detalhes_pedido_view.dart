// lib/view/detalhes_pedido_view.dart

import 'package:flutter/material.dart';
import 'package:projeto/models/pedido.dart';
import 'package:projeto/repositories/pedidos_repository.dart';

class DetalhesPedidoView extends StatelessWidget {
  final Pedido pedido;
  final VoidCallback onDelete;

  const DetalhesPedidoView({
    required this.pedido,
    required this.onDelete,
    super.key,
  });

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
            Text(
              'Pedido #${pedido.id}',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text('Usuário ID: ${pedido.usuarioId}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('Data: ${pedido.dataPedido.toIso8601String()}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('Valor Total: R\$ ${pedido.valorTotal.toStringAsFixed(2)}', style: TextStyle(fontSize: 18, color: Colors.green)),
            SizedBox(height: 20),

            // Botão para deletar o pedido
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                _exibirConfirmacaoExclusao(context);
              },
              child: Text('Excluir Pedido'),
            ),
          ],
        ),
      ),
    );
  }

  // Método para exibir a caixa de diálogo de confirmação
  void _exibirConfirmacaoExclusao(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Excluir Pedido'),
          content: Text('Você tem certeza que deseja excluir o pedido #${pedido.id}?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Fecha o diálogo sem excluir
              },
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () async {
                // Exclui o pedido
                await PedidosRepository().deletarPedido(pedido.id);

                // Fecha o diálogo e volta para a tela anterior
                Navigator.of(context).pop(); // Fecha o diálogo
                Navigator.of(context).pop(); // Volta para a lista de pedidos

                // Chama o callback para recarregar os pedidos na lista
                onDelete();
              },
              child: Text('Excluir'),
            ),
          ],
        );
      },
    );
  }
}
