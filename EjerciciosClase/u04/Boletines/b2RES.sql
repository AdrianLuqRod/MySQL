/*1. Mostrar el saldo medio de todas las cuentas de la entidad bancaria.*/
select
    avg(saldo)
from
    cuenta;

--alternativa para redondear
select
    round(avg(saldo), 1)
from
    cuenta;

--alternativa para mostrar 1 decimal
select
    truncate (avg(saldo), 1)
from
    cuenta;

/*2. Mostrar la suma de los saldos de todas las cuentas bancarias.*/
select
    sum(saldo) as sumatotal
from
    cuenta;

/*3. Mostrar el saldo mínimo, máximo y medio de todas las cuentas bancarias.*/
select
    min(saldo) as saldoMinimo,
    max(saldo) as saldoMaximo,
    round(avg(saldo), 2) as saldoMedio
from
    cuenta;

/*4. Mostrar la suma de los saldos y el saldo medio de las 
cuentas bancarias agrupadas por
su código de sucursal.*/
select
    cod_sucursal,
    sum(saldo) as suma,
    avg(saldo) as saldoMedio
from
    cuenta
group by
    cod_sucursal;

/*5. Para cada cliente del banco se desea conocer su código, 
la cantidad total que tiene
depositada en la entidad y el número de cuentas abiertas.*/
/*alternativa en la que muestre todos los clientes de la tabla cliente
incluidos los que no tengan cuentas. Esta es la alternativa correcta.*/
select
    cl.cod_cliente,
    sum(cu.saldo),
    count(cu.cod_cuenta) as NumCuentas
from
    cliente cl
    left join cuenta cu on cl.cod_cliente = cu.cod_cliente
group by
    cl.cod_cliente;

--con right
select
    cl.cod_cliente,
    sum(cu.saldo),
    count(cu.cod_cuenta) as NumCuentas
from
    cuenta cu
    right join cliente cl on cl.cod_cliente = cu.cod_cliente
group by
    cl.cod_cliente;

-- alternativa si entendemos que solamente debe mostrar los clientes con cuentas
--Pero no es correcta porque en el enunciado indica que es cliente aunque
--no tenga cuenta
select
    cod_cliente,
    sum(saldo),
    count(cod_cuenta) as NumCuentas
from
    cuenta
group by
    cod_cliente;

--alternativa mostrar los clientes sin cuenta opción 1
select
    cl.cod_cliente,
    count(cod_cuenta) as numCuentas
from
    cliente cl
    left join cuenta cu on cl.cod_cliente = cu.cod_cliente
group by
    cl.cod_cliente
having
    numCuentas = 0;

--alternativa mostrar los clientes sin cuenta opción 2
select
    cl.cod_cliente
from
    cliente cl
    left join cuenta cu on cl.cod_cliente = cu.cod_cliente
where
    cu.cod_cliente is null
group by
    cl.cod_cliente;

/*6. Retocar la consulta anterior para que aparezca el nombre y apellidos de cada cliente en
vez de su código de cliente.*/
--todos los clientes aunque no tengan cuentas
select
    cl.nombre,
    cl.apellidos,
    sum(cu.saldo),
    count(cu.cod_cuenta) as NumCuentas
from
    cliente cl
    left join cuenta cu on cl.cod_cliente = cu.cod_cliente
group by
    cl.cod_cliente;

--los clientes que tienen cuentas en la tabla cuentas
select
    cl.nombre,
    cl.apellidos,
    sum(cu.saldo),
    count(cu.cod_cuenta) as NumCuentas
from
    cuenta cu,
    cliente cl
where
    cu.cod_cliente = cl.cod_cliente
group by
    cl.cod_cliente;

/*7. Para cada sucursal del banco se desea conocer su dirección,
el número de cuentas que
tiene abiertas y la suma total que hay en ellas.*/
select
    s.cod_sucursal,
    s.direccion,
    sum(c.saldo),
    count(c.cod_cuenta) as NumCuentas
from
    sucursal s,
    cuenta c
where
    s.cod_sucursal = c.cod_sucursal
group by
    s.cod_sucursal;

/*8. Mostrar el saldo medio y el interés medio de las cuentas a las que se le aplique un interés
mayor del 10%, de las sucursales 1 y 2.*/
select
    avg(saldo) as saldoMedio,
    avg(interes) as interesMedio
from
    cuenta
where
    (
        cod_sucursal = 1
        or cod_sucursal = 2
    )
    and interes > 0.1;

--alternativa
select
    avg(saldo) as saldoMedio,
    avg(interes) as interesMedio
from
    cuenta
where
    cod_sucursal in (1, 2)
    and interes > 0.1;

