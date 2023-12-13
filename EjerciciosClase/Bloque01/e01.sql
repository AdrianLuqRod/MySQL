DROP TABLE IF EXISTS ALUMNOS;

DROP TABLE IF EXISTS CURSOS;

DROP TABLE IF EXISTS PROFESORES;

/* Tabla profesores */

CREATE TABLE
    PROFESORES (
        NOMBRE VARCHAR(15) UNIQUE,
        APELLIDO1 VARCHAR(15),
        APELLIDO2 VARCHAR(15),
        DNI INT(8),
        DIRECCION VARCHAR(50),
        TITULO VARCHAR(50),
        GANA DECIMAL(6, 2) NOT NULL,
        CONSTRAINT prof_pk PRIMARY KEY (DNI)
    );

/* Tabla cursos */

CREATE TABLE
    CURSOS (
        NOMBRE_CURSO VARCHAR(50) UNIQUE,
        COD_CURSO INT (4) PRIMARY KEY,
        DNI_PROFESOR INT(8),
        MAXIMO_ALUMNOS INT (2),
        FECHA_INICIO DATE,
        FECHA_FIN DATE,
        NUM_HORAS INT (3) NOT NULL,
        CHECK (FECHA_INICIO < FECHA_FIN),
        CONSTRAINT fk_profDni Foreign Key (DNI_PROFESOR) REFERENCES PROFESORES(DNI)
    );

/* Tabla alumnos */

CREATE TABLE
    ALUMNOS (
        NOMBRE VARCHAR(15),
        APELLIDO1 VARCHAR(15),
        APELLIDO2 VARCHAR(15),
        DNI INT (8) PRIMARY KEY,
        DIRECCION VARCHAR(50),
        SEXO CHAR(1),
        FECHA_NACIMIENTO DATE,
        CURSO INT (4) NOT NULL,
        Foreign Key (CURSO) REFERENCES CURSOS (COD_CURSO),
        CONSTRAINT chk_sexo CHECK (SEXO = 'H' || SEXO = 'M')
    );

/* EX02 -- INSERTAR LAS SIGUIENTES TUPLAS */

/* Las tildes causan errores, introducimos todos los INSERT sin tildes */

/* INSERT INTO PROFESORES VALUES('Juan','Arch','López',32432455,'Puerta Negra, 4', 'Ing. Informática', 7500); */

INSERT INTO PROFESORES
VALUES (
        'Juan',
        'Arch',
        'Lopez',
        32432455,
        'Puerta Negra, 4',
        'Ing. Informatica',
        7500
    ), (
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
    ), (
        'Administracion Linux',
        2,
        32432455,
        NULL,
        '2000-09-01',
        NULL,
        101
    );

/* El INSERT siguiente da error porque el sexo solo puede ser 'H' o 'M', por ende hay que cambiarlo a una de esas 2 letras para que funciona. */

/* INSERT INTO ALUMNOS
 VALUES
 (
 'Lucas',
 'Manilva',
 'Lopez',
 123523,
 'Alhamar 3',
 'V',
 '1979-11-01',
 1
 ); */

/* Voy a cambiarlo a 'H'  */

INSERT INTO ALUMNOS
VALUES (
        'Lucas',
        'Manilva',
        'Lopez',
        123523,
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
        256767,
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
        32132689,
        'Julian 2',
        NULL,
        NULL,
        2
    );

/* El INSERT siguiente da error porque el sexo solo puede ser 'H' o 'M', por ende hay que cambiarlo a una de esas 2 letras para que funciona. */

/* INSERT INTO ALUMNOS
 VALUES (
 'Jose',
 'Perez',
 'Caballar',
 4896765,
 'Jarcha 5',
 'V',
 '1977-02-03',
 1
 ); */

/* Voy a cambiarlo a 'H' */

INSERT INTO ALUMNOS
VALUES (
        'Jose',
        'Perez',
        'Caballar',
        4896765,
        'Jarcha 5',
        'M',
        '1977-02-03',
        1
    );

/* EX03 -- INSERTAR LA SIGUIENTE TUPLA */

/* INSERT INTO ALUMNOS
 VALUES
 (
 'Sergio',
 'Navas',
 'Retal',
 123523,
 NULL,
 'P',
 NULL,
 NULL
 ); */

/* En esta tupla la columna curso es NULL, lo que va en contra de las restricciones creadas para esta propia tabla. */

/* Para solucionarlo, le asignamos un valor a curso( Siempre y cuando este valor este contenido dentro de la propia tabla cursos.) */

/* INSERT INTO ALUMNOS
 VALUES (
 'Sergio',
 'Navas',
 'Retal',
 123523,
 NULL,
 'P',
 NULL,
 1
 ); */

