-- APUNTES EDU DE USUARIOS
   
   -- -----------------------------------------------------------------------------------------------------------------------------------------------------
-- RESTAURACION DE COPIA DE SEGURIDAD MYSQL DUMPS
/*
-- Usamo colegio uno porque no tiene el create table para crear una base de datos colegio2022
mysql -u root -p colegio2022 < C:\Users\Edu\Desktop\Ejercicios_BD\backupmysql\BackupColegio1.sql

-- Restaura la base de datos colegio
	1. Eliminamos colegio
C:\>mysql -u root -p < C:\Users\Edu\Desktop\Ejercicios_BD\backupmysql\BackupColegio2.sql

-- Cargar una copia en la base de datos libreria una copia de seguridad creada anteriormente de alguna tablas de la base de datos sakila
C:\>mysql -u root -p libreria< C:\Users\Edu\Desktop\Ejercicios_BD\backupmysql\bd_sakila_tablas_20220727.sql
*/



-- -----------------------------------------------------------------------------------------------------------------------------------------------------
-- METADATOS - GESTION DE USUARIOS

-- Ver con cual usuario estoy conectado
select current_user();

-- Privilegios de suarios
SELECT * FROM information_schema.user_privileges; 



-- mysql
-- información de los usuarios y privilegios
SELECT * FROM mysql.user;

-- Privilegios globales de cada uno de los usuario
SELECT * FROM mysql.global_grants;

-- Roles 
SELECT * FROM mysql.default_roles;
show tables from mysql;

-- Otras tablas
SELECT * FROM mysql.db;
SELECT * FROM mysql.tables_priv;
SELECT * FROM mysql.columns_priv;




-- -----------------------------------------------------------------------------------------------------------------------------------------------------
-- USUARIOS
/* 01/09
creación de usuarios por codigo
create user 'nombre'@'host o ip o %' identified by 'password'; crea una nueva cuenta de usuario
%  con esto, el usuario puede conectarse desde cualquier usuario
*/

use mysql;
select * from user;

select * from mysql.db; 	-- permisos de usuarios a bd

select * from mysql.tables_priv;	-- permisos de los usuarios a ciertas tablas

select * from mysql.columns_priv;	-- permisos de usuarios a ciertas columnas de una tabla

show privileges;	-- muestra los distintos privilegios

-- Ver los privilegios que tiene asignado un usuario
use information_schema;
select * from USER_PRIVILEGES;

select * from USER_PRIVILEGES where grantee like 'root&';	-- no funciona porque el nombre del usuario tiene comillas ''
select * from USER_PRIVILEGES where grantee like '\'root\'@\'localhost\'';
select * from USER_PRIVILEGES where grantee like "'root'@'localhost'";
select * from USER_PRIVILEGES where grantee like "'root%";

-- CREACION DE USUARIOS--

create user 'pepe'@'%' identified by 'paspepe';

select * from mysql.user;

create user 'juan'@'localhost' identified by 'pasjuan';

create user 'ana'@'localhost';

/* para asignar permisos hay que crear un rol (conjunto de permisos), al usuario le puedes asignar roles y permisos

grant type_permission on database_name.table_name to 'nombre'@'localhost';*/

-- asignar privilegios a usuarios--

grant all on *.* to 'pepe'@'%';	-- asigno todo los privilegios

flush privileges;	-- para que se activen los privilegios, tiene que cerrar sesión si la tiene abierta, y volver a entrar

show grants for 'pepe'@'%';
select * from information_schema.USER_PRIVILEGES where grantee like "'pepe%'";
select * from mysql.tables_priv;	-- no aparece

grant all privileges on *.* to 'juan'@'localhost';	-- asigno todo los privilegios
select * from mysql.user;

grant select, insert, update on colegio.* to 'ana'@'localhost'; 	-- asigno privilegios de select,insert y update en la bd colegio
select * from mysql.db;
show grants for 'ana'@'localhost';

-- creamos nuevo usuario, asignamos permisos, hacemos pruebas y lo eliminamos-- 
create user 'usub'@'localhost' identified by '123';

grant select, insert, update, delete on colegio.asignatura to 'usub'@'localhost';