/*9. Mostrar los tipos de movimientos de las cuentas bancarias, sus descripciones y el
volumen total de dinero que se manejado en cada tipo de movimiento.
 */
--alternativa en la que no salen tipo_moviento que no tienen movimiento
-- porque habla de mostrar los que han tenido un manejo de dinero.
select
    t.cod_tipo_movimiento,
    t.descripcion,
    sum(m.importe)
from
    tipo_movimiento t,
    movimiento m
where
    m.cod_tipo_movimiento = t.cod_tipo_movimiento
group by
    t.cod_tipo_movimiento;

--alternativa con  natural join
select
    t.cod_tipo_movimiento,
    t.descripcion,
    sum(m.importe)
from
    tipo_movimiento t
    natural join movimiento m
group by
    t.cod_tipo_movimiento;

--alternativa con join
select
    t.cod_tipo_movimiento,
    t.descripcion,
    sum(m.importe)
from
    tipo_movimiento t
    join movimiento m on m.cod_tipo_movimiento = t.cod_tipo_movimiento
group by
    t.cod_tipo_movimiento;

/*10. Mostrar cuál es la cantidad media que sacan de cajero 
los clientes de nuestro banco.*/
select
    avg(importe) as MediaCajeros
from
    movimiento
where
    cod_tipo_movimiento like 'RC';

--Si se pidiera "Mostrar cuál es la cantidad media que los clientes llevan
--a cabo cuando el tipo de movimiento es 'Retirada por cajero automatico'"
select
    avg(m.importe) as MediaCajeros
from
    movimiento m,
    tipo_movimiento t
where
    m.cod_tipo_movimiento = t.cod_tipo_movimiento
    and t.descripcion like 'Retirada por cajero automatico';

--1.Variante al enunciado 10. Mostrar la cantidad  media que 
--sacan de cajero cada cliente de nuestro banco.
select
    c.cod_cliente,
    avg(m.importe) as MediaCajeros
from
    movimiento m,
    cuenta c
where
    m.cod_cuenta = c.cod_cuenta
    and m.cod_tipo_movimiento like 'RC'
group by
    c.cod_cliente;

--2.Variante al enunciado 10. Mostrar la cantidad  media 
--que sacan de cajero
--cada cliente de nuestro banco y los nombres de dichos clientes.
select
    c.cod_cliente,
    cl.nombre,
    avg(m.importe) as MediaCajeros
from
    movimiento m,
    cuenta c,
    cliente cl
where
    m.cod_cuenta = c.cod_cuenta
    and cl.cod_cliente = c.cod_cliente
    and m.cod_tipo_movimiento like 'RC'
group by
    c.cod_cliente;

/*3.Variante al enunciado 10. Mostrar cuál es la cantidad media que 
cada cliente llevaa cabo cuando el tipo de movimiento es 
'Retirada por cajero automatico' y el nombre de dichos clientes.*/
select
    c.cod_cliente,
    cl.nombre,
    avg(m.importe) as MediaCajeros
from
    movimiento m,
    cuenta c,
    cliente cl,
    tipo_movimiento t
where
    m.cod_cuenta = c.cod_cuenta
    and cl.cod_cliente = c.cod_cliente
    and m.cod_tipo_movimiento = t.cod_tipo_movimiento
    and t.descripcion like 'Retirada por cajero automatico'
group by
    c.cod_cliente;

/*3.Variante al enunciado 10 con JOIN. Es igual que INNER JOIN*/
select
    c.cod_cliente,
    cl.nombre,
    avg(m.importe) as MediaCajeros
from
    movimiento m
    join cuenta c on m.cod_cuenta = c.cod_cuenta
    join cliente cl on cl.cod_cliente = c.cod_cliente
    join tipo_movimiento t on m.cod_tipo_movimiento = t.cod_tipo_movimiento
where
    t.descripcion like 'Retirada por cajero automatico'
group by
    c.cod_cliente;

/*3.Variante al enunciado 10 con NATURAL JOIN. Tenéis que manejar 
las otras dos formas ya que para usar NATURAL JOIN los campos
de unión deben tener el mismo nombre.*/
select
    c.cod_cliente,
    cl.nombre,
    avg(m.importe) as MediaCajeros
from
    movimiento m
    natural join cuenta c
    natural join cliente cl
    natural join tipo_movimiento t
where
    t.descripcion like 'Retirada por cajero automatico'
group by
    c.cod_cliente;

/*11. Calcular la cantidad total de dinero que emite la entidad 
bancaria clasificada según los tipos de movimientos de salida.
 */
select
    t.descripcion,
    sum(m.importe)
