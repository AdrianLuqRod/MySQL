--//-1. Obtener todos los atributos de todos los proyectos.
SELECT * FROM PROYECTO;
--//-2. Obtener todos los atributos de todos los proyectos desarrollados en Londres.
SELECT * FROM PROYECTO WHERE CIUDAD LIKE 'Londres';
--//-3. Obtener los códigos de las piezas suministradas por el proveedor s2, ordenados.
SELECT CODPIE
FROM
    PIEZA P
    JOIN VENTAS V ON P.CODPIE = V.CODPIE
    JOIN PROVEEDOR PR ON V.CODPRO = PR.CODPRO
WHERE
    CODPRO LIKE 's2'
ORDER BY CODPIE;
--//-4. Obtener los códigos de los proveedores del proyecto j1, ordenados.
SELECT CODPRO
FROM
    PROVEEDOR PR
    JOIN VENTAS V ON PR.CODPRO = V.CODPRO
    JOIN PROYECTO PRO ON V.CODPF = PRO.CODPJ
WHERE
    CODPJ LIKE 'j1';
--//-5. Obtener todas las ocurrencias pieza.color, pieza.ciudad eliminando los pares duplicados.
SELECT DISTINCT COLOR, CIUDAD FROM PIEZA;
--//-6. Obtener los códigos de las ventas en los que la cantidad no sea nula.
SELECT CONCAT(CODPRO, CODPIE, CODPJ) AS CODIGO_VENTA
FROM VENTAS
WHERE
    CANTIDAD IS NOT NULL;
--//-7. Obtener códigos de los proyectos y ciudades en las que la ciudad del proyecto tenga una 'o' en la segunda letra.
SELECT CODPJ, CIUDAD FROM PROYECTO WHERE CIUDAD LIKE '_o%';
--//-8. Obtener un listado ascendente de los nombres de las piezas con más de 5 letras.
SELECT NOMBRE
FROM PIEZA
WHERE
    LENGTH(NOMBRE) > 5
ORDER BY NOMBRE ASC;
--//-9. Obtener nombres abreviados de proyectos tomando sus primeras 3 letras.
SELECT LEFT(NOMPJ, 3) AS NOMBRE_PROYECTO_ABREVIADO FROM PROYECTO;
--//-10. Obtener los tres últimos caracteres de los nombres de proveedores por orden alfabético.
SELECT RIGHT(NOMPRO, 3) FROM PROVEEDORES ORDER BY NOMPRO DESC;
--//-11. Hallar cuántas piezas distintas existen.
SELECT DISTINCT COUNT(*) AS NUMERO_PIEZAS FROM PIEZA;
--//-12. Hallar cuántas piezas distintas existen dando nombre a la columna resultante Número.
SELECT DISTINCT COUNT(*) AS NUMERO FROM PIEZA;
--//-13. Obtener el número total de proyectos suministrados por el proveedor s1.
SELECT COUNT(*) AS NUM_TOTAL
FROM
    PROYECTO PR
    JOIN VENTAS V ON PR.CODPJ = V.CODPJ
    JOIN PROVEEDOR PRO ON V.CODPRO = PRO.CODPRO
WHERE
    CODPRO LIKE 's1';
--//-14. Obtener la cantidad total de piezas p1 suministrada por s1.
SELECT COUNT(*) AS CANTIDAD_TOTAL
FROM
    PIEZA PIE
    JOIN VENTAS V ON PIE.CODPIE = V.CODPIE
    JOIN PROVEEDOR PRO ON V.CODPRO = PRO.CODPRO
WHERE
    CODPIE LIKE 'p1'
    AND CODPRO LIKE 's1';
--//-15. Obtener la cantidad media de piezas suministradas, cantidad máxima y mínima suministrada.
SELECT
    AVG(*) AS CANTIDAD_MEDIA,
    MAX(*) AS CANTIDAD_MAXIMA,
    MIN(*) AS CANTIDAD_MINIMA
FROM PIEZA;
--//-16. Obtener las ventas en las que la cantidad de piezas esté entre 300 y 750 inclusive.
SELECT * FROM VENTAS WHERE CANTIDAD BETWEEN 300 AND 750;
--//-17. Construir una consulta que devuelva codpie y VERDADERO si en la tabla piezas el color de la pieza no es ni azul ni gris.
SELECT
    CODPIE CASE
        WHEN COLOR NOT IN('Azul', 'Gris') THEN 'VERDADERO'
        ELSE 'FALSO'
    END AS CONDICION;
