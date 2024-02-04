/*1. Mostrar el nombre de las provincias*/
SELECT nombre
FROM provincia;

/*2. Mostrar el nombre y apellidos de los alumnos*/
SELECT nombre, apellidos
from alumno;

/*3. Mostrar el código y el nombre de todas las asignaturas*/
select id_asig, nombre
from asignatura;

/*4. Mostrar el DNI, nombre y apellidos de los profesores, ordenados por DNI
ascendentemente*/
select dni, nombre, apellidos
from profesor
order by dni asc;

--alternativa
select dni, nombre, apellidos
from profesor
order by 1 asc;

--asc se puede omitir ya que por defecto ordena asc

/*5. Mostrar los datos de los alumnos de mayor a menor edad, de forma que en la columna
de la fecha de nacimiento aparezca el encabezado “Fecha_de_nacimiento”*/
select id_alum, dni, nombre, apellidos, fecha_nac as Fecha_de_nacimiento, nacido_en
from alumno
order by fecha_nac;

--alternativa
select id_alum, dni, nombre, apellidos, fecha_nac as Fecha_de_nacimiento, nacido_en
from alumno
order by Fecha_de_nacimiento;

--alternativa
select id_alum, dni, nombre, apellidos, fecha_nac as Fecha_de_nacimiento, nacido_en
from alumno
order by 5;

/*6. Mostrar los datos del alumno cuyo DNI es 56846315M*/
select *
from alumno
where dni = '56846315M';

--alternativa
select *
from alumno
where dni like '56846315M';

--alternativa 2
select *
from alumno
where upper(dni) like upper('56846315M');

/*7 Mostrar los alumnos nacidos en las provincias cuyos códigos estén comprendidos
entre 3 y 7.
*/
select *
from alumno
where nacido_en between 3 and 7;

--alternativa
select *
from alumno
where nacido_en >=3 
and nacido_en <=7;

/*8. Mostrar los profesores nacidos en alguna de estas provincias: 1, 3, 5, 7.*/
select *
from profesor
where nacido_en in (1,3, 5,7);

/*9. Mostrar los alumnos nacidos entre el 19/02/1980 y el 20/07/1984.*/
select *
from alumno
where fecha_nac>='1980-02-19'
and fecha_nac<='1984-07-20';

--alternativa
select *
from alumno
where fecha_nac between '1980-02-19' and '1984-07-20';

--alternativa
select * from alumno 
where fecha_nac between '1980/02/19' and '1984/07/20';

/*10. Mostrar los registros de la tabla “Matriculado” del alumno 7.
*/
select * 
from matriculado 
where id_alum = 7;

/*11. Mostrar el nombre y apellidos de los alumnos mayores de 40 años*/

/*Comprobando con la fecha actual del sistema*/
select nombre, apellidos
from alumno
where datediff(curdate(),fecha_nac)/365 >40; 

--alternativa
/*Extrayendo el año*/
select nombre, apellidos
from alumno
where extract(year from fecha_nac)<'1982';
/*Más información sobre las fechas en https://www.w3schools.com/sql/func_mysql_adddate.asp*/

/*12. Mostrar aquellos alumnos cuyo DNI contenga la letra ‘Y’.*/
select *
from alumno
where dni like '%Y';

/*13. Mostrar aquellos alumnos cuyo nombre empiece por ‘S’.
*/
select *
from alumno
where nombre like 'S%';

/*14. Mostrar el nombre de aquellos alumnos cuyo nombre contenga la letra ‘n’, ya sea
mayúscula o minúscula.
*/
select *
from alumno
where lower(nombre) like lower('%n%');
--alernativa 1
select *
from alumno
where upper(nombre) like upper('%N%');

--alternativa2
select *
from alumno
where nombre like '%n%' or nombre like '%N%';

/*15. Mostrar el nombre de aquellos alumnos cuyo apellido contenga la letra ‘z’, mayúscula
o minúscula*/
select nombre
from alumno
where apellidos like '%z%' or nombre like '%Z%';

---las mismas alternativas que en el apartado 14

/*16.Mostrar aquellos alumnos que tengan por primer nombre “Manuel”.*/
select *
from alumno
where nombre like 'Manuel%';

/*17. Mostrar aquellos alumnos que se llamen “Manuel” o “Cristina”.*/
select *
from alumno
where nombre like 'Manuel' or nombre like 'Cristina';
--alternativa
select *
from alumno
where nombre in ('Manuel','Cristina');
/* La alternativa es válida si es un único nombre y no haya que tener en cuenta
mayúscula o minúsculas.
Si tuviéramos que buscar por ejemplo por nombres completos 
select *
from alumno
where nombre like '%Manuel%' or nombre like '%Cristina%';*/
/*18. Mostrar los datos de los alumnos cuyo DNI empiece por 2.
*/
select * 
from alumno
where dni like '2%';

/*19. Mostrar los identificadores de provincia en las que han nacido los alumnos, sin que
estos identificadores se repitan.
*/
select DISTINCT nacido_en
from alumno;

/*20. Mostrar la tabla de “Matriculado” y añadir una columna más que sea la media de las
tres notas de cada alumno, ordenados de la mejor nota a la peor.
*/
select matriculado.*, (nota1+nota2+nota3)/3 as Promedio
from matriculado
order by Promedio desc;

/*21. Mostrar los registros de la tabla “Matriculado” en los que un alumno haya superado
los 3 exámenes de la asignatura 1.
*/
select *
from matriculado
where id_asig=1
and nota1>=5
and nota2>=5
and nota3>=5;


