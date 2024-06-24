DROP DATABASE IF EXISTS optica;
CREATE DATABASE optica DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci ;

USE optica;

SET FOREIGN_KEY_CHECKS=0;

-- Creacio de les taules

CREATE TABLE adreca (
    id_adreca INT AUTO_INCREMENT PRIMARY KEY,
    carrer VARCHAR(255) NOT NULL,
    numero VARCHAR(10) NOT NULL,
    pis VARCHAR(10),
    porta VARCHAR(10),
    ciutat VARCHAR(100) NOT NULL,
    codi_postal VARCHAR(10) NOT NULL,
    pais VARCHAR(100) NOT NULL
) ENGINE=InnoDB;

CREATE TABLE proveidor (
    id_proveidor INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    id_adreca INT,
    telefon VARCHAR(20),
    fax VARCHAR(20),
    NIF VARCHAR(20) NOT NULL,
    FOREIGN KEY (id_adreca) REFERENCES adreca(id_adreca) ON UPDATE CASCADE ON DELETE SET NULL
) ENGINE=InnoDB;

CREATE TABLE marca (
    id_marca INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
	id_proveidor INT NOT NULL,
    FOREIGN KEY (id_proveidor) REFERENCES proveidor(id_proveidor) ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE ulleres (
    id_ulleres INT AUTO_INCREMENT PRIMARY KEY,
    id_proveidor INT,
    id_marca INT,
    graduacio_vidre VARCHAR(50) NOT NULL,
    tipo_muntura VARCHAR(50) NOT NULL CHECK (tipo_muntura IN ('flotant', 'pasta', 'metallica')),
    color_muntura VARCHAR(50) NOT NULL,
    color_vidre VARCHAR(50) NOT NULL,
    preu DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (id_proveidor) REFERENCES proveidor(id_proveidor) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (id_marca) REFERENCES marca(id_marca) ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE treballador (
    id_treballador INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    id_adreca INT,
    telefon VARCHAR(20),
    correu_electronic VARCHAR(100),
    data_registre DATE NOT NULL,
    FOREIGN KEY (id_adreca) REFERENCES adreca(id_adreca) ON UPDATE CASCADE ON DELETE SET NULL
) ENGINE=InnoDB;

CREATE TABLE client (
    id_client INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    id_adreca INT,
    telefon VARCHAR(20),
    correu_electronic VARCHAR(100),
    data_registre DATE NOT NULL,
    id_client_recomanador INT,
    FOREIGN KEY (id_adreca) REFERENCES adreca(id_adreca) ON UPDATE CASCADE ON DELETE SET NULL,
    FOREIGN KEY (id_client_recomanador) REFERENCES client(id_client) ON UPDATE CASCADE ON DELETE SET NULL
) ENGINE=InnoDB;

CREATE TABLE venda (
    id_venda INT AUTO_INCREMENT PRIMARY KEY,
    id_client INT,
    id_treballador INT,
    id_ulleres INT,
    data_venda DATE NOT NULL,
    FOREIGN KEY (id_client) REFERENCES client(id_client) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (id_treballador) REFERENCES treballador(id_treballador) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (id_ulleres) REFERENCES ulleres(id_ulleres) ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB;

-- Insercions a les taules

INSERT INTO adreca (carrer, numero, pis, porta, ciutat, codi_postal, pais)
VALUES
    ('Carrer Gran Via', '123', '2', '4', 'Barcelona', '08001', 'Espanya'),
    ('Avinguda Diagonal', '456', '1', '2', 'Madrid', '28001', 'Espanya'),
    ('Carrer de Sants', '789', NULL, NULL, 'Barcelona', '08028', 'Espanya'),
    ('Carrer Passeig de Gràcia', '1011', '3', 'B', 'Barcelona', '08007', 'Espanya'),
    ('Plaça Catalunya', '1415', '4', '1', 'Barcelona', '08002', 'Espanya');

INSERT INTO proveidor (nom, id_adreca, telefon, fax, NIF)
VALUES
    ('Óptica Lens', 1, '932456789', '932456788', 'A12345678'),
    ('Gafas Súper Visión', 2, '917654321', '917654322', 'B87654321'),
    ('Optimóptica', 3, '933333333', '933333332', 'C76543210'),
    ('Vista Claro', 4, '910000000', '910000001', 'D98765432'),
    ('Gafas Únicas', 5, '934444444', '934444445', 'E54321098');

INSERT INTO marca (nom, id_proveidor)
VALUES
    ('Ray-Ban', 2),
    ('Oakley', 1),
    ('Persol', 3),
    ('Prada', 4),
    ('Lozza', 5);

INSERT INTO ulleres (id_proveidor, id_marca, graduacio_vidre, tipo_muntura, color_muntura, color_vidre, preu)
VALUES
    (2, 1, '+1.00 / -0.75', 'metallica', 'negre', 'gris', 150.00),
    (1, 2, '+2.50 / -1.25', 'pasta', 'blau', 'transparent', 180.50),
    (3, 3, '+1.75 / -1.00', 'flotant', 'marró', 'verd', 200.75),
    (4, 4, '+3.00 / -1.50', 'pasta', 'negre', 'blau', 220.00),
    (5, 5, '+2.25 / -1.50', 'metallica', 'marró', 'marró', 250.00);

INSERT INTO treballador (nom, id_adreca, telefon, correu_electronic, data_registre)
VALUES
    ('Elena Gómez', 1, '666111222', 'elena.gomez@example.com', '2023-05-10'),
    ('Marc Sánchez', 2, '677222333', 'marc.sanchez@example.com', '2023-05-11'),
    ('Laura Pérez', 3, '688333444', 'laura.perez@example.com', '2023-05-12'),
    ('Jordi Martínez', 4, '699444555', 'jordi.martinez@example.com', '2023-05-13'),
    ('Anna Ruiz', 5, '600555666', 'anna.ruiz@example.com', '2023-05-14');

INSERT INTO client (nom, id_adreca, telefon, correu_electronic, data_registre, id_client_recomanador)
VALUES
    ('Carla López', 1, '666111333', 'carla.lopez@example.com', '2023-06-01', 2),
    ('Pablo García', 2, '677222444', 'pablo.garcia@example.com', '2023-06-02', 1),
    ('Sara Martín', 3, '688333555', 'sara.martin@example.com', '2023-06-03', NULL),
    ('David Torres', 4, '699444666', 'david.torres@example.com', '2023-06-04', NULL),
    ('Nuria Fernández', 5, '600555777', 'nuria.fernandez@example.com', '2023-06-05', 4);

INSERT INTO venda (id_client, id_treballador, id_ulleres, data_venda)
VALUES
    (1, 1, 1, '2023-06-15'),
    (2, 2, 2, '2023-06-16'),
    (3, 3, 3, '2023-06-17'),
    (4, 4, 4, '2023-06-18'),
    (5, 5, 5, '2023-06-19');

SET FOREIGN_KEY_CHECKS=1;