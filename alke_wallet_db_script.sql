/* =========================================================
   PASO 1: CREAR LA BASE DE DATOS
   Nota en PostgreSQL: Ejecuta esto conectado a la base 'postgres'.
   Luego, cambia la conexión en DBeaver a 'AlkeWallet'.
   ========================================================= */
CREATE DATABASE "AlkeWallet";

-- (Cambia tu conexión en DBeaver a la base de datos AlkeWallet antes de continuar)

/* =========================================================
   PASO 2: CREAR LAS 3 TABLAS (DDL)
   ========================================================= */

-- Tabla 1: Moneda (Tabla independiente)
CREATE TABLE moneda (
    currency_id SERIAL PRIMARY KEY,
    currency_name VARCHAR(50) NOT NULL UNIQUE,
    currency_symbol VARCHAR(10) NOT NULL
);
-- Comprobación Tabla 1
SELECT * FROM moneda;

-- Tabla 2: Usuario (Depende de moneda)
-- Nota: Se agregó 'currency_id' para responder a la pista de la consigna.
CREATE TABLE usuario (
    user_id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    correo_electronico VARCHAR(100) NOT NULL UNIQUE,
    contraseña VARCHAR(255) NOT NULL,
    saldo DECIMAL(15, 2) NOT NULL DEFAULT 0.00,
    currency_id INT NOT NULL,
    CONSTRAINT fk_usuario_moneda FOREIGN KEY (currency_id) REFERENCES moneda(currency_id)
);

-- Comprobación Tabla 2
SELECT * FROM usuario;

-- Tabla 3: Transaccion (Depende de usuario)
CREATE TABLE transaccion (
    transaction_id SERIAL PRIMARY KEY,
    sender_user_id INT NOT NULL,
    receiver_user_id INT NOT NULL,
    importe DECIMAL(15, 2) NOT NULL CHECK (importe > 0),
    transaction_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_sender FOREIGN KEY (sender_user_id) REFERENCES usuario(user_id),
    CONSTRAINT fk_receiver FOREIGN KEY (receiver_user_id) REFERENCES usuario(user_id)
);

-- Comprobación Tabla 3
SELECT * FROM transaccion;

/* =========================================================
   PASO 3: INSERTAR DATOS DE PRUEBA (DML)
   ========================================================= */

-- Insertar 3 Monedas
INSERT INTO moneda (currency_name, currency_symbol) VALUES 
('Peso Chileno', 'CLP'),
('Dólar Estadounidense', 'USD'),
('Euro', 'EUR');

-- Comprobación 3 Monedas
SELECT * FROM moneda;

-- Insertar 4 Usuarios (Asignando un currency_id válido)
INSERT INTO usuario (nombre, correo_electronico, contraseña, saldo, currency_id) VALUES 
('Ana Silva', 'ana@email.com', 'hash123', 50000.00, 1),
('Carlos Gomez', 'carlos@email.com', 'hash456', 150.00, 2),
('Beatriz Rojas', 'beatriz@email.com', 'hash789', 300.50, 3),
('Daniel Toro', 'daniel@email.com', 'hash000', 15000.00, 1);

-- Comprobación 4 Usuarios
SELECT * FROM usuario;

-- Insertar 5 Transacciones
INSERT INTO transaccion (sender_user_id, receiver_user_id, importe) VALUES 
(1, 4, 5000.00),
(2, 3, 25.50),
(4, 1, 1500.00),
(3, 2, 10.00),
(1, 4, 2000.00);

-- Comprobación 5 Transacciones
SELECT * FROM transaccion;

/* =========================================================
   PASO 4: LAS 5 CONSULTAS OBLIGATORIAS
   ========================================================= */

-- 1. Obtener el nombre de la moneda elegida por un usuario específico (ej. user_id = 1)
SELECT u.nombre, m.currency_name, m.currency_symbol 
FROM usuario u
JOIN moneda m ON u.currency_id = m.currency_id
WHERE u.user_id = 1;

-- 2. Traer todas las transacciones registradas
SELECT * FROM transaccion;

-- 3. Ver todas las transacciones realizadas por un único usuario (ej. user_id = 1 como remitente o receptor)
SELECT * FROM transaccion 
WHERE sender_user_id = 1 OR receiver_user_id = 1;

-- 4. Actualizar el correo electrónico de un usuario (ej. user_id = 2)
-- Comprobación antes de actualizar correo usuario
SELECT * FROM usuario;

UPDATE usuario 
SET correo_electronico = 'carlos.nuevo@email.com' 
WHERE user_id = 2;

-- Comprobación después de actualizar correo usuario
SELECT * FROM usuario;

-- 5. Eliminar los datos de una transacción (ej. transaction_id = 5)
-- Comprobación antes de eliminar transacción
SELECT * FROM transaccion;

DELETE FROM transaccion 
WHERE transaction_id = 5;

-- Comprobación después de eliminar transacción
SELECT * FROM transaccion;

/* =========================================================
   PASO 5: TRANSACCIONALIDAD (ACID)
   ========================================================= */

-- EJEMPLO 1: Transacción Exitosa (COMMIT)
START TRANSACTION;
UPDATE usuario SET saldo = saldo - 1000 WHERE user_id = 1;
UPDATE usuario SET saldo = saldo + 1000 WHERE user_id = 4;
INSERT INTO transaccion (sender_user_id, receiver_user_id, importe) VALUES (1, 4, 1000);
COMMIT;

-- Comprobación después del COMMIT
SELECT * FROM transaccion;

-- EJEMPLO 2: Error Intencional y Reversión (ROLLBACK)
START TRANSACTION;
UPDATE usuario SET saldo = saldo - 500 WHERE user_id = 2;
-- Provocamos un error de Clave Foránea ingresando un usuario receptor que no existe (user_id = 999)
INSERT INTO transaccion (sender_user_id, receiver_user_id, importe) VALUES (2, 999, 500);
-- Al fallar, ejecutamos ROLLBACK para revertir el UPDATE del saldo
ROLLBACK;

-- Comprobación después del ROLLBACK
SELECT * FROM transaccion;
