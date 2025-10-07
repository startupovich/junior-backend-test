-- Таблица категорий с иерархической структурой (self-referencing)
CREATE TABLE categories (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    parent_id INTEGER REFERENCES categories(id) -- Ссылка на родительскую категорию
    -- parent_id IS NULL для корневых категорий
);

-- Таблица номенклатуры (товаров)
CREATE TABLE products (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    quantity INTEGER NOT NULL DEFAULT 0,
    -- Цена добавлена, т.к. без неё невозможно посчитать сумму заказа
    price NUMERIC(10, 2) NOT NULL,
    category_id INTEGER NOT NULL REFERENCES categories(id)
);

-- Таблица клиентов
CREATE TABLE clients (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    address TEXT
);

-- Таблица заказов
CREATE TABLE orders (
    id SERIAL PRIMARY KEY,
    client_id INTEGER NOT NULL REFERENCES clients(id),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Таблица-связка для заказов и товаров (many-to-many)
CREATE TABLE order_items (
    order_id INTEGER NOT NULL REFERENCES orders(id),
    product_id INTEGER NOT NULL REFERENCES products(id),
    quantity INTEGER NOT NULL CHECK (quantity > 0),
    PRIMARY KEY (order_id, product_id) -- Гарантирует уникальность товара в рамках одного заказа
);