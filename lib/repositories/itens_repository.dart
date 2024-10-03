// lib/repositories/itens_repository.dart

import 'package:projeto/models/item.dart';

class ItemRepository {
  // Lista interna simulando o banco de dados de itens do cardápio
  final List<Item> _itens = [
    Item(
      id: 1,
      nome: 'Podrão da Casa',
      descricao:
          'Hambúrguer de picanha bovina completo com queijo, bacon, ovo, ovo de codorna, presunto, alface, pickles, banana, palmito, cebola, rúcula, tomate, maionese e batata-palha. Porção com 5 nuggets de frango empanados.',
      preco: 45.00,
      icone: 'new_releases',
      imagem: '', // Caminho para imagem (pode ser adicionado mais tarde)
    ),
    Item(
      id: 2,
      nome: 'X-Burguer',
      descricao: 'Hambúrguer com queijo, alface, tomate e maionese.',
      preco: 12.00,
      icone: 'fastfood',
      imagem: '',
    ),
    Item(
      id: 3,
      nome: 'X-Salada',
      descricao: 'Hambúrguer com queijo, salada de alface, tomate, cebola e maionese.',
      preco: 14.00,
      icone: 'restaurant',
      imagem: '',
    ),
    Item(
      id: 4,
      nome: 'X-Bacon',
      descricao: 'Hambúrguer com queijo, bacon crocante, alface, tomate e maionese.',
      preco: 16.00,
      icone: 'bacon',
      imagem: '',
    ),
    Item(
      id: 5,
      nome: 'X-Tudo',
      descricao: 'Hambúrguer completo com queijo, bacon, ovo, presunto, alface, tomate e maionese.',
      preco: 18.00,
      icone: 'dining',
      imagem: '',
    ),
    Item(
      id: 6,
      nome: 'Cachorro-Quente',
      descricao: 'Pão de hot dog com salsicha, purê de batata, milho, ervilha e molho de tomate.',
      preco: 10.00,
      icone: 'hotdog',
      imagem: '',
    ),
    Item(
      id: 7,
      nome: 'Coca-Cola 350ml',
      descricao: 'Refrigerante Coca-Cola lata 350ml.',
      preco: 5.00,
      icone: 'local_drink',
      imagem: '',
    ),
    Item(
      id: 8,
      nome: 'Guaraná Antarctica 350ml',
      descricao: 'Refrigerante Guaraná lata 350ml.',
      preco: 5.00,
      icone: 'local_drink',
      imagem: '',
    ),
    Item(
      id: 9,
      nome: 'Suco de Laranja Natural',
      descricao: 'Suco de laranja natural feito na hora.',
      preco: 7.00,
      icone: 'emoji_food_beverage',
      imagem: '',
    ),
    Item(
      id: 10,
      nome: 'Batata Frita',
      descricao: 'Porção de batatas fritas crocantes.',
      preco: 8.00,
      icone: 'fries',
      imagem: '',
    ),
    Item(
      id: 11,
      nome: 'Onion Rings',
      descricao: 'Anéis de cebola empanados e fritos.',
      preco: 9.00,
      icone: 'circle',
      imagem: '',
    ),
    Item(
      id: 12,
      nome: 'Nuggets de Frango',
      descricao: 'Porção com 10 nuggets de frango empanados.',
      preco: 10.00,
      icone: 'restaurant_menu',
      imagem: '',
    ),
    Item(
      id: 13,
      nome: 'Desafio Podrão',
      descricao: 'Comeu tudo, não paga nada e ganha R\$20 da casa. Se não comer, paga R\$80.',
      preco: 80.00,
      icone: 'star',
      imagem: '',
    ),
  ];

  // Simula a busca de todos os itens do "banco"
  Future<List<Item>> buscarItens() async {
    return _itens;
  }

  // Simula a adição de um novo item na lista
  Future<void> criarItem(Item item) async {
    _itens.add(item);
  }

  // Simula a busca de um item por ID
  Future<Item?> buscarItemPorId(int id) async {
    return _itens.firstWhere((item) => item.id == id); 
    //, orElse: () => null);
  }

  // Simula a atualização de um item na lista
  Future<void> atualizarItem(Item item) async {
    int index = _itens.indexWhere((i) => i.id == item.id);
    if (index != -1) {
      _itens[index] = item;
    }
  }

  // Simula a exclusão de um item da lista
  Future<void> deletarItem(int id) async {
    _itens.removeWhere((item) => item.id == id);
  }
}
