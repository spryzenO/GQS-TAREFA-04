mkdir product-api
cd product-api
npm init -y

npm install express
npm install jest supertest --save-dev

"scripts": {
  "test": "jest"
}

const express = require('express');
const app = express();
const port = 3000;

app.use(express.json());

let products = [];
let nextId = 1;

// Criar um novo produto
app.post('/products', (req, res) => {
  const product = { id: nextId++, ...req.body };
  products.push(product);
  res.status(201).json(product);
});

// Listar todos os produtos
app.get('/products', (req, res) => {
  res.json(products);
});

// Obter um produto específico por ID
app.get('/products/:id', (req, res) => {
  const product = products.find(p => p.id == req.params.id);
  if (product) {
    res.json(product);
  } else {
    res.status(404).send('Product not found');
  }
});

// Atualizar um produto existente por ID
app.put('/products/:id', (req, res) => {
  const index = products.findIndex(p => p.id == req.params.id);
  if (index !== -1) {
    products[index] = { id: parseInt(req.params.id), ...req.body };
    res.json(products[index]);
  } else {
    res.status(404).send('Product not found');
  }
});

// Deletar um produto por ID
app.delete('/products/:id', (req, res) => {
  const index = products.findIndex(p => p.id == req.params.id);
  if (index !== -1) {
    products.splice(index, 1);
    res.status(204).send();
  } else {
    res.status(404).send('Product not found');
  }
});

app.listen(port, () => {
  console.log(`API listening at http://localhost:${port}`);
});

module.exports = app;

