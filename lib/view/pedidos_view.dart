// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:projeto/models/pedido.dart';
import 'package:projeto/repositories/pedidos_repository.dart';

class PedidosView extends StatefulWidget {
  const PedidosView({super.key});

  @override
  State<PedidosView> createState() => _PedidosViewState();
}

class _PedidosViewState extends State<PedidosView> {
  late PedidosRepository pedidosRepository;
  late Future<List<Pedido>> pedidosFuture;

  @override
  void initState() {
    super.initState();
    pedidosRepository = PedidosRepository();
    pedidosFuture = pedidosRepository.buscarPedidos(); // Busca todos os pedidos
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meus Pedidos'),
        backgroundColor: Colors.orange,
      ),
      body: FutureBuilder<List<Pedido>>(
        future: pedidosFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro ao carregar pedidos.'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Nenhum pedido encontrado.'));
          }

          List<Pedido> pedidos = snapshot.data!;

          return ListView.builder(
            itemCount: pedidos.length,
            itemBuilder: (context, index) {
              final pedido = pedidos[index];
              return Card(
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: ListTile(
                  title: Text('Pedido #${pedido.id}'),
                  subtitle: Text(
                      'Valor: R\$ ${pedido.valorTotal.toStringAsFixed(2)}'),
                  trailing: Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    // Ação ao tocar em um pedido (detalhes do pedido)
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            DetalhesPedidoView(pedido: pedido),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}

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
            Text('Pedido #${pedido.id}', style: TextStyle(fontSize: 22)),
            SizedBox(height: 10),
            Text('Usuário ID: ${pedido.usuarioId}'),
            SizedBox(height: 10),
            Text('Data: ${pedido.dataPedido.toIso8601String()}'),
            SizedBox(height: 10),
            Text('Valor Total: R\$ ${pedido.valorTotal.toStringAsFixed(2)}'),
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
                        onPressed: () {
                          // Deleta o pedido aqui e volta para a lista de pedidos
                          PedidosRepository().deletarPedido(pedido.id);
                          Navigator.of(context).pop(); // Fecha o diálogo
                          Navigator.of(context)
                              .pop(); // Volta para a tela de pedidos
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
