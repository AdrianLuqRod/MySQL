DROP DATABASE u04b4 EXISTS;

CREATE DATABASE u04b4;

USE u04b4;

create table SOCIO (
    num_socio CHAR(4) PRIMARY KEY, nombre VARCHAR(20), apellido1 VARCHAR(20), apellido2 VARCHAR(20), telefono CHAR(9), domicilio VARCHAR(40), poblacion VARCHAR(20), fec_nac DATE
);

create table PELICULA (
    codigo CHAR(4) PRIMARY KEY, titulo VARCHAR(50), duracion INTEGER(3), anyo CHAR(4), genero VARCHAR(20), precio_alquiler DECIMAL(4, 2)
);

create table COPIA_PELICULA (
    id_copia CHAR(3) PRIMARY KEY, estado VARCHAR(10), observacion VARCHAR(300), pelicula CHAR(4), CONSTRAINT FK_cp_p FOREIGN KEY (pelicula) REFERENCES PELICULA (codigo) ON DELETE CASCADE
);

create table ALQUILER (
    copia_pel CHAR(3), socio CHAR(4), fec_alquila DATE, fec_devolucion DATE, CONSTRAINT alquiler_PK PRIMARY KEY (copia_pel, socio, fec_alquila), CONSTRAINT fk_a_cp FOREIGN KEY (copia_pel) REFERENCES COPIA_PELICULA (id_copia) ON DELETE CASCADE, CONSTRAINT fk_a_s FOREIGN KEY (socio) REFERENCES SOCIO (num_socio) ON DELETE CASCADE
);

insert into
    SOCIO
values (
        '1001', 'Pedro', 'Gutierrez', 'Solero', '950333222', 'C/Gran Via, 33', 'Roquetas de Mar', '1970/11/16'
    );

insert into
    SOCIO
values (
        '1002', 'Maria', 'Lopez', 'Lopez', '65565565', 'C/Nicaragua, 4', 'Aguadulce', '1981/05/22'
    );

insert into
    SOCIO
values (
        '1003', 'Ruben', 'Danco', 'Romero', '950033022', 'C/Violeta, 3', 'Aguadulce', '1985/02/02'
    );

insert into
    SOCIO
values (
        '1004', 'Jesus', 'Estevan', 'Diaz', '950342342', 'Plaza Central, 17', 'Roquetas de Mar', '1972/01/30'
    );

insert into
    SOCIO
values (
        '1005', 'Lucia', 'Cerros', 'Pla', '611222333', 'C/Comercio, 22', 'Roquetas de Mar', '1992/12/07'
    );

insert into
    SOCIO
values (
        '1006', 'Marga', 'Jimenez', 'Ganga', '744222333', 'C/Mercado, 178', 'El Parador', '1995/10/20'
    );

insert into
    PELICULA
values (
        'CRS', 'Cars2: Una aventura de espias', 106, 2011, 'Animacion', 2.50
    );

insert into
    PELICULA
values (
        'FRZ', 'Frozen: El reino del hielo', 102, 2013, 'Animacion', 2.50
    );

insert into
    PELICULA
values (
        'MPS', 'Lo imposible', 107, 2012, 'Drama', 2.00
    );

insert into
    PELICULA
values (
        'HBB', 'El Hobbit: La batalla de los cinco ejercitos', 160, 2014, 'Aventura', 3.00
    );

insert into
    PELICULA
values (
        'BGH', 'Big Hero 6', 108, 2014, 'Animacion', 3.00
    );

insert into
    PELICULA
values (
        'NCH', 'Noche en el museo: El secreto del Faraon', 97, 2014, 'Aventura', 3.00
    );

insert into
    PELICULA
values (
        'HRL', 'Ahora los padres son ellos', 98, 2010, 'Comedia', 3.00
    );

insert into
    PELICULA
values (
        'LRF', 'El Orfanato', 100, 2007, 'Terror', 1.50
    );

insert into
    COPIA_PELICULA
values (
        '101', 'FUNCIONA', NULL, 'CRS'
    );

insert into
    COPIA_PELICULA
values (
        '102', 'FUNCIONA', NULL, 'CRS'
    );

insert into
    COPIA_PELICULA
values (
        '103', 'FUNCIONA', NULL, 'FRZ'
    );

insert into
    COPIA_PELICULA
values (
        '104', 'ESTROPEADA', 'Rayado', 'FRZ'
    );

insert into
    COPIA_PELICULA
values (
        '105', 'FUNCIONA', NULL, 'MPS'
    );

insert into
    COPIA_PELICULA
values (
        '106', 'FUNCIONA', NULL, 'HBB'
    );

insert into
    COPIA_PELICULA
values (
        '107', 'FUNCIONA', NULL, 'HBB'
    );

insert into
    COPIA_PELICULA
values (
        '108', 'FUNCIONA', NULL, 'BGH'
    );

insert into
    COPIA_PELICULA
values (
        '109', 'FUNCIONA', NULL, 'BGH'
    );

insert into
    COPIA_PELICULA
values (
        '110', 'FUNCIONA', NULL, 'NCH'
    );

insert into
    COPIA_PELICULA
values (
        '111', 'ESTROPEADA', 'Disco sucio', 'NCH'
    );

insert into
    COPIA_PELICULA
values (
        '112', 'FUNCIONA', NULL, 'HRL'
    );

insert into
    COPIA_PELICULA
values (
        '113', 'PERDIDA', 'No devuelta', 'LRF'
    );

insert into
    ALQUILER
values (
        '113', '1001', '2014/10/09', '2014/10/10'
    );

insert into
    ALQUILER
values (
        '112', '1001', '2014/11/29', '2014/11/30'
    );

insert into
    ALQUILER
values (
        '108', '1001', '2014/12/01', '2014/12/03'
    );

insert into
    ALQUILER
values (
        '101', '1001', '2014/11/28', '2014/11/29'
    );

insert into
    ALQUILER
values (
        '103', '1002', '2014/11/29', '2014/11/30'
    );

insert into
    ALQUILER
values (
        '106', '1002', '2014/12/07', '2014/12/10'
    );

insert into
    ALQUILER
values (
        '107', '1003', '2014/11/28', '2014/11/29'
    );

insert into
    ALQUILER
values (
        '109', '1003', '2014/11/15', '2014/11/16'
    );

insert into
    ALQUILER
values (
        '104', '1004', '2014/11/29', '2014/11/30'
    );

insert into
    ALQUILER
values (
        '109', '1004', '2014/12/28', '2014/12/29'
    );

insert into
    ALQUILER
values (
        '107', '1005', '2014/11/28', '2014/11/29'
    );

insert into
    ALQUILER
values (
        '113', '1006', '2014/10/16', NULL
    );

insert into
    ALQUILER
values (
        '110', '1006', '2014/10/01', '2014/10/04'
    );

insert into
    ALQUILER
values (
        '112', '1006', '2014/10/01', '2014/10/04'
    );

insert into
    ALQUILER
values (
        '102', '1005', '2014/11/24', '2014/11/25'
    );

insert into
    ALQUILER
values (
        '107', '1005', '2014/12/05', '2014/12/06'
    );

insert into
    ALQUILER
values (
        '111', '1005', '2014/11/13', '2014/11/14'
    );

insert into
    ALQUILER
values (
        '104', '1005', '2014/12/01', '2014/12/02'
    );