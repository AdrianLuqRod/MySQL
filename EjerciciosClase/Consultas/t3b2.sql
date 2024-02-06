-- conectar con el servidor
-- mysql -u root -p
/*  BOLETÍN 2: DATOS DE EMPLEADOS DE UNA EMPRESA */
/*  CREACIÓN DE LA BASE DE DATOS*/
--CREATE DATABASE boletin2;
--USE boletin2;
/* CREACIÓN DE TABLAS */
CREATE TABLE
    empleados (
        dni INT (8),
        nombre VARCHAR(10) NOT NULL,
        apellido1 VARCHAR(15) NOT NULL,
        apellido2 VARCHAR(15),
        direcc1 VARCHAR(25),
        direcc2 VARCHAR(20),
        ciudad VARCHAR(20),
        municipio VARCHAR(30),
        cod_postal VARCHAR(5),
        sexo CHAR(1),
        fecha_nacimiento DATE,
        CONSTRAINT empl_pk PRIMARY KEY (dni),
        CONSTRAINT sexo_chk CHECK (sexo IN ('H', 'M'))
    );

CREATE TABLE
    universidad (
        univ_cod INT (5),
        nombre_univ VARCHAR(25) NOT NULL,
        ciudad VARCHAR(20),
        municipio VARCHAR(20),
        cod_postal VARCHAR(5),
        CONSTRAINT uni_pk PRIMARY KEY (univ_cod)
    );

CREATE TABLE
    trabajos (
        trab_cod INT (5),
        nombre_trab VARCHAR(20) NOT NULL UNIQUE,
        sal_min INT (5) NOT NULL,
        sal_max INT (5) NOT NULL,
        CONSTRAINT trab_pk PRIMARY KEY (trab_cod)
    );

CREATE TABLE
    departamentos (
        dpto_cod INT (5),
        nombre_dpto VARCHAR(30) NOT NULL UNIQUE,
        jefe INT (8),
        presupuesto INTEGER NOT NULL,
        pres_actual INTEGER,
        CONSTRAINT trab_pk PRIMARY KEY (dpto_cod),
        CONSTRAINT dpto_emp_fk FOREIGN KEY (jefe) REFERENCES empleados (dni) on update cascade on delete cascade
    );

CREATE TABLE
    estudios (
        emp_dni INT (8),
        universidad INT (5),
        anno INT (4),
        grado VARCHAR(20),
        especialidad VARCHAR(20),
        CONSTRAINT estudios_pk PRIMARY KEY (emp_dni, especialidad),
        CONSTRAINT est_emp_fk FOREIGN KEY (emp_dni) REFERENCES empleados (dni),
        CONSTRAINT est_uni_fk FOREIGN KEY (universidad) REFERENCES universidad (univ_cod)
    );

CREATE TABLE
    historial_laboral (
        emp_dni INT (8),
        trab_cod INT (5),
        fecha_inicio DATE NOT NULL,
        fecha_fin DATE,
        dpto_cod INT (5),
        supervisor_dni INT (8),
        CONSTRAINT hist_laboral_pk PRIMARY KEY (emp_dni, fecha_inicio),
        CONSTRAINT finff_chk CHECK (fecha_fin > fecha_inicio),
        CONSTRAINT hl_emp_fk FOREIGN KEY (emp_dni) REFERENCES empleados (dni),
        CONSTRAINT hl_dpto_fk FOREIGN KEY (dpto_cod) REFERENCES departamentos (dpto_cod),
        CONSTRAINT hl_sup_emp_fk FOREIGN KEY (supervisor_dni) REFERENCES empleados (dni),
        CONSTRAINT hl_trab_fk FOREIGN KEY (trab_cod) REFERENCES trabajos (trab_cod)
    );

CREATE TABLE
    historial_salarial (
        emp_dni INT (8),
        salario INTEGER NOT NULL,
        fecha_comienzo DATE NOT NULL,
        fecha_fin DATE,
        CONSTRAINT hist_salarial_pk PRIMARY KEY (emp_dni, fecha_comienzo),
        CONSTRAINT finhs_chk CHECK (fecha_fin > fecha_comienzo),
        CONSTRAINT hs_emp_fk FOREIGN KEY (emp_dni) REFERENCES empleados (dni)
    );

INSERT INTO
    empleados
VALUES
    (
        11111111,
        'Juan',
        'Arch',
        'López',
        'Puerta Negra, 4',
        'Puerta Negra, 5',
        'Sevilla',
        'Sevilla',
        '41001',
        'H',
        '1980-01-01'
    );

INSERT INTO
    empleados
VALUES
    (
        22222222,
        'María',
        'García',
        'García',
        'Puerta Blanca, 1',
        'Puerta Blanca, 2',
        'Sevilla',
        'Sevilla',
        '41001',
        'M',
        '1981-02-02'
    );

INSERT INTO
    universidad
VALUES
    (
        11111,
        'Universidad 1',
        'Sevilla',
        'Sevilla',
        '41001'
    );

INSERT INTO
    universidad
VALUES
    (22222, 'Universidad 2', 'Cádiz', 'Cádiz', '11001');

INSERT INTO
    trabajos
VALUES
    (11111, 'Profesor', 34000, 39000);

INSERT INTO
    trabajos
VALUES
    (22222, 'Conserje', 18000, 24000);

INSERT INTO
    departamentos
VALUES
    (11111, 'Programación', 11111111, 10000, 5000);

INSERT INTO
    departamentos
VALUES
    (22222, 'Redes', 22222222, 8000, 4000);

INSERT INTO
    estudios
VALUES
    (11111111, 11111, 2000, 'sup', 'Informática');

INSERT INTO
    estudios
VALUES
    (22222222, 22222, 2001, 'sup', 'Informática');

INSERT INTO
    historial_laboral
VALUES
    (
        11111111,
        11111,
        '2002-09-01',
        '2005-08-31',
        11111,
        22222222
    );

INSERT INTO
    historial_laboral
VALUES
    (
        11111111,
        11111,
        '2006-09-01',
        '2016-08-31',
        11111,
        22222222
    );

INSERT INTO
    historial_salarial
VALUES
    (11111111, 34000, '2002-09-01', '2005-08-31');

INSERT INTO
    historial_salarial
VALUES
    (11111111, 35000, '2006-09-01', '2016-08-31');

INSERT INTO
    historial_salarial
VALUES
    (22222222, 3500, '2006-09-01', null);