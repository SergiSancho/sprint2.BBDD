DROP DATABASE IF EXISTS pizzeria;
CREATE DATABASE pizzeria DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

USE pizzeria;

SET FOREIGN_KEY_CHECKS = 0;

-- Creació de les taules

CREATE TABLE provincia (
    id_provincia INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(100) NOT NULL
) ENGINE=InnoDB;

CREATE TABLE localitat (
    id_localitat INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    id_provincia INT,
    FOREIGN KEY (id_provincia) REFERENCES provincia(id_provincia) ON UPDATE CASCADE ON DELETE SET NULL
) ENGINE=InnoDB;

CREATE TABLE adreca (
    id_adreca INT AUTO_INCREMENT PRIMARY KEY,
    carrer VARCHAR(255) NOT NULL,
    numero VARCHAR(10) NOT NULL,
    codi_postal VARCHAR(10) NOT NULL,
    id_localitat INT,
    FOREIGN KEY (id_localitat) REFERENCES localitat(id_localitat) ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE client (
    id_client INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    cognoms VARCHAR(100) NOT NULL,
    id_adreca INT,
    telefon VARCHAR(20),
    FOREIGN KEY (id_adreca) REFERENCES adreca(id_adreca) ON UPDATE CASCADE ON DELETE SET NULL
) ENGINE=InnoDB;

CREATE TABLE comanda (
    id_comanda INT AUTO_INCREMENT PRIMARY KEY,
    id_client INT,
    id_botiga INT,
    data_hora DATETIME NOT NULL,
    tipus ENUM('domicili', 'botiga') NOT NULL,
    preu_total DECIMAL(10, 2),
    FOREIGN KEY (id_client) REFERENCES client(id_client) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (id_botiga) REFERENCES botiga(id_botiga) ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE linia_comanda (
    id_linia_comanda INT AUTO_INCREMENT PRIMARY KEY,
    id_comanda INT,
    id_producte INT,
    quantitat INT NOT NULL,
    preu DECIMAL(10, 2),
    FOREIGN KEY (id_comanda) REFERENCES comanda(id_comanda) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (id_producte) REFERENCES producte(id_producte) ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE producte (
    id_producte INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    descripcio TEXT,
    imatge VARCHAR(255),
    preu DECIMAL(10, 2) NOT NULL,
    categoria ENUM('pizzes', 'hamburgueses', 'begudes') NOT NULL,
    id_categoria_pizza INT,
    FOREIGN KEY (id_categoria_pizza) REFERENCES categoria_pizza(id_categoria) ON UPDATE CASCADE ON DELETE SET NULL
) ENGINE=InnoDB;

CREATE TABLE categoria_pizza (
    id_categoria INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(100) NOT NULL
) ENGINE=InnoDB;

CREATE TABLE botiga (
    id_botiga INT AUTO_INCREMENT PRIMARY KEY,
    id_adreca INT,
    telefon VARCHAR(20),
    FOREIGN KEY (id_adreca) REFERENCES adreca(id_adreca) ON UPDATE CASCADE ON DELETE SET NULL
) ENGINE=InnoDB;

CREATE TABLE empleat (
    id_empleat INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    cognoms VARCHAR(100) NOT NULL,
    NIF VARCHAR(20) NOT NULL,
    telefon VARCHAR(20),
    tipus_empleat ENUM('cuiner', 'repartidor') NOT NULL,
    id_botiga INT,
    FOREIGN KEY (id_botiga) REFERENCES botiga(id_botiga) ON UPDATE CASCADE ON DELETE SET NULL
) ENGINE=InnoDB;

CREATE TABLE repartiment (
    id_comanda INT,
    id_empleat INT,
    data_hora_lliurament DATETIME NOT NULL,
    PRIMARY KEY (id_comanda),
    FOREIGN KEY (id_comanda) REFERENCES comanda(id_comanda) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (id_empleat) REFERENCES empleat(id_empleat) ON UPDATE CASCADE ON DELETE SET NULL
) ENGINE=InnoDB;

-- Insercio a les taules

INSERT INTO provincia (nom) VALUES
('Barcelona'),
('Girona'),
('Lleida'),
('Tarragona');

INSERT INTO localitat (nom, id_provincia) VALUES
('Barcelona', 1),
('Badalona', 1),
('Girona', 2),
('Lleida', 3),
('Tarragona', 4);

INSERT INTO adreca (carrer, numero, codi_postal, id_localitat) VALUES
('Carrer Major', '1', '08001', 1),
('Avinguda Diagonal', '100', '08029', 1),
('Rambla de Badalona', '50', '08911', 2),
('Carrer del Nord', '10', '17001', 3),
('Carrer de la Ciutat', '25', '25001', 4),
('Plaça de la Font', '5', '43001', 5);

INSERT INTO client (nom, cognoms, id_adreca, telefon) VALUES
('Maria', 'Garcia', 1, '612345678'),
('David', 'Martinez', 3, '635432189'),
('Laura', 'Sanchez', 5, '677891234');

INSERT INTO comanda (id_client, id_botiga, data_hora, tipus, preu_total) VALUES
(1, 1, '2024-06-24 12:30:00', 'domicili', 16.00),
(2, 2, '2024-06-25 17:45:00', 'botiga', 15.75),
(3, 3, '2024-06-26 19:30:00', 'domicili', 39.20);

INSERT INTO linia_comanda (id_comanda, id_producte, quantitat, preu) VALUES
(1, 1, 2, 12.50),  
(1, 4, 1, 3.50),   
(2, 2, 3, 5.25),  
(3, 3, 4, 9.80);  

INSERT INTO producte (nom, descripcio, imatge, preu, categoria, id_categoria_pizza) VALUES
('Pizza Margarita', 'Pizza clásica de tomate y mozzarella', 'pizza_margarita.jpg', 10.00, 'pizzes', 1),
('Hamburguesa clásica', 'Hamburguesa con carne, lechuga, tomate y queso', 'hamburguesa_clasica.jpg', 5.00, 'hamburgueses', NULL),
('Coca-Cola lata', 'Refresco de cola en lata', 'coca_cola_lata.jpg', 2.45, 'begudes', NULL),
('Pizza Pepperoni', 'Pizza con tomate, mozzarella y pepperoni', 'pizza_pepperoni.jpg', 12.50, 'pizzes', 2);

INSERT INTO categoria_pizza (nom) VALUES
('Pizzes Vegetarianes'),
('Pizzes amb Carn');

INSERT INTO botiga (id_adreca, telefon) VALUES
(1, '934567890'),
(2, '932345678'),
(3, '972123456');

INSERT INTO empleat (nom, cognoms, NIF, telefon, tipus_empleat, id_botiga) VALUES
('Marc', 'Gomez', '12345678A', '612345678', 'cuiner', 1),
('Anna', 'Perez', '87654321B', '635432189', 'repartidor', 2),
('Eduard', 'Soler', '23456789C', '677891234', 'repartidor', 3);

INSERT INTO repartiment (id_comanda, id_empleat, data_hora_lliurament) VALUES
(1, 2, '2024-06-24 13:15:00'), 
(2, 3, '2024-06-25 18:30:00'), 
(3, 3, '2024-06-26 20:00:00'); 

SET FOREIGN_KEY_CHECKS = 1;
