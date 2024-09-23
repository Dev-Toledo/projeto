// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:projeto/models/item.dart';
import 'package:projeto/repositories/itens_repository.dart';

class ItensView extends StatefulWidget {
  const ItensView({super.key});

  @override
  State<ItensView> createState() => _ItensViewState();
}

class _ItensViewState extends State<ItensView> {
  late ItemRepository itemRepository;
  late Future<List<Item>> itensFuture;

  @override
  void initState() {
    super.initState();
    itemRepository = ItemRepository();
    itensFuture = itemRepository.buscarItens(); // Busca todos os itens do cardápio
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cardápio de Itens'),
        backgroundColor: Colors.orange,
      ),
      body: FutureBuilder<List<Item>>(
        future: itensFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro ao carregar os itens.'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Nenhum item encontrado.'));
          }

          List<Item> itens = snapshot.data!;

          return ListView.builder(
            itemCount: itens.length,
            itemBuilder: (context, index) {
              final item = itens[index];
              return Card(
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: ListTile(
                  leading: item.imagem != null
                      ? Image.asset(item.imagem) // Exibe a imagem do item, se existir
                      : Icon(Icons.fastfood), // Ícone padrão se não houver imagem
                  title: Text(item.nome),
                  subtitle: Text('R\$ ${item.preco.toStringAsFixed(2)}'),
                  trailing: Icon(Icons.add_shopping_cart),
                  onTap: () {
                    // Ação ao clicar no item, se necessário
                    _exibirDetalhesItem(context, item);
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }

  // Método para exibir os detalhes de um item em um diálogo
  void _exibirDetalhesItem(BuildContext context, Item item) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(item.nome),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              item.imagem != null
                  ? Image.asset(item.imagem) // Exibe a imagem do item, se existir
                  : Icon(Icons.fastfood), // Ícone padrão se não houver imagem
              SizedBox(height: 10),
              Text(item.descricao),
              SizedBox(height: 10),
              Text('Preço: R\$ ${item.preco.toStringAsFixed(2)}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Fecha o diálogo
              },
              child: Text('Fechar'),
            ),
          ],
        );
      },
    );
  }
}
