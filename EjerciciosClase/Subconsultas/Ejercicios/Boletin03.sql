--//-1. Por cada cliente, contar el número de cuentas bancarias que posee sin movimientos.
--//-   Se deben mostrar los siguientes campos: apellidos, nombre, num_cuentas_sin_movimiento (tomar como base el ejercicio 16 de las consultas de resumen).
SELECT
    APELLIDOS,
    NOMBRE,
    COUNT(*) AS NUM_CUENTAS_SIN_MOVIMIENTO
FROM CLIENTE CL, CUENTA CU
WHERE
    COD_CUENTA NOT IN(
        SELECT COD_CUENTA
        FROM MOVIMIENTO M
        WHERE
            CU.CODCUENTA = M.COD_CUENTA
    )
    AND CL.COD_CLIENTE = CU.COD_CLIENTE
GROUP BY
    CL.COD_CLIENTE;
--//-2. Mostrar los datos de aquellos clientes que en todas sus cuentas posean un saldo mayor de 15.000 euros.
SELECT *
FROM CLIENTE CL
WHERE
    15000 < ALL (
        SELECT CU.SALDO
        FROM CUENTA CU
        WHERE
            CL.COD_CLIENTE = CU.COD_CLIENTE
    );
--//-3. Mostrar los datos de aquellos clientes que alguna de sus cuentas posean un saldo superior a 60.000 euros.
SELECT *
FROM CLIENTE CL
WHERE
    60000 < ANY (
        SELECT CU.SALDO
        FROM CUENTA CU
        WHERE
            CL.COD_CLIENTE = CU.COD_CLIENTE
    );

--//-4. Mostrar los datos de aquellas cuentas que tenga algún movimiento a las 14:15 horas.
SELECT *
FROM CUENTA CU
WHERE
    COD_CUENTA IN (
        SELECT COD_CUENTA
        FROM MOVIMIENTO M
        WHERE
            TIME(FECHA_HORA) LIKE '14:15:00'
    );
--//-5. Mostrar los datos de aquellas cuentas que no tengan movimientos del tipo PT (pago con tarjeta).
SELECT *
FROM CUENTA CU
WHERE
    COD_CUENTA NOT IN(
        SELECT COD_CUENTA
        FROM MOVIMIENTO
        WHERE
            COD_TIPO_MOVIMIENTO LIKE 'PT'
    );

--//-6. Mostrar los datos de las cuentas de las que no existan movimientos.
SELECT *
FROM CUENTA CU
WHERE
    COD_CUENTA NOT IN(
        SELECT COD_CUENTA
        FROM MOVIMIENTO
    );
--//-7. Mostrar los datos de las cuentas que tienen más de 1 movimiento del tipo PT (pago con tarjeta).
SELECT *
FROM CUENTA CU
WHERE
    CU.COD_CUENTA IN (
        SELECT M.COD_CUENTA
        FROM MOVIMIENTO M
        WHERE
            M.COD_TIPO_MOVIMIENTO LIKE 'PT'
        GROUP BY
            M.COD_CUENTA
        HAVING
            COUNT(*) > 1
    );