/* De nuevo da un error ya que la restriccion de sexo ya creada solo permite que el valor de esta columna sea 'H' o 'M'.
 Como es 'P' le cambiamos el valor y le asignamos o bien 'H' o bien 'M' */

/* INSERT INTO ALUMNOS
 VALUES (
 'Sergio',
 'Navas',
 'Retal',
 123523,
 NULL,
 'H',
 NULL,
 1
 ); */

/* Da otro fallo ya que el DNI solo puede ser unico al ser la PK de esta tabla.
 Para corregirlo cambiamos el valor de DNI a otro para que no haga conflicto con los ya existentes. */

INSERT INTO ALUMNOS
VALUES (
        'Sergio',
        'Navas',
        'Retal',
        113523,
        NULL,
        'H',
        NULL,
        1
    );

/* EX04 -- AÑADIR EL CAMPO EDAD DE TIPO NUMERICO A LA TABLA PROFESORES. */

ALTER TABLE PROFESORES ADD COLUMN (EDAD INT(3));

/* EX05 -- AÑADIR LAS SIGUIENTES RESTRICCIONES. */

/* a) EDAD PROFESOR ENTRE 18-65 AÑOS */

ALTER TABLE PROFESORES
ADD
    CONSTRAINT chk1_EDAD CHECK (EDAD >= 18);

ALTER TABLE PROFESORES
ADD
    CONSTRAINT chk2_EDAD CHECK (EDAD <= 65);

/* b) NO SE PUEDE AÑADIR UN CURSO SI SU NUMERO DE ALUMNOS MAXIMO ES MENOR QUE 10 */

ALTER TABLE CURSOS
ADD
    CONSTRAINT chk_numMaxAlum CHECK (MAXIMO_ALUMNOS >= 10);

/* c) EL NUMERO DE HORAS DE LOS CURSOS DEBE SER MAYOR QUE 100 */

ALTER TABLE CURSOS
ADD
    CONSTRAINT chk_numHoras CHECK (NUM_HORAS > 100);

/* Este alter da fallo porque hay un curso que tiene un numero inferior a 100 horas(Administracion Linux).
 Para solucionarlo cambiamos el valor de ese numero a uno que sea mayor que 100.(Lo cambio en el propio INSERT de la linea 76-93) */

/* EX06 -- ELIMINA LA RESTRICCION QUE CONTROLA LOS VALORES PERMITIDOS PARA EL ATRIBUTO SEXO */

ALTER TABLE ALUMNOS DROP CONSTRAINT chk_sexo;

/* EX07 -- Se dice que cada alumno ha de estar matriculado en un solo curso. ¿Esto quiere decir que el
 atributo CURSO de la tabla ALUMNOS ha de ser UNIQUE? Pruebe a introducir la
 restricción y ver si confirma esta hipótesis. */

/* ALTER TABLE ALUMNOS ADD CONSTRAINT chk_cursoUnico UNIQUE (CURSO); */

/* Da error 'Duplicate entry 1 for key chk_cursoUnico'.
 Podemos sacar la conclusion de que no, el hecho de que cada alumno tenga que estar matriculado en un solo curso no quiere decir que
 el atributo CURSO de la tabla ALUMNOS tenga que se UNIQUE, porque pueden existir varios alumnos que cursen un mismo CURSO y por ende
 tengan el mismo valor de CURSO en la tabla ALUMNOS.*/

/* EX08 -- ELIMINAR LA RESTRICCION DE TIPO NOT NULL DEL ATRIBUTO GANA*/

ALTER TABLE PROFESORES MODIFY GANA DECIMAL(6, 2) NULL;

/* EX09 -- INSERTAR RESTRICCION NO NULA EN EL CAMPO FECHA_INICIO DE CURSOS */

ALTER TABLE CURSOS MODIFY FECHA_INICIO DATE NOT NULL;

/* EX10 -- CAMBIAR LA CLAVE PRIMARIA DE PROFESOR AL NOMBRE Y APELLIDOS */

ALTER TABLE CURSOS DROP FOREIGN KEY fk_profDni;

ALTER TABLE
    PROFESORES DROP PRIMARY KEY,
ADD
    PRIMARY KEY (NOMBRE, APELLIDO1, APELLIDO2);

/* EX11 -- INSERTAR LAS SIGUIENTES TUPLA EN ALUMNOS */

/* INSERT INTO ALUMNOS
 VALUES
 (
 'Juan',
 'Arch',
 'Lopez',
 32432455,
 'Puerta Negra, 4',
 'Ing. Informatica',
 NULL
 ); */

/* Da error porque no coinciden las columnas, se esta insertando en la tabla ALUMNOS unos valores que no coinciden, de hecho, son las columnas
 de la tabla PROFESORES. Para solucionarlo podemos optar por añadirlo en la tabla profesores en lugar de la tabla alumnos. */

