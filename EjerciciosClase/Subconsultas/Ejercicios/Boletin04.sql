--//-1. Muestra todos los campos de las películas de Animación.
SELECT *
FROM PELICULA
WHERE
    GENERO IN (
        SELECT GENERO
        FROM PELICULA
        WHERE
            GENERO = 'Animacion'
    );

--//-2. Muestra código de copias, estado, código de película, título, duración, género, año y precio.
SELECT
    ID_COPIA,
    ESTADO,
    CODIGO,
    TITULO,
    DURACION,
    GENERO,
    ANYO,
    PRECIO_ALQUILER
FROM COPIA_PELICULA CP
    JOIN PELICULA P ON CP.PELICULA = P.CODIGO;

--//-3. Muestra codigo de copias, estado, código de película, título, duración, género, año y precio de las películas que cuestan menos de 2.50.
SELECT
    ID_COPIA,
    ESTADO,
    CODIGO,
    TITULO,
    DURACION,
    GENERO,
    ANYO,
    PRECIO_ALQUILER
FROM COPIA_PELICULA CP
    JOIN PELICULA P ON CP.PELICULA = P.CODIGO
WHERE
    EXISTS (
        SELECT *
        FROM PELICULA
        HAVING
            PRECIO_ALQUILER < 2.50
    );

--//-4. Comprueba que todas las películas tienen copias.
SELECT ID_COPIA
FROM COPIA_PELICULA
WHERE
    PELICULA NOT IN(
        SELECT CODIGO
        FROM PELICULA
    );

--//-5. Comprueba que están los datos de las películas de las copias que tenemos.
SELECT *
FROM PELICULA
WHERE
    CODIGO IN (
        SELECT PELICULA
        FROM COPIA_PELICULA
    );

--//-6. Muestra el nombre y los apellidos de los socios que han alquilado la película 113.
SELECT NOMBRE, CONCAT(APELLIDO1, " ", APELLIDO2) AS APELLIDOS
FROM SOCIO S
WHERE
    EXISTS (
        SELECT *
        FROM ALQUILER AL
        WHERE
            S.NUM_SOCIO = AL.SOCIO
            AND COPIA_PEL = 113
    );

--//-7. Muestra el nombre y los apellidos de los socios alguna vez han alquilado una película en diciembre.
SELECT NOMBRE, CONCAT(APELLIDO1, " ", APELLIDO2) AS APELLIDOS
FROM SOCIO S
WHERE
    EXISTS (
        SELECT *
        FROM ALQUILER AL
        WHERE
            S.NUM_SOCIO = AL.SOCIO
            AND MONTH(FEC_ALQUILA) = 12
    );

--//-8. Muestra el nombre y los apellidos de los socios que siempre han devuelto la película el día 30.
--//. En principio ninguno cumple esta norma, pero ajustamos la tabla para que de 1 resultado:
--//. UPDATE ALQUILER
--//. SET fec_devolucion = '2014-12-30'
--//. WHERE socio = 1006;
SELECT NOMBRE, CONCAT(APELLIDO1, " ", APELLIDO2) AS APELLIDOS
FROM SOCIO S
WHERE
    30 = ALL (
        SELECT DAY(FEC_DEVOLUCION)
        FROM ALQUILER AL
        WHERE
            S.NUM_SOCIO = AL.SOCIO
    );

--//-9. Muestra el código de la película, el título, el código de la copia y el número de veces alquilada esa copia.
SELECT
    CODIGO,
    TITULO,
    ID_COPIA,
    COUNT(COPIA_PEL) AS NUM_VECES_ALQUILADA
FROM
    PELICULA P
    JOIN COPIA_PELICULA CP ON P.CODIGO = CP.PELICULA
    JOIN ALQUILER AL ON CP.ID_COPIA = AL.COPIA_PEL
GROUP BY
    P.CODIGO,
    CP.ID_COPIA;

--//-10. Muestra los títulos de películas que alquilan las personas de Aguadulce.
SELECT TITULO
FROM PELICULA
WHERE
    CODIGO IN (
        SELECT PELICULA
        FROM COPIA_PELICULA
        WHERE
            ID_COPIA IN (
                SELECT COPIA_PEL
                FROM ALQUILER
                WHERE
                    SOCIO IN (
                        SELECT NUM_SOCIO
                        FROM SOCIO
                        WHERE
                            POBLACION LIKE 'Aguadulce'
                    )
            )
    );

