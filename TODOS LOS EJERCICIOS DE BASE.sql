/** 23.0btener el cifc de todos los concesionarios cuyo número de coches en
stock no es nulo.**/

/**
24.0btener el cifm y el nombre de las marcas de coches cuya segunda letra
del nombre de la Ciudad de origen sea una 'l'.**/
SELECT cifm, nombre 
FROM marcas
WHERE ciudad like '_l%'; -- No hay ninguna

SELECT * FROM MARCAS; 

/**
25.0btener el dni de los clientes que han comprado algún coche a un
concesionario de 'MADRID'.**/

SELECT dni, clientes.nombre
FROM clientes
	JOIN ventas USING (dni)
    JOIN concesionarios USING (cifc)
WHERE concesionarios.ciudad like 'Madrid';

/**
26.0btener el color de los coches vendidos por el concesionario 'ACAR'.**/

SELECT color
FROM ventas
	JOIN concesionarios using (cifc)
WHERE concesionarios.nombre like 'ACAR';


/**
27.0btener el codc de los coches vendidos por algún concesionario de
'MADRID'.**/
 
SELECT codcoche -- concesionarios.ciudad
FROM distribucion
	JOIN concesionarios using (cifc)
WHERE concesionarios.ciudad like 'Madrid';

/**
28.Obtener el nombre y el modelo de los coches vendidos por algún
concesionario de 'BARCELONA'.**/

SELECT coches.nombre, coches.modelo -- concesionarios.ciudad 
FROM coches
	JOIN ventas using (codcoche)
    JOIN concesionarios using (cifc)
WHERE concesionarios.ciudad like 'BARCELONA';


/**
29.Obtener todos los nombre de los clientes que hayan adquirido algún
coche del concesionario 'DCAR'.**/

SELECT clientes.nombre -- concesionarios.nombre
FROM clientes
	JOIN ventas using (dni)
    JOIN concesionarios using (cifc)
WHERE concesionarios.nombre like 'DCAR';


/**
30.Obtener el NOMBRE y el APELLIDO de los clientes que han adquirido
un coche modelo 'GTI' de color 'BLANCO'.**/



SELECT clientes.nombre, clientes.apellido, ventas.color
FROM CLIENTES
	JOIN ventas using (dni)
    JOIN coches using (codcoche)
WHERE coches.modelo like 'GTI' and ventas.color like 'BLANCO'; -- No hay ninguno

select coches.modelo from coches join ventas using (codcoche) where ventas.color like 'blanco'; -- GLX GTD, NO GTI

/**
31.Obtener el nombre y el apellido de los clientes que han adquirido un
automóvil a un concesionario que posea actualmente coches en stock
del modelo 'GTI'.**/

SELECT clientes.nombre, clientes.apellido -- cantidad, modelo
FROM clientes
	JOIN ventas USING (DNI)
    JOIN concesionarios USING (cifc)
    JOIN distribucion USING (cifc)
    JOIN coches ON distribucion.codcoche = coches.codcoche
WHERE 
distribucion.cantidad > 0
	AND 
		coches.modelo like 'gti';

/**
32.Obtener el nombre y el apellido de los clientes que han adquirido un
automóvil a un concesionario de 'MADRID' que posea actualmente
coches en stock del modelo 'GTI'.**/

SELECT clientes.nombre, clientes.apellido -- cantidad stock, modelo
FROM clientes
	JOIN ventas USING (DNI)
    JOIN concesionarios USING (cifc)
    JOIN distribucion USING (cifc)
    JOIN coches ON distribucion.codcoche = coches.codcoche
WHERE
distribucion.cantidad > 0
AND 
concesionarios.ciudad like 'madrid'
AND 
coches.modelo like'gti';



/**
33.Obtener el nombre y el apellido de los clientes cuyo dni es menor que el
del cliente 'JUAN MARTIN'.**/

SELECT * FROM clientes 
WHERE dni < ANY (
				SELECT dni 
                FROM clientes
                WHERE nombre LIKE 'juan' 
                AND apellido LIKE 'martin'
				);


/**
34.Obtener el nombre y el apellido de los clientes cuyo dni es menor que el
de los clientes que son de 'BARCELONA'.**/


