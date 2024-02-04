--//-1. Mostrar el saldo medio de todas las cuentas de la entidad bancaria.
SELECT
    AVG(SALDO) AS MEDIA
FROM
    CUENTA;

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
    COD_CLIENTE,
    SUM(SALDO),
    COUNT(*)
FROM
    CUENTA
GROUP BY
    COD_CLIENTE;

--//-6. Retocar la consulta anterior para que aparezca el nombre y apellidos de cada cliente en vez de su código de cliente.
SELECT
    NOMBRE,
    APELLIDOS,
    CU.COD_CLIENTE,
    SUM(SALDO),
    COUNT(*)
FROM
    CUENTA CU,
    CLIENTE CL
WHERE
    CU.COD_CLIENTE = CL.COD_CLIENTE
GROUP BY
    CU.COD_CLIENTE;

--//-7. Para cada sucursal del banco se desea conocer su dirección, el número de cuentas que tiene abiertas y la suma total que hay en ellas.
SELECT
    DIRECCION,
    COUNT(*),
    SUM(SALDO)
FROM
    CUENTA CU,
    SUCURSAL SU
WHERE
    SU.COD_SUCURSAL = CU.COD_SUCURSAL
GROUP BY
    CU.COD_SUCURSAL;

--//-8. Mostrar el saldo medio y el interés medio de las cuentas a las que se le aplique un interés mayor del 10%, de las sucursales 1 y 2.
SELECT
    AVG(SALDO) AS SALDO_MEDIO,
    AVG(INTERES) AS INTERES_MEDIO
FROM
    CUENTA
WHERE
    COD_SUCURSAL IN (1, 2)
    AND INTERES > 0.1;

--//-9. Mostrar  los tipos de movimientos de las cuentas bancarias, sus descripciones y el volumen total de dinero que se manejado en cada tipo de movimiento.
SELECT
    TP.COD_TIPO_MOVIMIENTO,
    DESCRIPCION,
    SUM(IMPORTE) AS VOLUMEN_TOTAL
FROM
    TIPO_MOVIMIENTO TP
    JOIN MOVIMIENTO MOV ON TP.COD_TIPO_MOVIMIENTO = MOV.COD_TIPO_MOVIMIENTO
GROUP BY
    TP.COD_TIPO_MOVIMIENTO;

--//-10. Mostrar cuál es la cantidad media que sacan de cajero los clientes de nuestro banco.
SELECT
    AVG(IMPORTE) AS SALIDA_MEDIA
FROM
    MOVIMIENTO
WHERE
    COD_TIPO_MOVIMIENTO = 'RC';

--//-11. Calcular la cantidad total de dinero que emite la entidad bancaria clasificada según los tipos de movimientos de salida.
SELECT
    TM.COD_TIPO_MOVIMIENTO,
    SUM(IMPORTE) AS IMPORTE_TOTAL
FROM
    TIPO_MOVIMIENTO TM
    JOIN MOVIMIENTO MO ON TM.COD_TIPO_MOVIMIENTO = MO.COD_TIPO_MOVIMIENTO
WHERE
    TM.SALIDA = 'Si'
GROUP BY
    MO.COD_TIPO_MOVIMIENTO;

--//-12. Calcular la cantidad total de dinero que ingresa cada cuenta bancaria clasificada según los tipos de movimientos de entrada.
SELECT
    TM.COD_TIPO_MOVIMIENTO,
    SUM(IMPORTE) AS IMPORTE_TOTAL
FROM
    TIPO_MOVIMIENTO TM
    JOIN MOVIMIENTO MO ON TM.COD_TIPO_MOVIMIENTO = MO.COD_TIPO_MOVIMIENTO
WHERE
    TM.SALIDA = 'No'
GROUP BY
    MO.COD_TIPO_MOVIMIENTO;

--//-13. Calcular la cantidad total de dinero que sale de la entidad bancaria mediante cualquier movimiento de “salida”.
SELECT
    SUM(IMPORTE) AS CANTIDAD_TOTAL
FROM
    MOVIMIENTO MO
    JOIN TIPO_MOVIMIENTO TM ON MO.COD_TIPO_MOVIMIENTO = TM.COD_TIPO_MOVIMIENTO
WHERE
    TM.SALIDA = "Si";

--//-14. Mostrar la suma total por tipo de movimiento de las cuentas bancarias de los clientes del banco.
--//- Se deben mostrar los siguientes campos: apellidos, nombre, cod_cuenta, descripción  del  tipo  movimiento  y  el  total  acumulado  de  los  movimientos de un mismo tipo.
SELECT
    APELLIDOS,
    NOMBRE,
    CU.COD_CUENTA,
    DESCRIPCION,
    SUM(IMPORTE)
FROM
    CLIENTE CL
    JOIN CUENTA CU ON CL.COD_CLIENTE = CU.COD_CLIENTE
    JOIN MOVIMIENTO MO ON CU.COD_CUENTA = MO.COD_CUENTA
    JOIN TIPO_MOVIMIENTO TM ON TM.COD_TIPO_MOVIMIENTO = MO.COD_TIPO_MOVIMIENTO
GROUP BY
    TM.COD_TIPO_MOVIMIENTO,
    CU.COD_CUENTA
ORDER BY
    APELLIDOS;

--//-15. Contar el número de cuentas bancarias que no tienen asociados movimientos.
--//-16. Por cada cliente, contar el número de cuentas bancarias que posee sin movimientos. Se deben mostrar los siguientes campos: cod_cliente, num_cuentas_sin_movimiento.
--//-17. Mostrar el código de cliente, la suma total del dinero de todas sus cuentas y el número de cuentas abiertas, sólo para aquellos clientes cuyo capital supere los 35.000 euros.
--//-18. Mostrar los apellidos, el nombre y el número de cuentas abiertas sólo de aquellos clientes que tengan más de 2 cuentas.
--//-19. Mostrar el código de sucursal, dirección, capital del año anterior y la suma de los saldos de sus cuentas, sólo de aquellas 
--//- sucursales cuya suma de los saldos de las cuentas supera el capital del año anterior.
--//-20. Mostrar el código de cuenta, su saldo, la descripción del tipo de movimiento y la suma total de dinero por movimiento,
--//- sólo para aquellas cuentas cuya suma total de dinero por movimiento supere el 20% del saldo.
--//-21. Mostrar los mismos campos del ejercicio anterior pero ahora sólo de aquellas cuentas cuya  suma  de  importes por movimiento supere el 10% del saldo y no sean de la sucursal 4.
--//-22. Mostrar los datos de aquellos clientes para los que el saldo de sus cuentas suponga al menos el 20% del capital del año anterior de su sucursal.