/* INSERT INTO PROFESORES
 VALUES (
 'Juan',
 'Arch',
 'Lopez',
 32432455,
 'Puerta Negra, 4',
 'Ing. Informatica',
 NULL
 ); */

/* Vuelve a dar error porque en un apartado anterior asignamos la columna EDAD, para solucionarlo damos un valor a esta columna. */

/* INSERT INTO PROFESORES
 VALUES (
 'Juan',
 'Arch',
 'Lopez',
 32432455,
 'Puerta Negra, 4',
 'Ing. Informatica',
 NULL,
 35
 ); */

/* Da otro error porque hemos cambiado la primary key de PROFESORES a NOMBRE,AP1,AP2 y como tienen lo mismo da error.
 Para solucionarlo cambiamos cualquier valor de estos parametros */

INSERT INTO PROFESORES
VALUES (
        'Pepe',
        'Arch',
        'Lopez',
        32432455,
        'Puerta Negra, 4',
        'Ing. Informatica',
        NULL,
        35
    );

/* INSERT INTO ALUMNOS
 VALUES
 (
 'Maria',
 'Jaen',
 'Sevilla',
 789678,
 'Martos 5',
 'M',
 '1977-03-10',
 3
 ); */

/* Este INSERT da error porque si nos fijamos, estamos intentado establecer a ese alumno un codigo de curso inexsistente.
 El codigo del curso es fk en la tabla ALUMNOS de la tabla CURSOS. Teniendo esto en cuenta, si la tabla CURSOS en su pk que es
 COD_CURSO solo estan registrados el valor 1 y 2, en la tabla alumnos no podemos insertar el valor '3', porque no existe.
 Para arreglarlo insertamos el valor '1' o '2' en el codigo de curso */

/* INSERT INTO ALUMNOS
 VALUES
 (
 'Maria',
 'Jaen',
 'Sevilla',
 789678,
 'Martos 5',
 'M',
 '1977-03-10',
 2
 ); */

/* Vuelve a dar error porque ya hay un DNI igual existente, recordemos que el dni en la tabla ALUMNOS es PK, por ende debe ser unico.
 Para solventar esto podemos cambiar el valor del DNI que vamos a insertar. */

INSERT INTO ALUMNOS
VALUES (
        'Maria',
        'Jaen',
        'Sevilla',
        7896782,
        'Martos 5',
        'M',
        '1977-03-10',
        2
    );

/* EX12 -- LA FECHA DE NACIMIENTO DE ANTONIA LOPEZ ESTA EQUIVOCADA. LA VERDADERA ES 23 DE DICIEMBRE DE 1976 */

UPDATE ALUMNOS
SET
    FECHA_NACIMIENTO = '1976-12-23'
WHERE DNI = 256767;

/* EX13 -- CAMBIAR A ANTONIOA LOPEZ AL CURSO DE CODIGO 5 */

/* UPDATE ALUMNOS SET CURSO = 5 WHERE DNI = 256767; */

/* Este update da error ya que, al igual que antes, estamos intentando asignar un valor de curso inexsistente en un alumno. 
 Para solucionarlo, o bien creamos un nuevo codigo de curso con todas sus propiedades necesarias, o bien le asignamos otro valor de curso
 ya existente en el UPDATE. Teniendo en cuenta que ya esta en el curso '2', le asignamos el valor de curso '1' */

UPDATE ALUMNOS SET CURSO = 1 WHERE DNI = 256767;

/* EX14 -- ELIMINAR LA PROFESORA LAURA JIMENEZ */

DELETE FROM PROFESORES
WHERE
    NOMBRE = 'Laura'
    AND APELLIDO1 = 'Jimenez';

/* Al no existir una regla referencial, se permite el borrado. */

/* EX15 -- NO SE HACE!!!!!!!!!!!!! */

/* EX16 -- BORRAR LAS TABLAS */

DROP TABLE ALUMNOS;

DROP TABLE CURSOS;

DROP TABLE PROFESORES;

/* El orden de borrado de las tablas no es aleatorio, hay que hacerlo en funcion de como esten conectadas entre ellas.
 Como la tabla ALUMNOS es dependiente de CURSOS, la debemos borrar antes que ésta para no crear errores a la hora de borrar las tablas.
 Estos errores también se podrían evitar si actualizasemos las fk de las tablas y las pusiesemos con ON DELETE CASCADE pero como no es
 el caso, hay que tener cuidado con el orden. Una vez borrado la tabla ALUMNOS, podemos borrar la tabla CURSOS, que es dependiente de 
 PROFESORES, y al final podemos borrar la tabla PROFESORES ya que no es dependiente de ninguna de las tablas existentes. */