--//-11. Muestra el título de la película con la fecha de comienzo de alquiler con el formato 01/february/2023 como fecha alquiler.
SELECT DISTINCT
    TITULO,
    LOWER(
        DATE_FORMAT(fec_alquila, '%d/%M/%Y')
    ) AS 'fecha_alquiler'
FROM
    PELICULA P
    JOIN COPIA_PELICULA CP ON P.CODIGO = CP.PELICULA
    JOIN ALQUILER AL ON CP.ID_COPIA = AL.COPIA_PEL
ORDER BY TITULO;

--//-12. Muestra el titulo de la pelicula y los días que han estado alquiladas como días alquilada.
SELECT DISTINCT
    TITULO,
    DATEDIFF(FEC_DEVOLUCION, FEC_ALQUILA) AS 'DIAS_ALQUILADA'
FROM
    PELICULA P
    JOIN COPIA_PELICULA CP ON P.CODIGO = CP.PELICULA
    JOIN ALQUILER AL ON CP.ID_COPIA = AL.COPIA_PEL
GROUP BY
    TITULO;
--//-13. Muestra el nombre de los clientes y la edad que tienen.
SELECT NOMBRE, TIMESTAMPDIFF(YEAR, fec_nac, NOW()) AS EDAD
FROM SOCIO;

--//-ALTERNATIVA (14). Mostrar el código de copia cuyos precios de alquiler sean menor que 2.50 euros, usando solamente subconsultas.
SELECT ID_COPIA
FROM COPIA_PELICULA
WHERE
    PELICULA IN (
        SELECT CODIGO
        FROM PELICULA
        WHERE
            PRECIO_ALQUILER < 2.5
    );
--//-ALTERNATIVA (15). Mostrar el código de socio que han alquilado alguna película cuyo precio de alquiler sea menor que 2.50 euros, usando solamente subconsultas.
SELECT NUM_SOCIO
FROM SOCIO
WHERE
    NUM_SOCIO IN (
        SELECT SOCIO
        FROM ALQUILER
        WHERE
            COPIA_PEL IN (
                SELECT ID_COPIA
                FROM COPIA_PELICULA
                WHERE
                    PELICULA IN (
                        SELECT CODIGO
                        FROM PELICULA
                        WHERE
                            PRECIO_ALQUILER < 2.5
                    )
            )
    );
--//-ALTERNATIVA (16). Mostrar el nombre de los socios que han alquilado alguna película cuyo precio de alquiler sea menor que 2.50 euros, usando solamente subconsultas.
SELECT CONCAT(
        NOMBRE, " ", APELLIDO1, " ", APELLIDO2
    ) AS NOMBRE_COMPLETO
FROM SOCIO
WHERE
    NUM_SOCIO IN (
        SELECT SOCIO
        FROM ALQUILER
        WHERE
            COPIA_PEL IN (
                SELECT ID_COPIA
                FROM COPIA_PELICULA
                WHERE
                    PELICULA IN (
                        SELECT CODIGO
                        FROM PELICULA
                        WHERE
                            PRECIO_ALQUILER < 2.5
                    )
            )
    );
--//-ALTERNATIVA (17). Crea una vista con la consulta anterior.
CREATE VIEW SOCIOS_ESPECIALES AS
SELECT CONCAT(
        nombre, ' ', apellido1, ' ', apellido2
    ) AS nombre_completo
FROM SOCIO
WHERE
    num_socio IN (
        SELECT socio
        FROM ALQUILER
        WHERE
            copia_pel IN (
                SELECT id_copia
                FROM COPIA_PELICULA
                WHERE
                    pelicula IN (
                        SELECT codigo
                        FROM PELICULA
                        WHERE
                            precio_alquiler < 2.5
                    )
            )
    );
--//-ALTERNATIVA (18). Borrar o actualizar los alquileres que han realizado los socios de Roquetas de Mar.
DELETE FROM ALQUILER
WHERE
    SOCIO IN (
        SELECT NUM_SOCIO
        FROM SOCIO
        WHERE
            POBLACION = 'Roquetas de Mar'
    );
--//-ALTERNATIVA (19). Inserta un socio que es hermano gemelo del socio que aún no ha devuelto alguna película. Su nombre es Manuel y su número de socio será A01.
INSERT INTO
    SOCIO
SELECT
    'A01',
    'Manuel',
    apellido1,
    apellido2,
    telefono,
    domicilio,
    poblacion,
    fec_nac
