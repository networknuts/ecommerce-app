import express from 'express';
import { createProxyMiddleware } from 'http-proxy-middleware';
import cors from 'cors';

const app = express();
app.use(cors());
app.use(express.json());

// Service routes configuration
const services = {
  homepage: 'http://homepage:3001',
  catalog: 'http://catalog:3002',
  cart: 'http://cart:3003',
  checkout: 'http://checkout:3004'
};

// Proxy middleware setup
app.use('/api/homepage', createProxyMiddleware({ 
  target: services.homepage,
  changeOrigin: true,
  pathRewrite: {'^/api/homepage': ''}
}));

app.use('/api/catalog', createProxyMiddleware({ 
  target: services.catalog,
  changeOrigin: true,
  pathRewrite: {'^/api/catalog': ''}
}));

app.use('/api/cart', createProxyMiddleware({ 
  target: services.cart,
  changeOrigin: true,
  pathRewrite: {'^/api/cart': ''}
}));

app.use('/api/checkout', createProxyMiddleware({ 
  target: services.checkout,
  changeOrigin: true,
  pathRewrite: {'^/api/checkout': ''}
}));

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`API Gateway running on port ${PORT}`);
});