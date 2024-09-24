// lib/view/pedidos_view.dart

import 'package:flutter/material.dart';
import 'package:projeto/models/pedido.dart';
import 'package:projeto/repositories/pedidos_repository.dart';
import 'detalhes_pedido_view.dart';

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
    _carregarPedidos(); // Carrega os pedidos na inicialização
  }

  // Método para carregar os pedidos do repositório
  void _carregarPedidos() {
    setState(() {
      pedidosFuture =
          pedidosRepository.buscarPedidos(); // Busca todos os pedidos
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meus Pedidos'),
        backgroundColor: Colors.orange,
      ),
      body: FutureBuilder<List<Pedido>>(
        future: pedidosFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
                child: Text('Erro ao carregar pedidos: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Nenhum pedido encontrado.'));
          }

          List<Pedido> pedidos = snapshot.data!;

          return ListView.builder(
            itemCount: pedidos.length,
            itemBuilder: (context, index) {
              final pedido = pedidos[index];
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: ListTile(
                  title: Text('Pedido #${pedido.id}'),
                  subtitle: Text(
                      'Valor: R\$ ${pedido.valorTotal.toStringAsFixed(2)}'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    // Ação ao tocar em um pedido (detalhes do pedido)
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetalhesPedidoView(
                          pedido: pedido,
                          onDelete: () {
                            // Atualiza a lista de pedidos após a exclusão
                            _carregarPedidos();
                          },
                        ),
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