select * from mysql.user;
select * from mysql.db;	-- no aparece porque le hemos dado permisos dolo para una tabla de una bd
show grants for 'usub'@'localhost';
select * from mysql.tables_priv; 	-- aqui si aparece

grant select (cod_alumno, dni, nombre) on colegio.alumnos to 'usub'@'localhost'; 	-- le damos más permisos al usuario para algunos campos de una tabla de una bd
select * from mysql.columns_priv; 	-- aqui si aparece

drop user if exists 'usub'@'localhost';		-- eliminamos al usuario

-- visualizamos las conexiones de los usuarios
show processlist;

kill 17; 	-- para matar el proceso

/* ejer 1
creo el usuario usern, le doy permisos select e insert a colegio, conecto con linea de comandos, hago pruebas con las bd, el admin elimina el usuario, hago pruebas para saber si puede seguir haciendo cosas, el admin elimina la sesión del usuario*/

create user 'userns'@'localhost' identified by '123';
select * from mysql.user;

grant select, insert on colegio.* to 'userns'@'localhost';
select * from mysql.db;	-- no aparece porque le hemos dado permisos dolo para una tabla de una bd
show grants for 'userns'@'localhost';

drop user if exists 'userns'@'localhost';

show processlist;
kill 19;



-- -----------------------------------------------------------------------------------------------------------------------------------------------------
-- RORLES
	 SELECT * FROM mysql.role_edges; -- Ver roles
     SELECT current_role(); -- Ver rol corriendo
     
-- EJERCICIO PRUEBA
	-- 1) CREACION ROLES
		CREATE ROLE 'rol_desarrollo', 'rol_lectura', 'rol_escritura'; -- Crear uno o más roles
			-- VER ROLES
			SELECT * FROM mysql.user;
    -- 2) ASIGNAR PRIVILEGIOS
		GRANT CREATE, ALTER, DROP, REFERENCES, SELECT, INSERT, UPDATE, DELETE ON *.* TO 'rol_desarrollo';
			-- VER ROL 
			SELECT * FROM mysql.user WHERE user LIKE 'rol_desarrollo';
            -- VACIO
			SELECT * FROM mysql.role_edges;
            -- VER GRANTS;
            SHOW GRANTS FOR  'rol_desarrollo';
            
            GRANT select ON *.* TO 'rol_lectura';
            -- VER ROL 
			SELECT * FROM mysql.user WHERE user LIKE 'rol_lectura';
            -- VACIO
			SELECT * FROM mysql.role_edges;
            -- VER GRANTS;
            SHOW GRANTS FOR  'rol_lectura';
            
            GRANT INSERT, UPDATE, DELETE ON *.* TO 'rol_escritura';
            -- VER ROL 
			SELECT * FROM mysql.user WHERE user LIKE 'rol_escritura';
            -- VACIO
			SELECT * FROM mysql.role_edges;
            -- VER GRANTS;
            SHOW GRANTS FOR  'rol_escritura';
            
	-- 3) CREACIÓN DE USUARIOS
		CREATE USER 'desUsu1'@'localhost' IDENTIFIED BY '123';
        CREATE USER 'lecUsu1'@'localhost' IDENTIFIED BY '123';
        CREATE USER 'lecUsu2'@'localhost' IDENTIFIED BY '123';
        CREATE USER 'lecEsUsu1'@'localhost' IDENTIFIED BY '123';
        
	-- 4) ASIGNAR ROLES
		-- ASIGNAR ROL desUsu1
		GRANT 'rol_desarrollo' TO 'desUsu1'@'localhost';
        -- ASGINAR ROL lecUsu1 y lecUsu2
		GRANT 'rol_lectura' TO 'lecUsu1'@'localhost', 'lecUsu2'@'localhost';
        -- ASIGNAR DOS ROLES A UN USUARIO lecEsUsu1
        GRANT 'rol_lectura', 'rol_escritura' TO 'lecEsUsu1'@'localhost';
        
	-- 5) ACTIVAR LOS ROLES DE LOS USUARIOS
		SET DEFAULT ROLE ALL TO 'desUsu1'@'localhost', 'lecUsu1'@'localhost', 'lecUsu2'@'localhost', 'lecEsUsu1'@'localhost';
    
    -- 6)VER COSAS    
	-- VEMOS LOS ROLES Y LOS USUARIOS ASIGNADOS
		SELECT * FROM mysql.role_edges;
	-- PERMISO DE ROLES
		SHOW GRANTS FOR 'rol_desarrollo';
	-- ROLES ASIGNADOS AL USUARIO
		SHOW GRANTS FOR 'lecEsUsu1'@'localhost';
        
	-- 7) ELIMINAR LOS ROLES Y LOS USUARIOS
		-- ELIMINAR ROPÑES
			DROP ROLE 'rol_desarrollo', 'rol_lectura', 'rol_escritura';
			SELECT * FROM mysql.user;
		-- ELIMINAR LOS USUARIOS
			DROP USER 'desUsu1'@'localhost', 'lecUsu1'@'localhost', 'lecUsu2'@'localhost', 'lecEsUsu1'@'localhost';
            SELECT * FROM mysql.user;
            
            
            
