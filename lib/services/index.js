const express = require('express');
const axios = require('axios');
const bodyParser = require('body-parser');
const app = express();
const port = 3000;

let carrinho = [];
let compras = [];

app.use(bodyParser.json());

app.get('/', (req, res) => {
  res.send('Servidor está rodando!');
});

// Rota para obter produtos do fornecedor 1
app.get('/produtos1', async (req, res) => {
  try {
    const response = await axios.get('http://616d6bdb6dacbb001794ca17.mockapi.io/devnology/brazilian_provider');
    res.json(response.data);
  } catch (error) {
    res.status(500).json({ error: 'Erro ao buscar produtos do fornecedor 1' });
  }
});

// Rota para obter produtos do fornecedor 2
app.get('/produtos2', async (req, res) => {
  try {
    const response = await axios.get('http://616d6bdb6dacbb001794ca17.mockapi.io/devnology/european_provider');
    res.json(response.data);
  } catch (error) {
    res.status(500).json({ error: 'Erro ao buscar produtos do fornecedor 2' });
  }
});

// Rota para adicionar produtos no carrinho de compras
app.post('/carrinho', (req, res) => {
  const produto = req.body;

  // Adiciona o produto ao carrinho
  carrinho.push(produto);

  console.log('Produto adicionado ao carrinho:', produto);
  res.status(200).json({ message: 'Produto adicionado ao carrinho!', carrinho });
});

// Rota para obter produtos do carrinho de compras
app.get('/carrinho', (req, res) => {
  console.log('Requisição para obter o carrinho');
  res.status(200).json(carrinho);
});

// Rota para deletar produtos do carrinho de compras
app.delete('/carrinho/:id', (req, res) => {
  const id = req.params.id;

  // Encontra o índice do produto com o ID especificado
  const index = carrinho.findIndex(produto => produto.id === id);

  // Verifica se o produto foi encontrado
  if (index === -1) {
    return res.status(404).json({ message: 'Produto não encontrado no carrinho!' });
  }

  // Remove o produto do carrinho
  const produtoRemovido = carrinho.splice(index, 1);

  console.log('Produtos no carrinho após remoção:', carrinho);
  res.status(200).json({ message: 'Produto removido do carrinho!', produtoRemovido, carrinho });
});

// Rota para comprar os produtos do carrinho de compras
app.post('/compra', (req, res) => {
  const compra = req.body;

  // Verifica se o corpo da requisição contém a lista de produtos
  if (!compra.produtos || !Array.isArray(compra.produtos)) {
    return res.status(400).json({ message: 'A requisição deve conter uma lista de produtos.' });
  }

  // Adiciona a compra (lista de produtos) à lista de compras
  compras.push(...compra.produtos);

  console.log('Produtos adicionados ao historico de compras:', compra.produtos);
  res.status(200).json({ message: 'Compra realizada com sucesso!', compras });
});

// Rota para obter as compras realizadas
app.get('/compra', (req, res) => {
  console.log('Requisição para obter as compras');
  res.status(200).json(compras);
});

// Iniciar o servidor
app.listen(port, () => {
  console.log(`Servidor rodando em http://localhost:${port}`);
});
