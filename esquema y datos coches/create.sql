DROP SCHEMA IF EXISTS Automovil;
CREATE SCHEMA Automovil;
USE Automovil;

CREATE TABLE Marcas (
	cifm INT PRIMARY KEY,
   nombre VARCHAR(20),
   ciudad VARCHAR(20)
   );
    
CREATE TABLE Clientes (
	dni VARCHAR(9) PRIMARY KEY,
   nombre VARCHAR(20) NOT NULL,
   apellido VARCHAR(20) NOT NULL,
   ciudad VARCHAR(20)
   );
    
    
CREATE TABLE Coches (
   codcoche INT PRIMARY KEY AUTO_INCREMENT,
   nombre VARCHAR(20) NOT NULL,
   modelo VARCHAR(20) NOT NULL
   );
    
CREATE TABLE Marco (
	cifm INT,
    codcoche INT UNIQUE,
    CONSTRAINT PRIMARY KEY (cifm, codcoche),
    CONSTRAINT fk1 FOREIGN KEY (cifm) REFERENCES Marcas(cifm),
    CONSTRAINT fk2 FOREIGN KEY (codcoche) REFERENCES Coches(codcoche)
    );
    
CREATE TABLE Concesionarios (
	cifc INT PRIMARY KEY AUTO_INCREMENT,
   nombre VARCHAR(20),
   ciudad VARCHAR(20)
	);
    
CREATE TABLE Ventas (
	cifc INT,
   dni VARCHAR(9),
   codcoche INT,
   color VARCHAR(10),
   CONSTRAINT PRIMARY KEY (cifc, dni, codcoche),
   CONSTRAINT fk3 FOREIGN KEY (cifc) REFERENCES Concesionarios (cifc),
   CONSTRAINT fk4 FOREIGN KEY (dni) REFERENCES Clientes (dni),
   CONSTRAINT fk5 FOREIGN KEY (codcoche) REFERENCES Coches (codcoche)
   );
    
CREATE TABLE Distribucion (
	cifc INT,
   codcoche INT,
   cantidad INT DEFAULT 1,
   PRIMARY KEY (cifc, codcoche),
   CONSTRAINT fk6 FOREIGN KEY (cifc) REFERENCES Concesionarios (cifc),
   CONSTRAINT fk7 FOREIGN KEY (codcoche) REFERENCES Coches(codcoche)
   );
