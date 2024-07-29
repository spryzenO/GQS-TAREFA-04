const request = require('supertest');
const app = require('../index');

describe('Products API', () => {
  let productId;

  it('should create a new product', async () => {
    const response = await request(app)
      .post('/products')
      .send({ name: 'Product 1', price: 100 });

    expect(response.status).toBe(201);
    expect(response.body).toHaveProperty('id');
    expect(response.body.name).toBe('Product 1');
    expect(response.body.price).toBe(100);

    productId = response.body.id;
  });

  it('should list all products', async () => {
    const response = await request(app).get('/products');

    expect(response.status).toBe(200);
    expect(response.body).toHaveLength(1);
    expect(response.body[0].id).toBe(productId);
  });

  it('should get a product by id', async () => {
    const response = await request(app).get(`/products/${productId}`);

    expect(response.status).toBe(200);
    expect(response.body.id).toBe(productId);
  });

  it('should update a product by id', async () => {
    const response = await request(app)
      .put(`/products/${productId}`)
      .send({ name: 'Product 1 Updated', price: 150 });

    expect(response.status).toBe(200);
    expect(response.body.name).toBe('Product 1 Updated');
    expect(response.body.price).toBe(150);
  });

  it('should delete a product by id', async () => {
    const response = await request(app).delete(`/products/${productId}`);

    expect(response.status).toBe(204);
  });

  it('should return 404 for a non-existing product', async () => {
    const response = await request(app).get(`/products/${productId}`);

    expect(response.status).toBe(404);
  });
});