SELECT nombre, apellido FROM clientes 
WHERE dni < ALL (
				SELECT dni 
                FROM clientes
                WHERE CIUDAD LIKE 'BARCELONA'
				);


/**
35.Obtener el nombre y el apellido de los clientes cuyo nombre empieza por
'A' y cuyo dni es mayor que el de los clientes que son de 'MADRID'.**/

SELECT * FROM clientes 
WHERE nombre like "A%" 
and dni > ALL (										-- CON ALL ME DEVUELVE SOLO A ANA PORQUE TIENE EL VALOR DE DNI MAS ALTO QUE **TODOS** LOS DE MADRID
													-- CON ANY ME DEVUELVE A ANA Y ANTONIO PORQUE ANTONIO TIENE UN VALOR DE DNI MAYOR QUE **ALGUNOS** DE LOS QUE TIENEN UN DNI DE MADRID
				SELECT dni 
                FROM clientes
                WHERE CIUDAD LIKE 'Madrid'
				);

/**
36.Obtener el nombre y el apellido de los clientes cuyo nombre empieza
por' A' Y cuyo dni es mayor que el de ¡ALGUNO! de los clientes que son
de 'MADRID'**/

SELECT * FROM clientes 
WHERE nombre like "A%" 
and dni > ANY (								
				SELECT dni 
                FROM clientes
                WHERE CIUDAD LIKE 'Madrid'
				);



/**
37.Obtener el nombre y el apellido de los clientes cuyo nombre empieza
por' A' Y cuyo dni es mayor que el de ¡ALGUNO! de los clientes que son
de 'MADRID' o menor que el de todos los de 'VALENCIA'.**/

SELECT * FROM clientes 
WHERE nombre like "A%" 
and dni > ANY (								
				SELECT dni 
                FROM clientes
                WHERE CIUDAD LIKE 'Madrid'
				)
OR DNI < all (
				SELECT dni 
				FROM clientes
                WHERE CIUDAD LIKE 'VALENCIA'
				);

/**
38.Obtener el nombre y el apellido de los clientes que han comprado como
mínimo un coche 'BLANCO' y un coche 'ROJO'.**/

SELECT nombre, apellido
FROM clientes
WHERE dni in (select dni from ventas where color like 'blanco')
and dni in (select dni from ventas where color like 'rojo');
            

/**
39.Obtener el dni de los clientes cuya ciudad sea la última de la lista
alfabética de las ciudades donde hay concesionarios.**/


/**
40.Obtener la media de los automóviles que cada concesionario tiene
actualmente en stock.**/


Select nombre Concesionario, avg(cantidad) media, ciudad
FROM concesionarios
JOIN distribucion using(cifc)
group by nombre;


/**
41.Obtener el cifc del concesionario que no sea de 'MADRID' cuya media
de vehículos en stock sea la mas alta de todas las medias.**/

  




/**
42.Repetir el ejercicio 33 pero utilizando EXISTS en la solución.**/


/**
43.Utilizando EXISTS obtener el dni de los clientes que hayan adquirido por
lo menos alguno de los coches que ha sido vendido por el concesionario
cuyo cifc es 0001.**/



/**
44.Obtener los dni de los clientes que sólo han comprado coches al
concesionario 0001.**/



/**
45.Obtener los nombres de los clientes que no han comprado ningún coche
'ROJO' a ningún concesionario de 'MADRID'.**/



/**
46.Obtener el nombre de los clientes que sólo han comprado en el
concesionario de cifc 0001.**/



/**
47.Obtener el codcoche de aquellos automóviles que han sido comprados
por todos los clientes de 'MADRID'. **/



/**
48.Obtener el codcoche de aquellos automóviles de color "ROJO" y del
modelo "GTI" que han sido comprados por todos los clientes cuyo
aopellido comienza por "G". **/



/**
49.Obtener el dni de los clientes que han adquirido por lo menos los
mismos automóviles que el cliente "LUIS GARCIA". **/


/**
50.Obtener el cifc de los concesionarios que han vendido el mismo coche a
todos los clientes. **/

/**
51.Convertir la siguiente proposición de SQL a su equivalente en
Castellano. **/