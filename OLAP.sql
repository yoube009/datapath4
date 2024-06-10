-- Crea la DB en caso de no existir
CREATE DATABASE IF NOT EXISTS OLAP_Credit_Card_Transactions_Fraud_Detection;
-- Uso de la base de datos OLAP si ya existe
USE OLAP_Credit_Card_Transactions_Fraud_Detection;

-- Creación de la tabla de dimensión Tiempo
CREATE TABLE IF NOT EXISTS DimTiempo (
    tiempo_id INT PRIMARY KEY AUTO_INCREMENT,
    fecha DATETIME NOT NULL,
    annio INT,
    mes INT,
    dia INT,
    hora INT
);

-- Creación de la tabla de dimensión Cliente
CREATE TABLE IF NOT EXISTS DimCliente (
    cc_num BIGINT PRIMARY KEY,
    first VARCHAR(100),
    last VARCHAR(100),
    dob DATE,
    gender VARCHAR(10)
);

-- Creación de la tabla de dimensión Direccion
CREATE TABLE IF NOT EXISTS DimDireccion (
    direccion_id INT PRIMARY KEY AUTO_INCREMENT,
    street VARCHAR(255),
    city_name VARCHAR(100),
    state_name VARCHAR(100),
    zip VARCHAR(20),
    lat DECIMAL(9,6),
    longi DECIMAL(9,6)
);

-- Creación de la tabla de dimensión Comercio
CREATE TABLE IF NOT EXISTS DimComercio (
    comercio_id INT PRIMARY KEY AUTO_INCREMENT,
    merchant_name VARCHAR(255),
    category VARCHAR(100)
);

-- Creación de la tabla de dimensión Empleo
CREATE TABLE IF NOT EXISTS DimEmpleo (
    empleo_id INT PRIMARY KEY AUTO_INCREMENT,
    job_description VARCHAR(255)
);

-- Creación de la tabla de hechos Transacciones
CREATE TABLE IF NOT EXISTS HechosTransacciones (
    transaccion_id INT PRIMARY KEY AUTO_INCREMENT,
    cc_num BIGINT,
    direccion_id INT,
    tiempo_id INT,
    comercio_id INT,
    empleo_id INT,
    amt DECIMAL(10,2),
    is_fraud BIT,
    unix_time BIGINT,
    FOREIGN KEY (cc_num) REFERENCES DimCliente(cc_num),
    FOREIGN KEY (direccion_id) REFERENCES DimDireccion(direccion_id),
    FOREIGN KEY (tiempo_id) REFERENCES DimTiempo(tiempo_id),
    FOREIGN KEY (comercio_id) REFERENCES DimComercio(comercio_id),
    FOREIGN KEY (empleo_id) REFERENCES DimEmpleo(empleo_id)
);