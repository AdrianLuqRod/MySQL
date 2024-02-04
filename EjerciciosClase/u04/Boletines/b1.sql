--//? Usa centro_educativo.sql
--//? Usa centro_educativo.sql
--//? Usa centro_educativo.sql
--//-1. Mostrar el nombre de las provincias.
SELECT
    NOMBRE
FROM
    PROVINCIA;

--//-2. Mostrar el nombre y apellidos de los alumnos.
SELECT
    NOMBRE,
    APELLIDOS
FROM
    ALUMNO;

--//-3. Mostrar el código y el nombre de todas las asignaturas.
SELECT
    ID_ASIG,
    NOMBRE
FROM
    ASIGNATURA;

--//-4. Mostrar el DNI, nombre y apellidos de los profesores, ordenados por DNI ascendentemente.
SELECT
    DNI,
    NOMBRE,
    APELLIDOS
FROM
    PROFESOR
ORDER BY
    DNI;

--//-5. Mostrar los datos de los alumnos de mayor a menor edad, de forma que en la columna de la fecha de nacimiento aparezca el encabezado “Fecha_de_nacimiento.
SELECT
    DNI,
    NOMBRE,
    APELLIDOS,
    FECHA_NAC AS FECHA_DE_NACIMIENTO,
    NACIDO_EN,
    ID_ALUM
FROM
    ALUMNO
ORDER BY
    FECHA_NAC;

--//-6. Mostrar los datos del alumno cuyo DNI es 56846315M.
SELECT
    *
FROM
    ALUMNO
WHERE
    DNI = '56846315M';

--//-7. Mostrar los alumnos nacidos en las provincias cuyos códigos estén comprendidos entre 3 y 7.
SELECT
    *
FROM
    ALUMNO
WHERE
    NACIDO_EN BETWEEN 3 AND 7;

--//-8. Mostrar los profesores nacidos en alguna de estas provincias: 1, 3, 5, 7.
SELECT
    *
FROM
    PROFESOR
WHERE
    NACIDO_EN IN (1, 3, 5, 7);

--//-9. Mostrar los alumnos nacidos entre el 19/02/1980 y el 20/07/1984.
SELECT
    *
FROM
    ALUMNO
WHERE
    FECHA_NAC BETWEEN '1980-02-19' AND '1984-07-20';

--//-10. Mostrar los registros de la tabla “Matriculado” del alumno 7.
SELECT
    *
FROM
    MATRICULADO
WHERE
    ID_ALUM = 7;

--//-11. Mostrar el nombre y apellidos de los alumnos mayores de 40 años.
SELECT
    NOMBRE,
    APELLIDOS
FROM
    ALUMNO
WHERE
    DATEDIFF (curdate (), FECHA_NAC) / 365 > 40;

--//-12. Mostrar aquellos alumnos cuyo DNI contenga la letra ‘Y’.
SELECT
    *
FROM
    ALUMNO
WHERE
    DNI LIKE '%Y';

--//-13. Mostrar aquellos alumnos cuyo nombre empiece por ‘S’.
SELECT
    *
FROM
    ALUMNO
WHERE
    NOMBRE LIKE 'S%';

--//-14. Mostrar el nombre de aquellos alumnos cuyo nombre contenga la letra ‘n’, ya sea mayúscula o minúscula.
SELECT
    NOMBRE
FROM
    ALUMNO
WHERE
    NOMBRE LIKE '%N%' || NOMBRE LIKE '%n%';

--//-15. Mostrar el nombre de aquellos alumnos cuyo apellido contenga la letra ‘z’, mayúscula o miníscula.
SELECT
    NOMBRE
FROM
    ALUMNO
WHERE
    UPPER(APELLIDOS) LIKE UPPER('%z%');

--//-16. Mostrar aquellos alumnos que tengan por primer nombre “Manuel”.
SELECT
    *
FROM
    ALUMNO
WHERE
    NOMBRE LIKE "Manuel%";

--//-17. Mostrar aquellos alumnos que se llamen “Manuel” o “Cristina”.
SELECT
    *
FROM
    ALUMNO
WHERE
    NOMBRE LIKE "%Manuel%" || NOMBRE LIKE "%Cristina%";

--//-18. Mostrar los datos de los alumnos cuyo DNI empiece por 2.
SELECT
    *
FROM
    ALUMNO
WHERE
    DNI LIKE "2%";

--//-19. Mostrar los identificadores de provincia en las que han nacido los alumnos, sin que estos identificadores se repitan.
SELECT DISTINCT
    NACIDO_EN
FROM
    ALUMNO;

--//-20. Mostrar la tabla de “Matriculado” y añadir una columna más que sea la media de las tres notas de cada alumno, ordenados de la mejor nota a la peor.
SELECT
    MATRICULADO.*,
    (NOTA1 + NOTA2 + NOTA3) / 3 AS PROMEDIO