--//-18. Añade una nueva columna llamada fecha que indique la fecha de adquisición de una pieza por proveedor y proyecto.
ALTER TABLE VENTAS ADD FECHA DATE;
--//-19. Modificar la fecha de adquisición de todas las piezas p2 a la fecha actual.
UPDATE VENTAS SET FECHA = NOW() WHERE CODPIE LIKE 'p2';
--//-20. Se desea visualizar la fecha con formato del ejemplo ’11-NOV-2002’.
SELECT UPPER(
        DATE_FORMAT(FECHA, '%d-%b-%Y')
    ) AS 'FECHA'
FROM VENTAS;
--//-21. Modificar la fecha de adquisición en los que participan los proyectos j1 y j2 a la fecha 12-11-2001 .
UPDATE VENTAS
SET
    FECHA = '12-11-2001'
WHERE
    CODPRO IN ('j1', 'j2');
--//-22. Construir una lista ordenada de todas las ciudades en las que almenos resida un proveedor o suministrador, una pieza o un proyecto.
SELECT ciudad
FROM pieza
UNION
SELECT ciudad
FROM proyecto
UNION
SELECT ciudad
FROM proveedor
ORDER BY ciudad;
--//-23. Obtener todas las posibles combinaciones entre piezas y proveedores.
SELECT DISTINCT CODPIE, CODPRO FROM PIEZA, PROVEEDOR;

SELECT CODPIE, CODPRO FROM PIEZA, PROVEEDOR;

SELECT * FROM PIEZA, PROVEEDOR;
--//-24. Obtener todos los posibles tríos de código de proveedor, código de pieza y código de proyecto en los que el proveedor, pieza y proyecto estén en la misma ciudad.
SELECT CODPRO, CODPIE, CODPJ
FROM PROVEEDOR PRO, PIEZA P, PROYECTO PR
WHERE
    P.CIUDAD = PRO.CIUDAD
    AND PRO.CIUDAD = PR.CIUDAD;
--//-25. Obtener los códigos de proveedor, de pieza y de proyecto de aquellos cargamentos en los que proveedor, pieza y proyecto estén en la misma ciudad.
SELECT CODPRO, CODPIE, CODPJ
FROM
    PIEZA P
    JOIN VENTAS V ON P.CODPIE = V.CODPIE
    JOIN PROVEEDOR PRO ON PRO.CODPRO = V.CODPRO
    JOIN PROYECTO PR ON V.CODPJ = PR.CODPJ
WHERE
    P.CIUDAD = PRO.CIUDAD
    AND PRO.CIUDAD = PR.CIUDAD;
--//-26. Obtener todos los posibles trios de código de proveedor, código de pieza y código de proyecto en los que el proveedor, pieza y proyecto no estén todos en la misma ciudad.
SELECT CODPRO, CODPIE, CODPJ
FROM PROVEEDOR PRO, PIEZA P, PROYECTO PR
WHERE
    P.CIUDAD NOT IN(
        SELECT CIUDAD
        FROM PROVEEDOR
        WHERE
            CIUDAD NOT IN(
                SELECT CIUDAD
                FROM PROYECTO
            )
    );
--//-27. Obtener todos los posibles trios de código de proveedor, código de pieza y código de proyecto en los que el proveedor, pieza y proyecto no estén ninguno en la misma ciudad.
SELECT CODPRO, CODPIE, CODPJ
FROM PROVEEDOR PRO, PIEZA P, PROYECTO PR
WHERE
    P.CIUDAD != PRO.CIUDAD
    AND PRO.CIUDAD != PR.CIUDAD;
--//-28. Obtener los códigos de las piezas suministradas por proveedores de Londres.
SELECT CODPIE
FROM VENTAS V
    JOIN PROVEEDOR PRO ON V.CODPIE = PRO.CODPIE
WHERE
    PRO.CIUDAD LIKE 'Londres';
--//-29. Obtener los códigos de las piezas suministradas por proveedores de Londres a proyectos en Londres.
SELEC CODPIE
FROM
    VENTAS V
    JOIN PROVEEDOR PRO ON V.CODPIE = PRO.CODPIE
    JOIN PROYECTO P ON V.CODPJ = P.CODPJ
