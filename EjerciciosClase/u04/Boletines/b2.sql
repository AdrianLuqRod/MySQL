--//-1. Mostrar el saldo medio de todas las cuentas de la entidad bancaria.
SELECT
    AVG(SALDO) AS MEDIA
FROM
    CUENTA;

--//-2. Mostrar la suma de los saldos de todas las cuentas bancarias.
SELECT
    SUM(SALDO) AS SUMA_SALDOS
FROM
    CUENTA;

--//-3. Mostrar el saldo mínimo, máximo y medio de todas las cuentas bancarias.
SELECT
    MIN(SALDO) AS SALDO_MINIMO,
    MAX(SALDO) AS SALDO_MAXIMO,
    AVG(SALDO) AS MEDIA_SALDOS
FROM
    CUENTA;

--//-4. Mostrar la suma de los saldos y el saldo medio de las cuentas bancarias agrupadas por su código de sucursal.
SELECT
    SUM(SALDO) AS SUMA_SALDOS,
    AVG(SALDO) AS MEDIA_SALDOS
FROM
    CUENTA
GROUP BY
    COD_SUCURSAL;

--//-5. Para cada cliente del banco se desea conocer su código, la cantidad total que tiene depositada en la entidad y el número de cuentas abiertas.
SELECT
    CL.COD_CLIENTE,
    SUM(CU.SALDO) AS CANTIDAD_TOTAL,
    COUNT(CU.COD_CUENTA) AS NUM_CUENTAS
FROM
    CLIENTE CL
    LEFT JOIN CUENTA CU ON CL.COD_CLIENTE = CU.COD_CLIENTE
GROUP BY
    CL.COD_CLIENTE;

--//-6. Retocar la consulta anterior para que aparezca el nombre y apellidos de cada cliente en vez de su código de cliente.
SELECT
    CL.NOMBRE,
    CL.APELLIDOS,
    SUM(CU.SALDO) AS CANTIDAD_TOTAL,
    COUNT(CU.COD_CUENTA) AS NUM_CUENTAS
FROM
    CLIENTE CL
    LEFT JOIN CUENTA CU ON CL.COD_CLIENTE = CU.COD_CLIENTE
GROUP BY
    CL.COD_CLIENTE;

--//-7. Para cada sucursal del banco se desea conocer su dirección, el número de cuentas que tiene abiertas y la suma total que hay en ellas.
SELECT
    SU.DIRECCION,
    COUNT(CU.COD_CUENTA) AS NUM_CUENTAS,
    SUM(SALDO) AS SUMA_TOTAL
FROM
    SUCURSAL SU
    JOIN CUENTA CU ON SU.COD_SUCURSAL = CU.COD_SUCURSAL
GROUP BY
    CU.COD_SUCURSAL;

--//-8. Mostrar el saldo medio y el interés medio de las cuentas a las que se le aplique un interés mayor del 10%, de las sucursales 1 y 2.
SELECT
    AVG(CU.SALDO) AS SALDO_MEDIO,
    AVG(CU.INTERES) AS INTERES_MEDIO
FROM
    CUENTA CU
    JOIN SUCURSAL SU ON CU.COD_SUCURSAL = SU.COD_SUCURSAL
WHERE
    CU.INTERES > 0.1
    AND SU.COD_SUCURSAL IN (1, 2);

--//-9. Mostrar  los tipos de movimientos de las cuentas bancarias, sus descripciones y el volumen total de dinero que se manejado en cada tipo de movimiento.
SELECT
    TP.COD_TIPO_MOVIMIENTO,
    TP.DESCRIPCION,
    SUM(MOV.IMPORTE) AS VOLUMEN_TOTAL
FROM
    TIPO_MOVIMIENTO TP
    JOIN MOVIMIENTO MOV ON TP.COD_TIPO_MOVIMIENTO = MOV.COD_TIPO_MOVIMIENTO
GROUP BY
    TP.COD_TIPO_MOVIMIENTO;

--//-10. Mostrar cuál es la cantidad media que sacan de cajero los clientes de nuestro banco.
SELECT
    AVG(MOV.IMPORTE) AS CANTIDAD_MEDIA,
    TP.COD_TIPO_MOVIMIENTO
FROM
    TIPO_MOVIMIENTO TP
    JOIN MOVIMIENTO MOV ON TP.COD_TIPO_MOVIMIENTO = MOV.COD_TIPO_MOVIMIENTO
WHERE
    TP.COD_TIPO_MOVIMIENTO LIKE "RC";

