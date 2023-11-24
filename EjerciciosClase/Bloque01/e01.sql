DROP TABLE IF EXISTS ALUMNOS;

DROP TABLE IF EXISTS CURSOS;

DROP TABLE IF EXISTS PROFESORES;

CREATE TABLE
    PROFESORES (
        DNI INT (8) PRIMARY KEY,
        NOMBRE VARCHAR(50) UNIQUE,
        APELLIDO1 VARCHAR(50),
        APELLIDO2 VARCHAR(50),
        DIRECCION VARCHAR(50),
        TITULO VARCHAR(50),
        GANA DECIMAL(7, 2) NOT NULL
    );

CREATE TABLE
    CURSOS (
        COD_CURSO INT PRIMARY KEY,
        NOMBRE_CURSO VARCHAR(50) UNIQUE,
        DNI_PROFESOR INT (8),
        MAXIMO_ALUMNOS INT,
        FECHA_INICIO DATE,
        FECHA_FIN DATE,
        NUM_HORAS INT NOT NULL,
        CHECK (FECHA_INICIO <= FECHA_FIN),
        FOREIGN KEY (DNI_PROFESOR) REFERENCES PROFESORES (DNI)
    );

CREATE TABLE
    ALUMNOS (
        DNI INT (8) PRIMARY KEY,
        NOMBRE VARCHAR(50),
        APELLIDO1 VARCHAR(50),
        APELLIDO2 VARCHAR(50),
        DIRECCION VARCHAR(50),
        SEXO CHAR(1) CHECK (SEXO IN ('M', 'H')),
        FECHA_NACIMIENTO DATE,
        CURSO INT NOT NULL,
        FOREIGN KEY (CURSO) REFERENCES CURSOS (COD_CURSO)
    );

INSERT INTO
    PROFESORES (
        NOMBRE,
        APELLIDO1,
        APELLIDO2,
        DNI,
        DIRECCION,
        TITULO,
        GANA
    )
VALUES
    (
        'Juan',
        'Arch',
        'Lopez',
        32432455,
        'Puerta Negra, 4',
        'Ing. Informática',
        7500
    ),
    (
        'Maria',
        'Oliva',
        'Rubio',
        43215643,
        'Juan Alfonso 32',
        'Lda. Fil. Inglesa',
        5400
    );

INSERT INTO
    CURSOS (
        NOMBRE_CURSO,
        COD_CURSO,
        DNI_PROFESOR,
        MAXIMO_ALUMNOS,
        FECHA_INICIO,
        FECHA_FIN,
        NUM_HORAS
    )
VALUES
    (
        'Ingles Básico',
        1,
        43215643,
        5,
        '2001-11-00',
        '2022-12-00',
        120
    ),
    (
        'Administración Linux',
        2,
        32432455,
        NULL,
        '2001-09-00',
        NULL,
        800
    );

INSERT INTO
    ALUMNOS (
        NOMBRE,
        APELLIDO1,
        APELLIDO2,
        DNI,
        DIRECCION,
        SEXO,
        FECHA_NACIMIENTO,
        CURSO
    )
VALUES
    (
        'Lucas',
        'Manilva',
        'López',
        123523,
        'Alhamar 3',
        'H',
        '1979-11-01',
        1
    ),
    (
        'Antonia',
        'López',
        'Alcantara',
        2567567,
        'Maniquí 21',
        'M',
        NULL,
        2
    ),
    (
        'Manuel',
        'Alcantara',
        'Pedrós',
        3123689,
        'Julian 2',
        NULL,
        NULL,
        2
    ),
    (
        'José',
        'Pérez',
        'Caballar',
        4896765,
        'Jarcha 5',
        'H',
        '77-02-03',
        1
    ),
    (
        'Sergio',
        'Navas',
        'Retal',
        1235233,
        NULL,
        'H',
        NULL,
        1
    );

ALTER TABLE PROFESORES ADD EDAD INT,
ADD CONSTRAINT CHECK_EDAD CHECK (EDAD BETWEEN 18 AND 65);

ALTER TABLE CURSOS ADD CONSTRAINT CHECK_NUM_HORAS CHECK (NUM_HORAS > 100);

ALTER TABLE ALUMNOS MODIFY COLUMN SEXO CHAR(1);

/* ALTER TABLE ALUMNOS MODIFY COLUMN CURSO INT UNIQUE; */
ALTER TABLE PROFESORES MODIFY COLUMN GANA INT;

ALTER TABLE CURSOS MODIFY COLUMN FECHA_INICIO DATE NOT NULL;

ALTER TABLE CURSOS
DROP FOREIGN KEY cursos_ibfk_1;

ALTER TABLE PROFESORES
DROP PRIMARY KEY,
ADD PRIMARY KEY (NOMBRE, APELLIDO1, APELLIDO2);

ALTER TABLE CURSOS
DROP COLUMN DNI_PROFESOR,
ADD COLUMN NOMBRE_PROFESOR VARCHAR(50),
ADD COLUMN APELLIDO1_PROFESOR VARCHAR(50),
ADD COLUMN APELLIDO2_PROFESOR VARCHAR(50),
ADD CONSTRAINT Foreign Key (
    NOMBRE_PROFESOR,
    APELLIDO1_PROFESOR,
    APELLIDO2_PROFESOR
) REFERENCES PROFESORES (NOMBRE, APELLIDO1, APELLIDO2);

/* INSERT INTO
ALUMNOS(
NOMBRE,
APELLIDO1,
APELLIDO2,
DNI,
DIRECCION,
TITULO,
GANA
)
VALUES
(
'Juan',
'Arch',
'López',
'32432455',
'Puerta Negra, 4',
'Ing. Informática',
NULL
) */
-- INSERT INTO
--     ALUMNOS(
--         NOMBRE,
--         APELLIDO1,
--         APELLIDO2,
--         DNI,
--         DIRECCION,
--         SEXO,
--         FECHA_NACIMIENTO,
--         CURSO
--     )
-- VALUES (
--         'Maria',
--         'Jaén',
--         'Sevilla',
--         '789678',
--         'Martos 5',
--         'H',
--         '1977-03-10',
--         '3'
--     );

UPDATE ALUMNOS
SET FECHA_NACIMIENTO='1976-12-23', CURSO=1
WHERE NOMBRE='ANTONIA'
AND APELLIDO='LOPEZ';

-- DELETE FROM PROFESORES
-- WHERE NOMBRE='LAURA'
-- AND APELLIDO='JIMENEZ';



