-- Crea la DB en caso de no existir
CREATE DATABASE IF NOT EXISTS OLTP_Credit_Card_Transactions_Fraud_Detection;
-- Usa la DB que se acaba de crear o la que ya estuvo creada
USE OLTP_Credit_Card_Transactions_Fraud_Detection;

-- Creación de la tabla para géneros
CREATE TABLE IF NOT EXISTS Cliente_genero (
    gender_id INT AUTO_INCREMENT PRIMARY KEY,
    gender VARCHAR(10) NOT NULL
);

-- Creación de la tabla para estados
CREATE TABLE IF NOT EXISTS State (
    state_id INT AUTO_INCREMENT PRIMARY KEY,
    state_name VARCHAR(100) NOT NULL
);

-- Creación de la tabla para ciudades
CREATE TABLE IF NOT EXISTS Ciudad (
    city_id INT AUTO_INCREMENT PRIMARY KEY,
    city_name VARCHAR(100) NOT NULL,
    state_id INT,
    FOREIGN KEY (state_id) REFERENCES State(state_id)
);

-- Creación de la tabla para direcciones
CREATE TABLE IF NOT EXISTS Address (
    address_id INT AUTO_INCREMENT PRIMARY KEY,
    street VARCHAR(255) NOT NULL,
    city_id INT,
    zip VARCHAR(20),
    lat DECIMAL(9,6),
    longi DECIMAL(9,6),
    FOREIGN KEY (city_id) REFERENCES Ciudad(city_id)
);

-- Creación de la tabla para clientes
CREATE TABLE IF NOT EXISTS Cliente (
    cc_num BIGINT PRIMARY KEY,
    first VARCHAR(100),
    last VARCHAR(100),
    dob DATE,
    gender_id INT,
    address_id INT,
    FOREIGN KEY (gender_id) REFERENCES Cliente_genero(gender_id),
    FOREIGN KEY (address_id) REFERENCES Address(address_id)
);

-- Creación de la tabla para ubicaciones de comercio
CREATE TABLE IF NOT EXISTS comercio_loc (
    merch_loc_id INT AUTO_INCREMENT PRIMARY KEY,
    merch_lat DECIMAL(9,6),
    merch_long DECIMAL(9,6)
);

-- Creación de la tabla para categorías de comercio
CREATE TABLE IF NOT EXISTS comercio_cat (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    category VARCHAR(100)
);

-- Creación de la tabla para comercio
CREATE TABLE IF NOT EXISTS Comercio (
    merchant_id INT AUTO_INCREMENT PRIMARY KEY,
    merchant_name VARCHAR(255),
    category_id INT,
    merch_loc_id INT,
    FOREIGN KEY (category_id) REFERENCES comercio_cat(category_id),
    FOREIGN KEY (merch_loc_id) REFERENCES comercio_loc(merch_loc_id)
);

-- Creación de la tabla para transacciones
CREATE TABLE IF NOT EXISTS Transacciones (
    trans_num VARCHAR(255) PRIMARY KEY,
    cc_num BIGINT,
    trans_date_trans_time DATETIME,
    amt DECIMAL(10,2),
    unix_time BIGINT,
    is_fraud BIT,
    merchant_id INT,
    FOREIGN KEY (cc_num) REFERENCES Cliente(cc_num),
    FOREIGN KEY (merchant_id) REFERENCES Comercio(merchant_id)
);

-- Creación de la tabla para empleo
CREATE TABLE IF NOT EXISTS Empleo (
    job_id INT AUTO_INCREMENT PRIMARY KEY,
    cc_num BIGINT,
    job_description VARCHAR(255),
    FOREIGN KEY (cc_num) REFERENCES Cliente(cc_num)
);