from
    tipo_movimiento t,
    movimiento m
where
    m.cod_tipo_movimiento = t.cod_tipo_movimiento
    and t.salida like 'Si'
group by
    t.cod_tipo_movimiento;

/*12. Calcular la cantidad total de dinero que ingresa cada 
cuenta bancaria clasificada según
los tipos de movimientos de entrada.*/
select
    m.cod_cuenta,
    t.descripcion,
    sum(m.importe)
from
    tipo_movimiento t,
    movimiento m
where
    m.cod_tipo_movimiento = t.cod_tipo_movimiento
    and t.salida like 'No'
group by
    m.cod_cuenta;

/*13. Calcular la cantidad total de dinero que sale de la 
entidad bancaria mediante cualquier
movimiento de “salida”.*/
select
    sum(m.importe) as totalMovSalida
from
    movimiento m,
    tipo_movimiento t
where
    m.cod_tipo_movimiento = t.cod_tipo_movimiento
    and t.salida like 'Si';

/*14. Mostrar la suma total por tipo de movimiento de las cuentas 
bancarias de los clientes del
banco. Se deben mostrar los siguientes campos: apellidos, nombre, 
cod_cuenta,
descripción del tipo movimiento y el total acumulado de los 
movimientos de un
mismo tipo.*/
select
    cl.apellidos,
    cl.nombre,
    cu.cod_cuenta,
    t.descripcion,
    sum(m.importe) as totalMov
from
    cliente cl,
    cuenta cu,
    tipo_movimiento t,
    movimiento m
where
    cl.cod_cliente = cu.cod_cliente
    and cu.cod_cuenta = m.cod_cuenta
    and m.cod_tipo_movimiento = t.cod_tipo_movimiento
group by
    cl.apellidos,
    cl.nombre,
    cu.cod_cuenta,
    t.descripcion
order by
    1,
    2,
    3;

/*15. Contar el número de cuentas bancarias que no tienen 
asociados movimientos.*/
/*Tenemos que buscar las cuentas que no tienen moviemtos partiendo 
select c.cod_cuenta, m.cod_cuenta as NumCuentasSinMov
from cuenta c left join movimiento m
on c.cod_cuenta = m.cod_cuenta;*/
select
    count(*) as NumCuentasSinMov
from
    cuenta c
    left join movimiento m on c.cod_cuenta = m.cod_cuenta
where
    m.cod_cuenta is null;

--alternativa con right
select
    count(*) as NumCuentasSinMov
from
    movimiento m
    right join cuenta c on c.cod_cuenta = m.cod_cuenta
where
    m.cod_cuenta is null;

--alternativa con menos
select
    count(DISTINCT c.cod_cuenta) - count(DISTINCT m.cod_cuenta)
from
    cuenta c,
    movimiento m;

/*16. Por cada cliente, contar el número de cuentas bancarias 
que posee sin movimientos. Se
deben mostrar los siguientes campos: cod_cliente, 
num_cuentas_sin_movimiento.*/
select
    cod_cliente,
    count(*) as num_cuentas_sin_movimiento
from
    cuenta c
    left join movimiento m on c.cod_cuenta = m.cod_cuenta
where
    m.cod_cuenta is NULL
group by
    c.cod_cliente;

/*Variante 16. Por cada cliente, contar el número de cuentas bancarias 
que posee sin movimientos. Se
deben mostrar los siguientes campos: apellido cliente, nomc_cliente 
num_cuentas_sin_movimiento.*/
select
    cl.apellidos,
    cl.nombre,
    count(*) as num_cuentas_sin_movimiento
from
    cliente cl
    join cuenta c on cl.cod_cliente = c.cod_cliente
    left join movimiento m on c.cod_cuenta = m.cod_cuenta
where
    m.cod_cuenta is NULL
group by
    cl.apellidos,
    cl.nombre;

/*17. Mostrar el código de cliente, la suma total del dinero de todas 
sus cuentas y el número de
cuentas abiertas, sólo para aquellos clientes cuyo capital 
supere los 35.000 euros.*/
select
    cod_cliente,
    sum(saldo) as Capital,
    count(*) as NumCuentas
from
    cuenta
group by
    cod_cliente
having
    sum(saldo) > 35000;

/*18. Mostrar los apellidos, el nombre y el número de cuentas 
abiertas sólo de aquellos
clientes que tengan más de 2 cuentas.*/
SELECT
    cl.apellidos,
    cl.nombre,
    count(*) as NumCuentas
FROM
    cliente cl,
    cuenta cu
where
    cl.cod_cliente = cu.cod_cliente
group BY
    cl.apellidos,
    cl.nombre
