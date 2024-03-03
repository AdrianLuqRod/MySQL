drop table ventas;

drop table proyecto;

drop table pieza;

drop table proveedor;

CREATE TABLE
    proveedor (
        codpro VARCHAR(3),
        nompro VARCHAR(30) NOT NULL,
        status INT,
        ciudad VARCHAR(15),
        constraint codpro_pk PRIMARY KEY (codpro),
        CONSTRAINT status_chk CHECK (
            status >= 1
            AND status <= 10
        )
    );

CREATE TABLE
    pieza (
        codpie VARCHAR(3),
        nompie VARCHAR(10) NOT NULL,
        color VARCHAR(10),
        peso DECIMAL(5, 2),
        ciudad VARCHAR(15),
        CONSTRAINT codpie_pk PRIMARY KEY (codpie),
        CONSTRAINT peso_chk CHECK (
            peso > 0
            AND peso <= 100
        )
    );

CREATE TABLE
    proyecto (
        codpj VARCHAR(3),
        nompj VARCHAR(20) NOT NULL,
        ciudad VARCHAR(15),
        CONSTRAINT codpj_pk PRIMARY KEY (codpj)
    );

CREATE TABLE
    ventas (
        codpro VARCHAR(3),
        codpie VARCHAR(3),
        codpj VARCHAR(3),
        cantidad INT (4),
        CONSTRAINT clave_pk PRIMARY KEY (codpro, codpie, codpj),
        CONSTRAINT codpro_fk FOREIGN KEY (codpro) REFERENCES proveedor (codpro),
        CONSTRAINT codpie_fk FOREIGN KEY (codpie) REFERENCES pieza (codpie),
        CONSTRAINT codpj_fk FOREIGN KEY (codpj) REFERENCES proyecto (codpj)
    );

INSERT INTO
    proveedor
VALUES
    ('S1', 'Jose Fernandez', 2, 'Madrid');

INSERT INTO
    proveedor
VALUES
    ('S2', 'Manuel Vidal', 1, 'Londres');

INSERT INTO
    proveedor
VALUES
    ('S3', 'Luisa Gomez', 3, 'Lisboa');

INSERT INTO
    proveedor
VALUES
    ('S4', 'Pedro Sanchez', 4, 'Paris');

INSERT INTO
    proveedor
VALUES
    ('S5', 'Maria Reyes', 5, 'Roma');

INSERT INTO
    pieza
VALUES
    ('P1', 'Tuerca', 'Gris', 2.5, 'Madrid');

INSERT INTO
    pieza
VALUES
    ('P2', 'Tornillo', 'Rojo', 1.25, 'Paris');

INSERT INTO
    pieza
VALUES
    ('P3', 'Arandela', 'Blanco', 3, 'Londres');

INSERT INTO
    pieza
VALUES
    ('P4', 'Clavo', 'Gris', 5.5, 'Lisboa');

INSERT INTO
    pieza
VALUES
    ('P5', 'Alcataya', 'Blanco', 10, 'Roma');

INSERT INTO
    proyecto
VALUES
    ('J1', 'Proyecto 1', 'Londres');

INSERT INTO
    proyecto
VALUES
    ('J2', 'Proyecto 2', 'Londres');

INSERT INTO
    proyecto
VALUES
    ('J3', 'Proyecto 3', 'Paris');

INSERT INTO
    proyecto
VALUES
    ('J4', 'Proyecto 4', 'Roma');

INSERT INTO
    ventas
VALUES
    ('S1', 'P1', 'J2', 100);

INSERT INTO
    ventas
VALUES
    ('S1', 'P1', 'J3', 500);

INSERT INTO
    ventas
VALUES
    ('S1', 'P2', 'J1', 200);

INSERT INTO
    ventas
VALUES
    ('S2', 'P2', 'J2', 15);

INSERT INTO
    ventas
VALUES
    ('S4', 'P2', 'J3', 1700);

INSERT INTO
    ventas
VALUES
    ('S1', 'P3', 'J1', 800);

INSERT INTO
    ventas
VALUES
    ('S5', 'P3', 'J2', 30);

INSERT INTO
    ventas
VALUES
    ('S1', 'P4', 'J1', 10);

INSERT INTO
    ventas
VALUES
    ('S1', 'P4', 'J3', 250);

INSERT INTO
    ventas
VALUES
    ('S2', 'P5', 'J2', 300);

INSERT INTO
    ventas
VALUES
    ('S2', 'P2', 'J1', 4500);

INSERT INTO
    ventas
VALUES
    ('S3', 'P1', 'J1', 90);

INSERT INTO
    ventas
VALUES
    ('S3', 'P2', 'J1', 190);

INSERT INTO
    ventas
VALUES
    ('S3', 'P5', 'J3', 20);

INSERT INTO
    ventas
VALUES
    ('S4', 'P5', 'J1', 15);

INSERT INTO
    ventas
VALUES
    ('S4', 'P1', 'J3', 1500);

INSERT INTO
    ventas
VALUES
    ('S1', 'P1', 'J1', 150);

INSERT INTO
    ventas
VALUES
    ('S1', 'P4', 'J4', 290);

INSERT INTO
    ventas
VALUES
    ('S1', 'P2', 'J4', 175);