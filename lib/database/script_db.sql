-- Criar tabela de usuários
CREATE TABLE usuarios (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  nome TEXT NOT NULL,
  email TEXT NOT NULL UNIQUE,
  senha TEXT NOT NULL,
  tipo TEXT NOT NULL
);

-- Criar tabela de pedidos
CREATE TABLE pedidos (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  usuario_id INTEGER,
  data_pedido TEXT,
  valor_total REAL,
  FOREIGN KEY(usuario_id) REFERENCES usuarios(id)
);

-- Criar tabela de cardápio
CREATE TABLE cardapio (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  nome TEXT NOT NULL,
  descricao TEXT NOT NULL,
  preco REAL NOT NULL,
  icone TEXT NOT NULL
);

-- Criar tabela de itens_pedido
CREATE TABLE itens_pedido (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  pedido_id INTEGER,
  cardapio_id INTEGER,
  quantidade INTEGER,
  preco_unitario REAL,
  FOREIGN KEY(pedido_id) REFERENCES pedidos(id),
  FOREIGN KEY(cardapio_id) REFERENCES cardapio(id)
);

-- Inserir dados iniciais no cardápio
INSERT INTO cardapio (nome, descricao, preco, icone) VALUES
('Podrão da Casa', 'Hambúrguer de picanha bovina completo com queijo, bacon, ovo, ovo de codorna, presunto, alface, pickles, banana, palmito, cebola, rúcula, tomate, maionese e batata-palha. Porção com 5 nuggets de frango empanados.', 45.00, 'new_releases'),
('X-Burguer', 'Hambúrguer com queijo, alface, tomate e maionese.', 12.00, 'fastfood'),
('X-Salada', 'Hambúrguer com queijo, salada de alface, tomate, cebola e maionese.', 14.00, 'restaurant'),
('X-Bacon', 'Hambúrguer com queijo, bacon crocante, alface, tomate e maionese.', 16.00, 'bacon'),
('X-Tudo', 'Hambúrguer completo com queijo, bacon, ovo, presunto, alface, tomate e maionese.', 18.00, 'dining'),
('Cachorro-Quente', 'Pão de hot dog com salsicha, purê de batata, milho, ervilha e molho de tomate.', 10.00, 'hotdog'),
('Coca-Cola 350ml', 'Refrigerante Coca-Cola lata 350ml.', 5.00, 'local_drink'),
('Guaraná Antarctica 350ml', 'Refrigerante Guaraná lata 350ml.', 5.00, 'local_drink'),
('Suco de Laranja Natural', 'Suco de laranja natural feito na hora.', 7.00, 'emoji_food_beverage'),
('Batata Frita', 'Porção de batatas fritas crocantes.', 8.00, 'fries'),
('Onion Rings', 'Anéis de cebola empanados e fritos.', 9.00, 'circle'),
('Nuggets de Frango', 'Porção com 10 nuggets de frango empanados.', 10.00, 'restaurant_menu'),
('Desafio Podrão', 'Comeu tudo, não paga nada e ganha R\$20 da casa. Se não comer, paga R\$80.', 80.00, 'star');