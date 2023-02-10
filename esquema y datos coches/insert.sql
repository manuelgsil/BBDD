USE Automovil;

INSERT INTO Marcas VALUES 
	(1, 'Seat', 'Madrid'),
    (2, 'Renault', 'Barcelona'),
    (3, 'Citroen', 'Valencia'),
    (4, 'Audi', 'Madrid'),
    (5, 'Opel', 'Bilbao'),
    (6, 'BMW', 'Barcelona')
    ;
    

INSERT INTO Clientes VALUES 
	(1, 'Luis', 'García', 'Madrid'),
	(2, 'Antonio', 'López', 'Valencia'),
    (3, 'Juan', 'Martín', 'Madrid'),
    (4, 'María', 'García', 'Madrid'),
    (5, 'Javier', 'González', 'Barcelona'),
    (6, 'Ana', 'López', 'Barcelona')
    ;
    
INSERT INTO Concesionarios VALUES 
	(1, 'acar', 'Madrid'),
    (2, 'bcar', 'Madrid'),
    (3, 'bcar', 'Barcelona'),
    (4, 'dcar', 'Valencia'),
    (5, 'ecar', 'Bilbao')
    ;
    
INSERT INTO Coches VALUES 
	(1, 'ibiza', 'glx'),
    (2, 'ibiza', 'gti'),
    (3, 'ibiza', 'gtd'),
    (4, 'toledo', 'gtd'),
    (5, 'cordoba', 'gti'),
    (6, 'megane', '1.6'),
    (7, 'megane', 'gti'),
    (8, 'laguna', 'gtd'),
    (9, 'laguna', 'td'),
    (10, 'zx', '16v'),
    (11, 'zx', 'td'),
    (12, 'xantia', 'gtd'),
    (13, 'a4', '1.8'),
    (14, 'a4', '2.8'),
    (15, 'astra', 'caravan'),
    (16, 'astra', 'gti'),
    (17, 'corsa', '1.4'),
    (18, '300', '316i'),
    (19, '500', '525i'),
    (20, '700', '750i')
    ;
    
INSERT INTO Marco VALUES 
	(1, 1),
    (1, 2),
    (1, 3),
    (1, 4),
    (1, 5),
    (2, 6),
    (2, 7),
    (2, 8),
    (2, 9),
    (3, 10),
    (3, 11),
    (3, 12),
    (4, 13),
    (4, 14),
    (5, 15),
    (5, 16),
    (5, 17),
    (6, 18),
    (6, 19),
    (6, 20)
    ;
    
INSERT INTO Distribucion VALUES 
	(1, 1, 3),
    (1, 5, 7),
    (1, 6, 7),
    (2, 6, 5),
    (2, 8, 10),
    (2, 9, 10),
    (3, 10, 5),
    (3, 11, 3),
    (3, 12, 5),
    (4, 13, 10),
    (4, 14, 5),
    (5, 15, 10),
    (5, 16, 20),
    (5, 17, 8)
    ;

INSERT INTO Ventas VALUES 
	(1, 1, 1, 'blanco'),
    (1, 2, 5, 'rojo'),
    (2, 3, 8, 'blanco'),
    (2, 1, 6, 'rojo'),
    (3, 4, 11, 'rojo'),
    (4, 5, 14, 'verde')
    ;
    