having
    count(*) > 2;

/*19. Mostrar el código de sucursal, dirección, capital del año anterior 
y la suma de los saldos de sus cuentas, sólo de aquellas sucursales 
cuya suma de los saldos de las cuentas supera el capital del año anterior.
 */
SELECT
    s.cod_sucursal,
    s.direccion,
    s.capital_anio_anterior,
    sum(c.saldo) as SumaSaldos
FROM
    sucursal s,
    cuenta c
where
    s.cod_sucursal = c.cod_sucursal
group BY
    s.cod_sucursal
having
    SumaSaldos > s.capital_anio_anterior;

SELECT
    s.cod_sucursal,
    s.direccion,
    s.capital_anio_anterior,
    sum(c.saldo) as SumaSaldos
FROM
    sucursal s,
    cuenta c
where
    s.cod_sucursal = c.cod_sucursal
group BY
    s.cod_sucursal,
    s.direccion,
    s.capital_anio_anterior
having
    SumaSaldos > s.capital_anio_anterior;

/*20. Mostrar el código de cuenta, su saldo, la descripción del tipo de 
movimiento y la suma
total de dinero por movimiento, sólo para aquellas cuentas cuya 
suma total de dinero por
movimiento supere el 20% del saldo.*/
SELECT
    c.cod_cuenta,
    c.saldo,
    t.descripcion,
    sum(m.importe) as TotalMovimiento
FROM
    cuenta c
    join movimiento m on c.cod_cuenta = m.cod_cuenta
    join tipo_movimiento t on m.cod_tipo_movimiento = t.cod_tipo_movimiento
group BY
    c.cod_cuenta,
    t.descripcion
having
    sum(m.importe) > c.saldo * 0.2;

---pruebas
SELECT
    c.cod_cuenta,
    c.saldo,
    t.descripcion,
    sum(m.importe) as TotalMovimiento,
    c.saldo * 0.2 as condicion
FROM
    cuenta c
    join movimiento m on c.cod_cuenta = m.cod_cuenta
    join tipo_movimiento t on m.cod_tipo_movimiento = t.cod_tipo_movimiento
group BY
    c.cod_cuenta,
    t.descripcion;

/*21. Mostrar los mismos campos del ejercicio anterior pero ahora 
sólo de aquellas cuentas
cuya suma de importes por movimiento supere el 10% del saldo y
no sean de la
sucursal 4.*/
SELECT
    c.cod_cuenta,
    c.saldo,
    t.descripcion,
    c.cod_sucursal,
    sum(m.importe) as TotalMovimiento
FROM
    cuenta c
    join movimiento m on c.cod_cuenta = m.cod_cuenta
    join tipo_movimiento t on m.cod_tipo_movimiento = t.cod_tipo_movimiento
group BY
    c.cod_cuenta,
    c.saldo,
    t.descripcion
having
    sum(m.importe) > c.saldo * 0.1
    AND c.cod_sucursal != 4;

--alternativa más correcta
SELECT
    c.cod_cuenta,
    c.saldo,
    t.descripcion,
    sum(m.importe) as TotalMovimiento
FROM
    cuenta c
    join movimiento m on c.cod_cuenta = m.cod_cuenta
    join tipo_movimiento t on m.cod_tipo_movimiento = t.cod_tipo_movimiento
where
    c.cod_sucursal != 4
group BY
    c.cod_cuenta,
    c.saldo,
    t.descripcion
having
    sum(m.importe) > c.saldo * 0.1;

/*22. Mostrar los datos de aquellos clientes para los que el saldo de 
sus cuentas suponga al
menos el 20% del capital del año anterior de su sucursal.*/
SELECT
    cl.cod_cliente,
    cl.apellidos,
    cl.nombre,
    cl.direccion,
    s.capital_anio_anterior
FROM
    cliente cl
    join cuenta c on cl.cod_cliente = c.cod_cliente
    join sucursal s on c.cod_sucursal = s.cod_sucursal
group BY
    cl.cod_cliente,
    cl.apellidos,
    cl.nombre,
    cl.direccion
having
    sum(c.saldo) >= s.capital_anio_anterior * 0.2;

--Incorrecta
SELECT
    cl.cod_cliente,
    cl.apellidos,
    cl.nombre,
    cl.direccion
FROM
    cliente cl
    join cuenta c on cl.cod_cliente = c.cod_cliente
    join sucursal s on c.cod_sucursal = s.cod_sucursal
group BY
    cl.cod_cliente,
    cl.apellidos,
    cl.nombre,
    cl.direccion,
    s.capital_anio_anterior
having
    sum(c.saldo) >= s.capital_anio_anterior * 0.2;