-- -----------------------------------------------------------------------------------------------------------------------------------------------------
-- REVOCAR PRIVILEGIOS
	-- 1) CREAMOS USUARIO Y PRIVILEGIOS 
    CREATE USER 'ana'@'localhost' IDENTIFIED BY '1234';
    GRANT SELECT, INSERT, UPDATE ON colegio.* TO 'ana'@'localhost';
    FLUSH PRIVILEGES;
    SELECT * FROM mysql.user WHERE user LIKE 'ana';
    SELECT * FROM mysql.db WHERE user LIKE 'ana';
    
    -- 2) REVOCA PERMISOS INSERT ANA
		-- ERROR PROVOCADO NO FUNCIONA EL *.*
        REVOKE INSERT ON *.* FROM 'ana'@'localhost';
        
        -- RECOVOCO EL PERMISO INSERT PARA UNA TABLA EN CONCRETO
        REVOKE INSERT ON colegio.* FROM 'ana'@'localhost';
        
	-- 3 CREACION DE USUARIO Y ROL
		CREATE ROLE 'rol_lectura';
        GRANT select ON *.* TO 'rol_lectura';
        CREATE USER 'lecUsu1'@'localhost' IDENTIFIED BY '123';
        GRANT 'rol_lectura' TO 'lecUsu1'@'localhost';
		SET DEFAULT ROLE ALL TO 'lecUsu1'@'localhost';
		SELECT * FROM mysql.user WHERE user LIKE 'lecUsu1';
        SHOW GRANTS FOR 'lecUsu1'@'localhost';
        SHOW GRANTS FOR 'rol_lectura';
        
	-- 4) REVOCAMOS EL PERMISO INSER AL ROL_LECTURA
		REVOKE 'rol_lectura' ON *.* FROM 'lecUsu1'@'localhost';
        
	-- 5) ELIMINAMOS USUARIO Y ROL
		DROP USER 'lecUsu1'@'localhost';
        DROP ROLE 'rol_lectura';
	
    
-- -----------------------------------------------------------------------------------------------------------------------------------------------------
-- RENOMBRAR UN USUARIO
	-- 1) CREAMOS USUARIO ANA 
	DROP USER 'ana'@'localhost';
	CREATE USER 'ana'@'localhost';
    
    -- 2) RENOMBRAR
	RENAME USER 'ana'@'localhost' to 'anita'@'localhost';
    SELECT * FROM mysql.user;
    
    -- 3) PARA ASIGNAR UNA CLAVE SI NO TIENE O PARA MODIFICAR
    ALTER USER IF EXISTS 'anita'@'localhost' IDENTIFIED BY '1234';
    
    -- 4) ECHARLA DEL SISTEMA
		-- ) BUSCAMO EL IDENTIFICAMOS IS ID
        SHOW processlist;
        -- ) La matamos
		KILL 13;
        
	-- 5) BLOQUEAR UNA CUENTA
    ALTER USER IF EXISTS 'anita'@'localhost' ACCOUNT LOCK;
		-- LA ECHAMOS
        SHOW PROCESSLIST;
        KILL 14;
	
    -- 6) DESBLOQUEARLA
    ALTER USER IF EXISTS 'anita'@'localhost' ACCOUNT UNLOCK;
    