--//-11. Calcular la cantidad total de dinero que emite la entidad bancaria clasificada según los tipos de movimientos de salida.
SELECT
    TP.DESCRIPCION,
    SUM(MOV.IMPORTE) AS CANTIDAD_TOTAL
FROM
    MOVIMIENTO MOV
    JOIN TIPO_MOVIMIENTO TP ON MOV.COD_TIPO_MOVIMIENTO = TP.COD_TIPO_MOVIMIENTO
WHERE
    TP.SALIDA LIKE "Si"
GROUP BY
    TP.COD_TIPO_MOVIMIENTO;

--//-12. Calcular la cantidad total de dinero que ingresa cada cuenta bancaria clasificada según los tipos de movimientos de entrada.
SELECT
    CU.COD_CUENTA,
    TP.DESCRIPCION,
    SUM(MOV.IMPORTE) AS CANTIDAD_TOTAL
FROM
    CUENTA CU
    JOIN MOVIMIENTO MOV ON CU.COD_CUENTA = MOV.COD_CUENTA
    JOIN TIPO_MOVIMIENTO TP ON MOV.COD_TIPO_MOVIMIENTO = TP.COD_TIPO_MOVIMIENTO
WHERE
    TP.SALIDA LIKE "No"
GROUP BY
    CU.COD_CUENTA;

--//-13. Calcular la cantidad total de dinero que sale de la entidad bancaria mediante cualquier movimiento de “salida”.
SELECT
    SUM(MOV.IMPORTE) AS CANTIDAD_TOTAL
FROM
    MOVIMIENTO MOV
    JOIN TIPO_MOVIMIENTO TP ON MOV.COD_TIPO_MOVIMIENTO = TP.COD_TIPO_MOVIMIENTO
WHERE
    TP.SALIDA LIKE "Si";

--//-14. Mostrar la suma total por tipo de movimiento de las cuentas bancarias de los clientes del banco.
--//- Se deben mostrar los siguientes campos: apellidos, nombre, cod_cuenta, descripción  del  tipo  movimiento  y  el  total  acumulado  de  los  movimientos de un mismo tipo.
SELECT
    CL.APELLIDOS,
    CL.NOMBRE,
    CU.COD_CUENTA,
    TP.DESCRIPCION,
    SUM(MOV.IMPORTE) AS TOTAL_ACUMULADO
FROM
    CLIENTE CL
    JOIN CUENTA CU ON CL.COD_CLIENTE = CU.COD_CLIENTE
    JOIN MOVIMIENTO MOV ON CU.COD_CUENTA = MOV.COD_CUENTA
    JOIN TIPO_MOVIMIENTO TP ON MOV.COD_TIPO_MOVIMIENTO = TP.COD_TIPO_MOVIMIENTO
GROUP BY
    CU.COD_CUENTA,
    TP.COD_TIPO_MOVIMIENTO;

--//-15. Contar el número de cuentas bancarias que no tienen asociados movimientos.
SELECT
    COUNT(CU.COD_CUENTA) AS NUM_CUENTAS_SIN_MOVIMIENTOS
FROM
    CUENTA CU
    LEFT JOIN MOVIMIENTO MOV ON CU.COD_CUENTA = MOV.COD_CUENTA
WHERE
    MOV.COD_CUENTA IS NULL;

--//-16. Por cada cliente, contar el número de cuentas bancarias que posee sin movimientos. Se deben mostrar los siguientes campos: cod_cliente, num_cuentas_sin_movimiento.
SELECT
    CL.COD_CLIENTE,
    COUNT(CU.COD_CUENTA) AS NUM_CUENTAS_SIN_MOVIMIENTOS
FROM
    CLIENTE CL
    JOIN CUENTA CU ON CL.COD_CLIENTE = CU.COD_CLIENTE
    LEFT JOIN MOVIMIENTO MOV ON CU.COD_CUENTA = MOV.COD_CUENTA
WHERE
    MOV.COD_CUENTA IS NULL
GROUP BY
    CL.COD_CLIENTE;

--//-17. Mostrar el código de cliente, la suma total del dinero de todas sus cuentas y el número de cuentas abiertas, sólo para aquellos clientes cuyo capital supere los 35.000 euros.
SELECT
    CL.COD_CLIENTE,
    SUM(CU.SALDO) AS DINERO_TOTAL_CUENTAS,
    COUNT(CU.COD_CUENTA) AS CUENTAS_ABIERTAS
FROM
    CLIENTE CL
    JOIN CUENTA CU ON CL.COD_CLIENTE = CU.COD_CLIENTE