FROM
    MATRICULADO
ORDER BY
    PROMEDIO DESC;

--//-21. Mostrar los registros de la tabla “Matriculado” en los que un alumno haya superado los 3 exámenes de la asignatura 1.
SELECT
    *
FROM
    MATRICULADO
WHERE
    ID_ASIG = 1
    AND NOTA1 >= 5
    AND NOTA2 >= 5
    AND NOTA3 >= 5;

--//-22. Mostrar los registros de la tabla “Matriculado” en los que un alumno haya sacado un 10 en alguna de las 3 notas en cualquier asignatura.
SELECT
    *
FROM
    MATRICULADO
WHERE
    NOTA1 = 10
    OR NOTA2 = 10
    OR NOTA3 = 10;

--//-23. Mostrar aquellos registros de la tabla “Matriculado” en los que un alumno haya superado alguno de los 3 exámenes de la asignatura 2.
SELECT
    *
FROM
    MATRICULADO
WHERE
    ID_ASIG = 2
    AND NOTA1 >= 5
    AND NOTA2 >= 5
    AND NOTA3 >= 5;

--//-24. Mostrar los registros de la tabla “Matriculado” en los que un alumno haya superado el primer examen ordenando
--//-los registros por “nota2” y “nota3” de menor a mayor para ambos campos.
SELECT
    *
FROM
    MATRICULADO
WHERE
    NOTA1 >= 5
ORDER BY
    NOTA2,
    NOTA3 ASC;

--//-25. Mostrar aquellos alumnos nacidos en el 1985.
SELECT
    *
FROM
    ALUMNO
WHERE
    YEAR (FECHA_NAC) = '1985';

--//-26. Mostrar los datos de los alumnos y además una columna calculada “mes” que represente el mes en el que nació el alumno.
--//-Además se debe ordenar por dicha columna.
SELECT
    ALUMNO.*,
    MONTH (FECHA_NAC) AS MES
FROM
    ALUMNO
ORDER BY
    MES;

--//-27. Mostrar los datos de los alumnos y además una columna calculada “fecha_de_nacimiento” que represente el día en el que nació el alumno
--//-con el siguiente formato “Nacido el día xx del xx de xxxx”.
SELECT
    ALUMNO.*,
    DATE_FORMAT (FECHA_NAC, 'Nacido el dia %e del %M de %Y') AS FECHA_DE_NACIMIENTO
FROM
    ALUMNO;

--//-28. Mostrar el nombre, apellidos y la edad de los alumnos.
SELECT
    NOMBRE,
    APELLIDOS,
    TIMESTAMPDIFF (YEAR, FECHA_NAC, CURDATE ()) AS EDAD
FROM
    ALUMNO;

--//-29. Mostrar los datos de los alumnos y además una columna calculada  “dias_vividos” que represente los días que lleva vivido el alumno hasta la fecha de hoy.
SELECT
    ALUMNO.*,
    TIMESTAMPDIFF (DAY, FECHA_NAC, CURDATE ()) AS DIAS_VIVIDOS
FROM
    ALUMNO;

--//-30. Mostrar el nombre y apellidos de los 4 alumnos con mayor edad.
SELECT
    NOMBRE,
    APELLIDOS,
    TIMESTAMPDIFF (YEAR, FECHA_NAC, CURDATE ()) AS EDAD
FROM
    ALUMNO
LIMIT
    4;

--//-31. Contar el número de alumnos que hay en el centro educativo.
SELECT
    COUNT(*) AS NUM_ALUMNOS
FROM
    ALUMNO;

--//-32. Contar el número de profesores nacidos en la provincia 2 (Cádiz) que hay en el centro educativo.
SELECT
    COUNT(*) AS NUM_PROFESORES
FROM
    PROFESOR
WHERE
    NACIDO_EN = 2;

--//-33. Mostrar la nota2 más alta de todas.
SELECT
    NOTA2
FROM
    MATRICULADO
ORDER BY
    NOTA2 DESC
LIMIT
    1;

--//-34. Mostrar la nota1 más baja de la asignatura 1 (Redes).
SELECT
    NOTA1
FROM
    MATRICULADO
WHERE
    ID_ASIG = 1
ORDER BY
    NOTA1
LIMIT
    1;

--//-35. Mostrar el sumatorio de todas las notas1 de la asignatura 1 (Redes).
SELECT
    AVG(NOTA1)
FROM
    MATRICULADO
WHERE
    ID_ASIG = 1;

--//-36. Variante. Mostrar la suma de todas las notas1 fabricando una columna llamada suma. Además se deben añadir 2 columnas más
--//-que se correspondan con el número de notas1 existentes y con el valor de la nota media.
SELECT
    SUM(NOTA1) AS SUMA,
    COUNT(NOTA1) AS NUMNOTA1EXISTENTE,
    AVG(NOTA1) NOTAMEDIA
FROM
    MATRICULADO