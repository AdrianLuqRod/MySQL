DROP TABLE IF EXISTS ALUMNOS;

DROP TABLE IF EXISTS CURSOS;

DROP TABLE IF EXISTS PROFESORES;

CREATE TABLE
    PROFESORES(
        NOMBRE VARCHAR(15) UNIQUE,
        APELLIDO1 VARCHAR(15),
        APELLIDO2 VARCHAR(15),
        DNI INT(8) PRIMARY KEY,
        DIRECCION VARCHAR(50),
        TITULO VARCHAR(50),
        GANA DECIMAL (6, 2) NOT NULL
    );

CREATE TABLE
    CURSOS(
        NOMBRE_CURSO VARCHAR(50) UNIQUE,
        COD_CURSO INT(4) PRIMARY KEY,
        DNI_PROFESOR INT(8),
        MAXIMO_ALUMNOS INT(3),
        FECHA_INICIO DATE,
        FECHA_FIN DATE,
        NUM_HORAS INT(3) NOT NULL,
        CONSTRAINT profDni_fk Foreign Key (DNI_PROFESOR) REFERENCES PROFESORES(DNI) on delete cascade on update cascade,
        CONSTRAINT ordenFecha CHECK (FECHA_INICIO < FECHA_FIN)
    );

CREATE TABLE
    ALUMNOS(
        NOMBRE VARCHAR(15),
        APELLIDO1 VARCHAR(15),
        APELLIDO2 VARCHAR(15),
        DNI INT(8) PRIMARY KEY,
        DIRECCION VARCHAR(50),
        SEXO CHAR(1),
        FECHA_NACIMIENTO DATE,
        CURSO INT(4) NOT NULL,
        CONSTRAINT alumnoCurso_fk Foreign Key (CURSO) REFERENCES CURSOS(COD_CURSO) on delete cascade on update cascade,
        CONSTRAINT chk_sexo CHECK (SEXO = 'H' || SEXO = 'M')
    );

-- EX02 // INSERTAR LAS SIGUIENTES TUPLAS

INSERT INTO PROFESORES
VALUES (
        'Juan',
        'Arch',
        'Lopez',
        32432455,
        'Puerta Negra, 4',
        'Ing. Informatica',
        7500
    );

INSERT INTO PROFESORES
VALUES (
        'Maria',
        'Oliva',
        'Rubio',
        43215643,
        'Juan Alfonso 32',
        'Lda. Fil. Inglesa',
        5400
    );

INSERT INTO CURSOS
VALUES (
        'Ingles Basico',
        1,
        43215643,
        15,
        '2000-11-01',
        '2000-12-22',
        120
    );

INSERT INTO CURSOS
VALUES (
        'Administracion Linux',
        2,
        32432455,
        NULL,
        '2000-09-01',
        NULL,
        101
    );

INSERT INTO ALUMNOS
VALUES (
        'Lucas',
        'Manilva',
        'Lopez',
        12353,
        'Alhamar 3',
        'H',
        '1979-11-01',
        1
    );

INSERT INTO ALUMNOS
VALUES (
        'Antonia',
        'Lopez',
        'Alcantara',
        2567567,
        'Maniqui 21',
        'M',
        NULL,
        2
    );

INSERT INTO ALUMNOS
VALUES (
        'Manuel',
        'Alcantara',
        'Pedros',
        3123689,
        'Julian 2',
        NULL,
        NULL,
        2
    );

INSERT INTO ALUMNOS
VALUES (
        'Jose',
        'Perez',
        'Caballar',
        4896765,
        'Jarcha 5',
        'H',
        '1979-11-01',
        1
    );

-- EX03 INSERTAR SIGUIENTE TUPLA

INSERT INTO ALUMNOS
VALUES (
        'Sergio',
        'Navas',
        'Retal',
        123523,
        NULL,
        'H',
        NULL,
        1
    );

-- Añadimos el campo edad a la tabla profesores.

ALTER TABLE PROFESORES ADD EDAD INT(2);

-- 5a)

ALTER TABLE PROFESORES ADD CONSTRAINT chk_edad1 CHECK (EDAD >= 18);

ALTER TABLE PROFESORES ADD CONSTRAINT chk_edad2 CHECK (EDAD <= 65);

-- 5b)

ALTER TABLE CURSOS
ADD
    CONSTRAINT chk_numMaxAlum CHECK (MAXIMO_ALUMNOS >= 10);

-- 5c)

ALTER TABLE CURSOS
ADD
    CONSTRAINT chk_numHoras CHECK (NUM_HORAS >= 100);

-- 6)

ALTER TABLE ALUMNOS DROP CONSTRAINT chk_sexo;

-- 8)

ALTER TABLE PROFESORES MODIFY GANA DECIMAL(6, 2) NULL;

-- 9)

ALTER TABLE CURSOS MODIFY FECHA_INICIO DATE NOT NULL;

-- CAMBIAR CLAVE PRIMARIA

ALTER TABLE CURSOS DROP CONSTRAINT profDni_fk;

ALTER TABLE
    PROFESORES DROP PRIMARY KEY,
ADD
    PRIMARY KEY (NOMBRE, APELLIDO1, APELLIDO2);

INSERT INTO PROFESORES
VALUES (
        'Pepe',
        'Arch',
        'Lopez',
        32432455,
        'Puerta Negra,4',
        'Ing Informatica',
        NULL,
        20
    );

INSERT INTO ALUMNOS
VALUES (
        'Maria',
        'Jaen',
        'Sevilla',
        789678,
        'Martos 5',
        'M',
        '1977-03-10',
        1
    );

-- CAMBIAR FECHA

UPDATE ALUMNOS
SET
    FECHA_NACIMIENTO = '1976-12-23'
WHERE DNI = 789678;

UPDATE ALUMNOS SET CURSO = 1 WHERE DNI = 2567567;