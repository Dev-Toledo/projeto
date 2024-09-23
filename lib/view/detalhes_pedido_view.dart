// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:projeto/models/pedido.dart';
import 'package:projeto/repositories/pedidos_repository.dart'; // Certifique-se de importar corretamente

class DetalhesPedidoView extends StatelessWidget {
  final Pedido pedido;

  const DetalhesPedidoView({required this.pedido, super.key});

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
            Text('Pedido #${pedido.id}',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text('Usuário ID: ${pedido.usuarioId}',
                style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('Data: ${pedido.dataPedido.toIso8601String()}',
                style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('Valor Total: R\$ ${pedido.valorTotal.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 18, color: Colors.green)),
            SizedBox(height: 20),

            // Botão para deletar o pedido (pode ser removido se não for necessário)
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                // Ação para deletar o pedido
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
                          // Deleta o pedido aqui e volta para a lista de pedidos
                          await PedidosRepository().deletarPedido(pedido.id);
                          Navigator.of(context).pop(); // Fecha o diálogo
                          Navigator.of(context)
                              .pop(); // Volta para a tela anterior
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