/*22. Mostrar los registros de la tabla “Matriculado” en los que un alumno haya sacado un
10 en alguna de las 3 notas en cualquier asignatura.
*/
select *
from matriculado
where nota1=10
or nota2=10
or nota3=10;

---alternativa
select *
from matriculado
where 10 in(nota1, nota2, nota3);

/*23. Mostrar aquellos registros de la tabla “Matriculado” 
en los que un alumno haya
superado alguno de los 3 exámenes de la asignatura 2.*/
select *
from matriculado
where id_asig=2
and (nota1>=5 or nota2>=5 or nota3>=5);

/*24. Mostrar los registros de la tabla “Matriculado” en los que un 
alumno haya superado el
primer examen ordenando los registros por “nota2” y “nota3” 
de menor a mayor para
ambos campos*/

select *
from matriculado
where nota1>=5
order by nota2, nota3;

---alternativa
select * 
from matriculado
where nota1>=5 
order by nota2 asc, nota3 asc;

--alternativa
select * 
from matriculado
where nota1>=5 
order by nota2, nota3;

/*25. Mostrar aquellos alumnos nacidos en el 1985*/
select * 
from alumno
where year(fecha_nac)='1985';
--alternativa
select *
from alumno
where extract(year from fecha_nac)='1985';
--alternativa
select *
from alumno
where fecha_nac between ('1985-01-01' and '1985-12-31');
--alternativa no recomendable
select *
from alumno
where fecha_nac like '1985%';

/*26. Mostrar los datos de los alumnos y además una columna 
calculada “mes” que
represente el mes en el que nació el alumno. 
Además se debe ordenar por dicha
columna.
*/
select id_alum, dni, nombre, apellidos, fecha_nac, nacido_en, month(fecha_nac) as Mes
from alumno
order by Mes;

--alternativa
select alumno.*, month(fecha_nac) as Mes
from alumno
order by Mes;
--alternativa
select alumno.*, extract(month from fecha_nac) as Mes
from alumno
order by Mes;

--alternativa que ordena alfabéticamente por el nombre del mes
select alumno.*, monthname(fecha_nac) as mes
from alumno
order by Mes;

/*27. Mostrar los datos de los alumnos y además una columna calculada 
“fecha_de_nacimiento” que represente el día en el que nació el alumno con el siguiente formato
“Nacido el día xx del xx de xxxx”.*/
select alumno.*, concat('Nacido el día ', day(fecha_nac),' del ', 
month(fecha_nac),' de ', year(fecha_nac)) as fecha_de_nacimiento
from alumno;

--alternativa
select *, concat('Nacido el día ', day(fecha_nac),' del ', 
month(fecha_nac),' de ', year(fecha_nac)) as fecha_de_nacimiento
from alumno;

---alternativa
select *, date_format(fecha_nac, 'Nacido el día %e de %M de %Y' )
as fecha_de_nacimiento
from alumno;


/*28. Mostrar el nombre, apellidos y la edad de los alumnos*/
select nombre, apellidos, timestampdiff(year, fecha_nac,curdate()) as edad
from alumno;

--alternativa con decimales
select nombre, apellidos, datediff(curdate(),fecha_nac)/365 as edad
from alumno;

--alternativa sin decimales
select nombre, apellidos, truncate(datediff(curdate(),fecha_nac)/365,0) as edad
from alumno;



--alternativa que no es exacta. Devulve un año más
select nombre, apellidos, year(curdate())-year(fecha_nac) as edad
from alumno;
/*29. Mostrar los datos de los alumnos y además una columna calculada 
“dias_vividos” que
represente los días que lleva vivido el alumno hasta la fecha de hoy.*/
select nombre, apellidos, 
datediff(curdate(),fecha_nac) as dias_vividos
from alumno;

--alternativa
select nombre, apellidos, 
datediff(now(),fecha_nac) as dias_vividos
from alumno;

--alternativa
select nombre, apellidos, 
truncate(datediff(curdate(),fecha_nac),0) as dias_vividos
from alumno;

/*30. Mostrar el nombre y apellidos de los 4 alumnos con mayor edad.
*/
select nombre, apellidos
from alumno
order by fecha_nac
limit 4;
/*31. Contar el número de alumnos que hay en el centro educativo.
*/
select count(*) as Num_alumnos
from alumno;

--alternativa
select count(id_alum) as Num_alumnos
from alumno;

/*32. Contar el número de profesores nacidos en la provincia 2 (Cádiz) 
que hay en el
centro educativo*/
select count(*) as Num_prof_Cadiz
from profesor
where nacido_en=2;

/*33. Mostrar la nota2 más alta de todas*/
select max(nota2)
from matriculado;
/*34. Mostrar la nota1 más baja de la asignatura 1 (Redes)*/
select min(nota1)
from matriculado
where id_asig=1;

/*35. Mostrar el sumatorio de todas las notas1 de la asignatura 1 (Redes)*/
select sum(nota1) 
from matriculado 
where id_asig=1;
/*36 Variante. Mostrar la suma de todas las notas1 fabricando una
columna llamada suma. Además se deben añadir 2 columnas 
más que se correspondan
con el número de notas1 existentes y con el valor de la nota media.
*/

select sum(nota1) as Suma, count(nota1) as Num_Notas1, avg(nota1) as Media
from matriculado;

/*36. Mostrar la suma de todas las notas1 de la asignatura 1 (Redes) fabricando una
columna llamada suma. Además se deben añadir 2 columnas más que se correspondan
con el número de notas1 existentes y con el valor de la nota media.*/

select sum(nota1) as Suma, count(nota1) as Num_Notas1, avg(nota1) as Media
from matriculado
where id_asig=1;









