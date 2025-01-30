/*
  # Playfair E-commerce Initial Schema

  1. New Tables
    - categories
      - id (uuid, primary key)
      - name (text)
      - slug (text, unique)
      - description (text)
      - created_at (timestamp)
    
    - products
      - id (uuid, primary key)
      - name (text)
      - slug (text, unique)
      - description (text)
      - price (decimal)
      - category_id (uuid, foreign key)
      - image_url (text)
      - stock (integer)
      - created_at (timestamp)
    
    - cart_items
      - id (uuid, primary key)
      - user_id (uuid, foreign key)
      - product_id (uuid, foreign key)
      - quantity (integer)
      - created_at (timestamp)
    
    - orders
      - id (uuid, primary key)
      - user_id (uuid, foreign key)
      - status (text)
      - total_amount (decimal)
      - shipping_address (text)
      - created_at (timestamp)
    
    - order_items
      - id (uuid, primary key)
      - order_id (uuid, foreign key)
      - product_id (uuid, foreign key)
      - quantity (integer)
      - price_at_time (decimal)
      - created_at (timestamp)

  2. Security
    - Enable RLS on all tables
    - Add appropriate policies for each table
*/

-- Categories Table
CREATE TABLE categories (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name TEXT NOT NULL,
    slug TEXT UNIQUE NOT NULL,
    description TEXT,
    created_at TIMESTAMPTZ DEFAULT now()
);

ALTER TABLE categories ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Categories are viewable by everyone" ON categories
    FOR SELECT USING (true);

-- Products Table
CREATE TABLE products (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name TEXT NOT NULL,
    slug TEXT UNIQUE NOT NULL,
    description TEXT,
    price DECIMAL(10,2) NOT NULL,
    category_id UUID REFERENCES categories(id),
    image_url TEXT,
    stock INTEGER NOT NULL DEFAULT 0,
    created_at TIMESTAMPTZ DEFAULT now()
);

ALTER TABLE products ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Products are viewable by everyone" ON products
    FOR SELECT USING (true);

-- Cart Items Table
CREATE TABLE cart_items (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID NOT NULL REFERENCES auth.users(id),
    product_id UUID NOT NULL REFERENCES products(id),
    quantity INTEGER NOT NULL CHECK (quantity > 0),
    created_at TIMESTAMPTZ DEFAULT now()
);

ALTER TABLE cart_items ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Users can view their own cart items" ON cart_items
    FOR SELECT USING (auth.uid() = user_id);

CREATE POLICY "Users can insert their own cart items" ON cart_items
    FOR INSERT WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can update their own cart items" ON cart_items
    FOR UPDATE USING (auth.uid() = user_id);

CREATE POLICY "Users can delete their own cart items" ON cart_items
    FOR DELETE USING (auth.uid() = user_id);

-- Orders Table
CREATE TABLE orders (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID NOT NULL REFERENCES auth.users(id),
    status TEXT NOT NULL DEFAULT 'pending',
    total_amount DECIMAL(10,2) NOT NULL,
    shipping_address TEXT NOT NULL,
    created_at TIMESTAMPTZ DEFAULT now()
);

ALTER TABLE orders ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Users can view their own orders" ON orders
    FOR SELECT USING (auth.uid() = user_id);

CREATE POLICY "Users can insert their own orders" ON orders
    FOR INSERT WITH CHECK (auth.uid() = user_id);

-- Order Items Table
CREATE TABLE order_items (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    order_id UUID NOT NULL REFERENCES orders(id),
    product_id UUID NOT NULL REFERENCES products(id),
    quantity INTEGER NOT NULL CHECK (quantity > 0),
    price_at_time DECIMAL(10,2) NOT NULL,
    created_at TIMESTAMPTZ DEFAULT now()
);

ALTER TABLE order_items ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Users can view their own order items" ON order_items
    FOR SELECT USING (
        EXISTS (
            SELECT 1 FROM orders
            WHERE orders.id = order_items.order_id
            AND orders.user_id = auth.uid()
        )
    );

CREATE POLICY "Users can insert their own order items" ON order_items
    FOR INSERT WITH CHECK (
        EXISTS (
            SELECT 1 FROM orders
            WHERE orders.id = order_items.order_id
            AND orders.user_id = auth.uid()
        )
    );

-- Insert sample categories
INSERT INTO categories (name, slug, description) VALUES
    ('T-Shirts', 't-shirts', 'Comfortable and stylish t-shirts'),
    ('Jeans', 'jeans', 'Classic denim jeans'),
    ('Dresses', 'dresses', 'Beautiful dresses for all occasions'),
    ('Accessories', 'accessories', 'Complete your look with our accessories');

-- Insert sample products
INSERT INTO products (name, slug, description, price, category_id, image_url, stock) 
SELECT 
    'Classic White T-Shirt',
    'classic-white-t-shirt',
    'A timeless white t-shirt made from 100% cotton',
    29.99,
    id,
    'https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?auto=format&fit=crop&w=800',
    100
FROM categories WHERE slug = 't-shirts';

INSERT INTO products (name, slug, description, price, category_id, image_url, stock)
SELECT 
    'Slim Fit Blue Jeans',
    'slim-fit-blue-jeans',
    'Modern slim fit jeans in classic blue',
    79.99,
    id,
    'https://images.unsplash.com/photo-1542272604-787c3835535d?auto=format&fit=crop&w=800',
    50
FROM categories WHERE slug = 'jeans';

INSERT INTO products (name, slug, description, price, category_id, image_url, stock)
SELECT 
    'Floral Summer Dress',
    'floral-summer-dress',
    'Light and breezy summer dress with floral pattern',
    89.99,
    id,
    'https://images.unsplash.com/photo-1572804013309-59a88b7e92f1?auto=format&fit=crop&w=800',
    30
FROM categories WHERE slug = 'dresses';