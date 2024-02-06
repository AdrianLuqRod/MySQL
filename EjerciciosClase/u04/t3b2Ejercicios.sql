-- 1. Mostrar los salarios actuales de todos los empleados mostrando también su dni y nombre.
SELECT
    HS.SALARIO,
    EM.DNI,
    EM.NOMBRE
FROM
    EMPLEADOS EM
    JOIN HISTORIAL_SALARIAL HS ON EM.DNI = HS.EMP_DNI
WHERE
    FECHA_FIN IS NULL;

-- 2. Mostrar los dni y nombre de los empleados que han estudiado en la universidad de Sevilla.
SELECT
    DNI,
    NOMBRE
FROM
    EMPLEADOS EM
    -- 3. Mostrar para cada empleado(nombre) el maximo salario que ha llegado a tener.
SELECT
    NOMBRE,
    MAX(SALARIO)
FROM
    EMPLEADOS EM
    JOIN HISTORIAL_SALARIAL HS ON EM.DNI = HS.EMP_DNI;

-- 4. Mostrar para cada departamento el numero de empleados que tiene.
-- 5. Mostrar para cada departamento el numero de empleados que tiene
-- 6. Mostrar los dni, nombre de los empleados que han estudiado en la universidad de Sevilla. Mostrar también el nombre de su rttabajo actual.