GROUP BY
    CL.COD_CLIENTE
HAVING
    SUM(CU.SALDO) > 35000;

--//-18. Mostrar los apellidos, el nombre y el número de cuentas abiertas sólo de aquellos clientes que tengan más de 2 cuentas.
SELECT
    CL.APELLIDOS,
    CL.NOMBRE,
    COUNT(CU.COD_CUENTA) AS NUM_CUENTAS
FROM
    CLIENTE CL
    JOIN CUENTA CU ON CL.COD_CLIENTE = CU.COD_CLIENTE
GROUP BY
    CL.COD_CLIENTE
HAVING
    NUM_CUENTAS > 2;

--//-19. Mostrar el código de sucursal, dirección, capital del año anterior y la suma de los saldos de sus cuentas, sólo de aquellas 
--//- sucursales cuya suma de los saldos de las cuentas supera el capital del año anterior.
SELECT
    SU.COD_SUCURSAL,
    SU.DIRECCION,
    SU.CAPITAL_ANIO_ANTERIOR,
    SUM(CU.SALDO) AS SUMA_SALDOS
FROM
    SUCURSAL SU
    JOIN CUENTA CU ON SU.COD_SUCURSAL = CU.COD_SUCURSAL
GROUP BY
    SU.COD_SUCURSAL
HAVING
    SUMA_SALDOS > SU.CAPITAL_ANIO_ANTERIOR;

--//-20. Mostrar el código de cuenta, su saldo, la descripción del tipo de movimiento y la suma total de dinero por movimiento,
--//- sólo para aquellas cuentas cuya suma total de dinero por movimiento supere el 20% del saldo.
SELECT
    CU.COD_CUENTA,
    CU.SALDO,
    TP.DESCRIPCION,
    SUM(MOV.IMPORTE) AS SUMA_TOTAL
FROM
    CUENTA CU
    JOIN MOVIMIENTO MOV ON CU.COD_CUENTA = MOV.COD_CUENTA
    JOIN TIPO_MOVIMIENTO TP ON MOV.COD_TIPO_MOVIMIENTO = TP.COD_TIPO_MOVIMIENTO
GROUP BY
    CU.COD_CUENTA,
    TP.DESCRIPCION
HAVING
    SUMA_TOTAL > CU.SALDO * 0.2;

--//-21. Mostrar los mismos campos del ejercicio anterior pero ahora sólo de aquellas cuentas cuya  suma  de  importes por movimiento supere el 10% del saldo y no sean de la sucursal 4.
SELECT
    CU.COD_CUENTA,
    CU.SALDO,
    TP.DESCRIPCION,
    CU.COD_SUCURSAL,
    SUM(MOV.IMPORTE) AS SUMA_TOTAL
FROM
    CUENTA CU
    JOIN MOVIMIENTO MOV ON CU.COD_CUENTA = MOV.COD_CUENTA
    JOIN TIPO_MOVIMIENTO TP ON MOV.COD_TIPO_MOVIMIENTO = TP.COD_TIPO_MOVIMIENTO
GROUP BY
    CU.COD_CUENTA,
    TP.DESCRIPCION,
    CU.SALDO
HAVING
    SUMA_TOTAL > CU.SALDO * 0.1
    AND CU.COD_SUCURSAL != 4;

--//-22. Mostrar los datos de aquellos clientes para los que el saldo de sus cuentas suponga al menos el 20% del capital del año anterior de su sucursal.
SELECT
    CL.COD_CLIENTE,
    CL.APELLIDOS,
    CL.NOMBRE,
    CL.DIRECCION,
    SU.CAPITAL_ANIO_ANTERIOR
FROM
    CLIENTE CL
    JOIN CUENTA CU ON CL.COD_CLIENTE = CU.COD_CLIENTE
    JOIN SUCURSAL SU ON CU.COD_SUCURSAL = SU.COD_SUCURSAL
GROUP BY
    CL.COD_CLIENTE,
    CL.APELLIDOS,
    CL.NOMBRE,
    CL.DIRECCION
HAVING
    SUM(CU.SALDO) >= SU.CAPITAL_ANIO_ANTERIOR * 0.2;

-- dsada
SELECT
    CONCAT (NOMBRE, " ", APELLIDOS) AS 'NOMBRE COMPLETO'
FROM
    CLIENTE CL
    LEFT JOIN CUENTA CU ON CL.COD_CLIENTE = CU.COD_CLIENTE

WHERE CU.COD_CLIENTE IS NULL