WHERE
    PRO.CIUDAD LIKE 'Londres'
    AND P.CIUDAD LIKE 'Londres';
--//-30. Obtener todos los pares de nombres de ciudades en las que un proveedor de la primera sirva a un proyecto de la segunda.

--//-31. Obtener códigos de piezas que sean suministradas a un proyecto por un proveedor de la misma ciudad del proyecto.
SELECT DISTINCT
    CODPIE
FROM VENTAS
WHERE
    CODPRO IN (
        SELECT CODPRO
        FROM PROVEEDOR
        WHERE
            CIUDAD IN (
                SELECT CIUDAD
                FROM PROYECTO
            )
    );
--//-32. Obtener códigos de proyectos que sean suministrados por un proveedor de una ciudad distinta a la del proyecto. Visualizar el código de proveedor y el del proyecto.
SELECT CODPJ, CODPRO
FROM VENTA
WHERE
    CODPRO IN (
        SELECT CODPRO
        FROM PROVEEDOR
        WHERE
            CIUDAD NOT IN(
                SELECT CIUDAD
                FROM PROYECTO
            )
    );
--//-33. Obtener todos los pares de códigos de piezas suministradas por el mismo proveedor.
--//-34. Obtener todos los pares de códigos de piezas suministradas por el mismo proveedor (eliminar pares repetidos).
--//-35. Obtener para cada pieza suministrada a un proyecto, el código de pieza, el código de proyecto y la cantidad total correspondiente.
--//-36. Obtener los códigos de proyectos y los códigos de piezas en los que la cantidad media suministrada a algún proyecto sea superior a 320.
--//-37. Obtener un listado ascendente de los nombres de todos los proveedores que hayan suministrado una cantidad superior a 100 de la pieza p1 . Los nombres deben aparecer en mayúsculas.
--//-38. Obtener los nombres de los proyectos a los que suministra s1.
--//-39. Obtener los colores de las piezas suministradas por s1.
--//-40. Obtener los códigos de las piezas suministradas a cualquier proyecto de Londres.
--//-41. Obtener los códigos de los proveedores con estado menor que el proveedor con código s1.
--//-42. Obtener los códigos de los proyectos que usen la pieza p1 en una cantidad media mayor que la mayor cantidad en la que cualquier pieza sea suministrada al proyecto j1.
--//-43. Obtener códigos de proveedores que suministren a algún proyecto la pieza p1 en una cantidad mayor que la cantidad media en la que se suministra la pieza pI a dicho proyecto.
--//-44. Obtener los códigos de los proyectos que usen al menos una pieza suministrada por s1.
--//-45. Obtener los códigos de los proveedores que suministren al menos una pieza suministrada al menos por un proveedor que suministre al menos una pieza roja.
--//-46. Obtener los codigos de las piezas suministradas a cualquier proyecto de Londres usando EXISTS.
--//-47. Obtener los códigos de los proyectos que usen al menos una pieza suministrada por s1 usando EXISTS.
--//-48. Obtener los códigos de los proyectos que no reciban ninguna pieza roja suministrada por algún proveedor de Londres.
--//-49. Obtener los códigos de los proyectos suministrados únicamente por s1.
--//-50. Obtener los códigos de las piezas suministradas a todos los proyectos en Londres.
--//-51. Obtener los códigos de los proveedores que suministren la misma pieza todos a los proyectos.
--//-52. Obtener los códigos de los proyectos que reciban al menos todas las piezas que suministra s1.
--//-53. Cambiar el color de todas las piezas rojas a naranja.
--//-54. Borrar todos los proyectos para los que no haya cargamentos.
--//-55. Borrar todos los proyectos en Roma y sus correspondientes cargamentos.
--//-56. Insertar un nuevo suministrador s 10 en la tabla S. EI nombre y la ciudad son 'White'y ‘New York' respectivamente. El estado no se conoce todavía.
--//-57. Construir una tabla conteniendo una lista de los códigos de las piezas suministrada.s a proyectos en Londres o suministradas por un suministrador de Londres.
--//-58. Construir una tabla conteniendo una lista de los códigos de los proyectos de Londres o que tengan algún suministrador de Londres.
--//-59. Listar las tablas y secuencias definidas por el usuario ZEUS.