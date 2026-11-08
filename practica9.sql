DROP TABLE IF EXISTS empleado CASCADE;
DROP TABLE IF EXISTS departamento CASCADE;
DROP TABLE IF EXISTS cliente CASCADE;
DROP TABLE IF EXISTS producto CASCADE;
DROP TABLE IF EXISTS detalle_pedido CASCADE;
DROP TABLE IF EXISTS pedido CASCADE;


CREATE TABLE IF NOT EXISTS empleado (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(50),
    puesto VARCHAR(50),
    salario NUMERIC(10,2),
    fecha_contratacion DATE
);


CREATE TABLE IF NOT EXISTS departamento (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(50)
);


INSERT INTO empleado (nombre, puesto, salario, fecha_contratacion)
VALUES ('Ana Torres', 'Analista', 15000, '2026-10-02');


CREATE TABLE IF NOT EXISTS cliente (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    direccion VARCHAR(100)
);


CREATE TABLE IF NOT EXISTS producto (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    precio NUMERIC(10,2)
);


CREATE TABLE IF NOT EXISTS pedido (
    id SERIAL PRIMARY KEY,
    cliente_id INT NOT NULL REFERENCES cliente(id),
    fecha DATE NOT NULL
);


CREATE TABLE IF NOT EXISTS detalle_pedido (
    pedido_id INT NOT NULL REFERENCES pedido(id),
    producto_id INT NOT NULL REFERENCES producto(id),
    cantidad INT NOT NULL,
    PRIMARY KEY(pedido_id, producto_id)
);

INSERT INTO empleado (nombre, puesto, salario, fecha_contratacion)
VALUES 
('Ana Torres', 'Analista', 15000, '2026-10-02'),
('Luis Gómez', 'Gerente', 30000, '2026-09-15'),
('Marta Ruiz', 'Desarrolladora', 22000, '2026-08-10'),
('Carlos Pérez', 'Soporte', 14000, '2026-07-01'),
('Diana López', 'Analista', 16000, '2026-10-01');

INSERT INTO departamento (nombre)
VALUES 
('Recursos Humanos'),
('Finanzas'),
('Tecnología'),
('Ventas');

INSERT INTO cliente (nombre, direccion) VALUES
('Luis Gómez', 'Av. Universidad 123'),
('Marta Ruiz', 'Calle Reforma 456'),
('Carlos Pérez', 'Av. Central 789'),
('Diana López', 'Calle Norte 22'),
('Ana Torres', 'Av. Sur 77');

INSERT INTO producto (nombre, precio) VALUES
('Libro A', 250.00),
('Libro B', 300.00),
('Libro C', 150.00),
('Laptop', 25000.00),
('Mouse', 500.00);

INSERT INTO pedido (cliente_id, fecha) VALUES
(1, '2026-10-05'),
(2, '2026-10-06'),
(3, '2026-10-07'),
(4, '2026-10-08'),
(5, '2026-10-09');

INSERT INTO detalle_pedido (pedido_id, producto_id, cantidad)
VALUES 
(1, 1, 2),
(1, 2, 1),
(2, 3, 3),
(3, 4, 1),
(4, 5, 2),
(5, 2, 1)
ON CONFLICT (pedido_id, producto_id)
DO UPDATE SET cantidad = detalle_pedido.cantidad + EXCLUDED.cantidad;

CREATE ROLE lector LOGIN PASSWORD 'lector123';
CREATE ROLE editor LOGIN PASSWORD 'editor123';


GRANT CONNECT ON DATABASE practica9 TO lector;
GRANT CONNECT ON DATABASE practica9 TO editor;

GRANT USAGE ON SCHEMA public TO lector;
GRANT USAGE ON SCHEMA public TO editor;

GRANT SELECT ON ALL TABLES IN SCHEMA public TO lector;

GRANT SELECT, INSERT, UPDATE
ON ALL TABLES IN SCHEMA public
TO editor;

REVOKE DELETE
ON ALL TABLES IN SCHEMA public
FROM editor;

REVOKE INSERT
ON empleado
FROM editor;

SELECT
    grantee,
    table_name,
    privilege_type
FROM information_schema.role_table_grants
WHERE grantee IN ('lector', 'editor');