FROM SOCIO
    JOIN ALQUILER ON num_socio = socio
WHERE
    fec_devolucion IS NULL;
--//-ALTERNATIVA (20). Siguiendo con el apartado anterior, resulta que son trillizos y queremos dar de alta a la tercera hermana. La nueva socia tendrá el mismo número
--//-                  que el del socio que aún no ha alquilado una película con una C al final y se llama Luisa.
INSERT INTO
    SOCIO
SELECT
    CONCAT(num_socio, 'C'),
    'Luisa',
    apellido1,
    apellido2,
    telefono,
    domicilio,
    poblacion,
    fec_nac
FROM SOCIO
WHERE
    NUM_SOCIO NOT IN(
        SELECT SOCIO
        FROM ALQUILER
    );
--//-ALTERNATIVA (21). Borra los alquileres de los socios que han alquilado una película de terror.
DELETE FROM ALQUILER
WHERE
    COPIA_PEL IN (
        SELECT ID_COPIA
        FROM COPIA_PELICULA
        WHERE
            PELICULA IN (
                SELECT CODIGO
                FROM PELICULA
                WHERE
                    GENERO LIKE 'Terror'
            )
    );
--//-ALTERNATIVA (22). Actualiza la observación de las copias a Sin datos y el estado a Revisado para aquellos socios cuyo nombre contiene en la segunda letra 'A' o
--//-                  que han alquilado películas de animación.
UPDATE COPIA_PELICULA
SET
    OBSERVACION = 'Sin datos',
    ESTADO = 'Revisado'
WHERE
    ID_COPIA IN (
        SELECT COPIA_PEL
        FROM ALQUILER
        WHERE
            SOCIO IN (
                SELECT NUM_SOCIO
                FROM SOCIO
                WHERE
                    NOMBRE LIKE '_A%'
            )
    )
    OR PELICULA IN (
        SELECT CODIGO
        FROM PELICULA
        WHERE
            GENERO LIKE 'Animacion'
    );
--//-ALTERNATIVA (23). Muestra código de copias, estado, código de película, título, duración, género, año y precio que han sido alquiladas por el socio cuyo nombre
--//-                  acabe en 'A' (con y sin subconsultas).

SELECT
    id_copia,
    estado,
    codigo,
    titulo,
    duracion,
    genero,
    anyo,
    precio_alquiler
FROM
    PELICULA
    JOIN COPIA_PELICULA ON codigo = pelicula
WHERE
    id_copia IN (
        SELECT copia_pel
        FROM ALQUILER
        WHERE
            socio IN (
                SELECT num_socio
                FROM SOCIO
                WHERE
                    nombre LIKE '%A'
            )
    );

SELECT DISTINCT
    id_copia,
    estado,
    codigo,
    titulo,
    duracion,
    genero,
    anyo,
    precio_alquiler
FROM
    PELICULA P
    JOIN COPIA_PELICULA CP ON P.CODIGO = CP.PELICULA
    JOIN ALQUILER AL ON CP.ID_COPIA = AL.COPIA_PEL
    JOIN SOCIO S ON AL.SOCIO = S.NUM_SOCIO
WHERE
    NOMBRE LIKE '%A';
--//-ALTERNATIVA (24). Crea una tabla de socios pendientes de devolver películas, incluyendo NOMBRE (nombre + apellidos), TELEFONO (telefono) y DOMICILIO (poblacion [domicilio]).
CREATE TABLE SOCIOS_PENDIENTES AS
SELECT CONCAT(
        NOMBRE, " ", APELLIDO1, " ", APELLIDO2
    ) AS NOMBRE, TELEFONO, CONCAT(
        POBLACION, "[", DOMICILIO, "]"
    ) AS DOMICILIO
FROM SOCIO
    JOIN ALQUILER ON NUM_SOCIO = SOCIO
WHERE
    FEC_DEVOLUCION IS NULL;
--//-ALTERNATIVA (25). Incrementa 50 céntimos el precio de la película más alquilada.
UPDATE PELICULA
SET
    precio_alquiler = precio_alquiler + 0.5
WHERE
    codigo IN (
        SELECT pelicula
        FROM COPIA_PELICULA
        WHERE
            id_copia IN (
                SELECT copia_pel
                FROM ALQUILER
                GROUP BY
                    1
                HAVING
                    COUNT(*) >= ALL (
                        SELECT COUNT(*)
                        FROM ALQUILER
                        GROUP BY
                            copia_pel
                    )
            )
    );