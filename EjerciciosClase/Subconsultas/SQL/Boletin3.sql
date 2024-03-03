DROP TABLE MOVIMIENTO;

DROP TABLE TIPO_MOVIMIENTO;

DROP TABLE CUENTA;

DROP TABLE SUCURSAL;

DROP TABLE CLIENTE;

CREATE TABLE
    CLIENTE (
        COD_CLIENTE VARCHAR(20),
        APELLIDOS VARCHAR(50) NOT NULL,
        NOMBRE VARCHAR(30) NOT NULL,
        DIRECCION VARCHAR(50) NOT NULL,
        CONSTRAINT PK_CLIENTE PRIMARY KEY (COD_CLIENTE)
    );

CREATE TABLE
    SUCURSAL (
        COD_SUCURSAL INT (6),
        DIRECCION VARCHAR(50) NOT NULL,
        CAPITAL_ANIO_ANTERIOR DECIMAL(14, 2),
        CONSTRAINT PK_SUCURSAL PRIMARY KEY (COD_SUCURSAL)
    );

CREATE TABLE
    TIPO_MOVIMIENTO (
        COD_TIPO_MOVIMIENTO VARCHAR(6),
        DESCRIPCION VARCHAR(200),
        SALIDA VARCHAR(3),
        CONSTRAINT PK_TIPO_MOVIMIENTO PRIMARY KEY (COD_TIPO_MOVIMIENTO),
        CONSTRAINT CHK_SALIDA CHECK (
            SALIDA = 'Si'
            OR SALIDA = 'No'
        )
    );

CREATE TABLE
    CUENTA (
        COD_CUENTA INT (10),
        SALDO DECIMAL(10, 2) NOT NULL,
        INTERES DECIMAL(5, 4) NOT NULL,
        COD_CLIENTE VARCHAR(20),
        COD_SUCURSAL INT (6),
        CONSTRAINT PK_CUENTA PRIMARY KEY (COD_CUENTA),
        CONSTRAINT FK_CUENTA_CLIENTE FOREIGN KEY (COD_CLIENTE) REFERENCES CLIENTE (COD_CLIENTE),
        CONSTRAINT FK_CUENTA_SUCURSAL FOREIGN KEY (COD_SUCURSAL) REFERENCES SUCURSAL (COD_SUCURSAL),
        CONSTRAINT CHK_INTERES CHECK (INTERES < 1)
    );

CREATE TABLE
    MOVIMIENTO (
        COD_CUENTA INT (10),
        MES INT (2),
        NUM_MOV_MES INT (6),
        IMPORTE DECIMAL(12, 2) NOT NULL,
        FECHA_HORA TIMESTAMP NOT NULL,
        COD_TIPO_MOVIMIENTO VARCHAR(6),
        CONSTRAINT PK_MOVIMIENTO PRIMARY KEY (COD_CUENTA, MES, NUM_MOV_MES),
        CONSTRAINT FK_MOVIMIENTO_CUENTA FOREIGN KEY (COD_CUENTA) REFERENCES CUENTA (COD_CUENTA) ON DELETE CASCADE,
        CONSTRAINT FK_MOVIMIENTO_TIPO_MOVIMIENTO FOREIGN KEY (COD_TIPO_MOVIMIENTO) REFERENCES TIPO_MOVIMIENTO (COD_TIPO_MOVIMIENTO),
        CONSTRAINT CHK_MES CHECK (
            MES >= 1
            AND MES <= 12
        )
    );

INSERT INTO
    CLIENTE (cod_cliente, apellidos, nombre, direccion)
VALUES
    (
        'ARUBIO',
        'Rubio Caballero',
        'Ana',
        'C/ Colon, 10'
    );

INSERT INTO
    CLIENTE (cod_cliente, apellidos, nombre, direccion)
VALUES
    (
        'ASOTILLO',
        'Sotillo Roda',
        'Angeles',
        'C/ Donoso Cortes, 1'
    );

INSERT INTO
    CLIENTE (cod_cliente, apellidos, nombre, direccion)
VALUES
    (
        'CALONSO',
        'Alonso Cordero',
        'Carlos',
        'Ctra. De la Playa, 67'
    );

INSERT INTO
    CLIENTE (cod_cliente, apellidos, nombre, direccion)
VALUES
    (
        'CLUENGO',
        'Luengo Gomez',
        'Cristina',
        'C/ Lepanto, 17'
    );

INSERT INTO
    CLIENTE (cod_cliente, apellidos, nombre, direccion)
VALUES
    (
        'EPEREZ',
        'Perez Honda',
        'Eusebio',
        'Paseo Castellana, 230'
    );

INSERT INTO
    CLIENTE (cod_cliente, apellidos, nombre, direccion)
VALUES
    (
        'FSANTOS',
        'Santos Perez',
        'Fernando',
        'Avda. Juan Carlos I, 10'
    );

INSERT INTO
    CLIENTE (cod_cliente, apellidos, nombre, direccion)
VALUES
    (
        'IBUADES',
        'Buades Avaro',
        'Ignacio',
        'Avda. San Antonio, 4'
    );

INSERT INTO
    CLIENTE (cod_cliente, apellidos, nombre, direccion)
VALUES
    (
        'JALONSO',
        'Alonso Alfaro',
        'Jeronimo',
        'Avda. Santa Marina, 31'
    );

INSERT INTO
    CLIENTE (cod_cliente, apellidos, nombre, direccion)
VALUES
    (
        'JARANAZ',
        'Aranaz Rodriguez',
        'Juan Luis',
        'C/ Virgen del Aguila, 8'
    );

INSERT INTO
    CLIENTE (cod_cliente, apellidos, nombre, direccion)
VALUES
    (
        'JBECERRA',
        'Becerra Sanchez',
        'Jose',
        'C/ Colon, 10'
    );

INSERT INTO
    CLIENTE (cod_cliente, apellidos, nombre, direccion)
VALUES
    (
        'JGOMEZ',
        'Gomez Trillar',
        'Joaquin',
        'C/ Donoso Cortes, 1'
    );

INSERT INTO
    CLIENTE (cod_cliente, apellidos, nombre, direccion)
VALUES
    (
        'JMARTINEZ',
        'Martinez Morales',
        'Juan',
        'Ctra. De la Playa, 67'
    );

INSERT INTO
    CLIENTE (cod_cliente, apellidos, nombre, direccion)
VALUES
    (
        'JSALINAS',
        'Salinas del Mar',
        'Javier',
        'C/ Lepanto, 17'
    );

INSERT INTO
    CLIENTE (cod_cliente, apellidos, nombre, direccion)
VALUES
    (
        'JSANTOS',
        'Santos Perez',
        'Jaime',
        'Paseo Castellana, 230'
    );

INSERT INTO
    CLIENTE (cod_cliente, apellidos, nombre, direccion)
VALUES
    (
        'MCARDO',
        'Cardo Merita',
        'Maria',
        'Avda. Juan Carlos I, 10'
    );

INSERT INTO
    CLIENTE (cod_cliente, apellidos, nombre, direccion)
VALUES
    (
        'MFRANCO',
        'Franco Alonso',
        'Maria',
        'Avda. San Antonio, 4'
    );

INSERT INTO
    CLIENTE (cod_cliente, apellidos, nombre, direccion)
VALUES
    (
        'MGUTIERREZ',
        'Gutierrez Carro',
        'Maria',
        'Avda. Santa Marina, 31'
    );

INSERT INTO
    CLIENTE (cod_cliente, apellidos, nombre, direccion)
VALUES
    (
        'OLUENGO',
        'Luengo Castanio',
        'Ofelia',
        'C/ Virgen del Aguila, 8'
    );

INSERT INTO
    CLIENTE (cod_cliente, apellidos, nombre, direccion)
VALUES
    (
        'PALVAREZ',
        'Alvarez Morron',
        'Paloma',
        'C/ Virgen del Aguila, 8'
    );

INSERT INTO
    SUCURSAL (cod_sucursal, direccion, capital_anio_anterior)
VALUES
    (1, 'Avda. Juan Carlos I, 10', 120347);

INSERT INTO
    SUCURSAL (cod_sucursal, direccion, capital_anio_anterior)
VALUES
    (2, 'Paseo Castellana, 230', 259089);

INSERT INTO
    SUCURSAL (cod_sucursal, direccion, capital_anio_anterior)
VALUES
    (3, 'Ctra. De la Playa, 67', 100786);

INSERT INTO
    SUCURSAL (cod_sucursal, direccion, capital_anio_anterior)
VALUES
    (4, 'C/ Lepanto, 17', 70531);

INSERT INTO
    SUCURSAL (cod_sucursal, direccion, capital_anio_anterior)
VALUES
    (5, 'C / Juan de la Cosa', 500000);

INSERT INTO
    TIPO_MOVIMIENTO (cod_tipo_movimiento, descripcion, salida)
VALUES
    ('IE', 'Ingreso en efectivo', 'No');

INSERT INTO
    TIPO_MOVIMIENTO (cod_tipo_movimiento, descripcion, salida)
VALUES
    ('PR', 'Pago de recibo', 'Si');

INSERT INTO
    TIPO_MOVIMIENTO (cod_tipo_movimiento, descripcion, salida)
VALUES
    ('PT', 'Pago con tarjeta', 'Si');

INSERT INTO
    TIPO_MOVIMIENTO (cod_tipo_movimiento, descripcion, salida)
VALUES
    ('RC', 'Retirada por cajero automatico', 'Si');

INSERT INTO
    TIPO_MOVIMIENTO (cod_tipo_movimiento, descripcion, salida)
VALUES
    ('TR-E', 'Transferencia-Entrada', 'No');

INSERT INTO
    TIPO_MOVIMIENTO (cod_tipo_movimiento, descripcion, salida)
VALUES
    ('TR-S', 'Transferencia-Salida', 'Si');

INSERT INTO
    CUENTA (
        cod_cuenta,
        cod_cliente,
        saldo,
        interes,
        cod_sucursal
    )
VALUES
    (121229, 'EPEREZ', 12300, 0.12, '1');

INSERT INTO
    CUENTA (
        cod_cuenta,
        cod_cliente,
        saldo,
        interes,
        cod_sucursal
    )
VALUES
    (121221, 'EPEREZ', 12300, 0.12, 1);

INSERT INTO
    CUENTA (
        cod_cuenta,
        cod_cliente,
        saldo,
        interes,
        cod_sucursal
    )
VALUES
    (121222, 'CLUENGO', 3690, 0.03, 4);

INSERT INTO
    CUENTA (
        cod_cuenta,
        cod_cliente,
        saldo,
        interes,
        cod_sucursal
    )
VALUES
    (121231, 'ASOTILLO', 31980, 0.06, 2);

INSERT INTO
    CUENTA (
        cod_cuenta,
        cod_cliente,
        saldo,
        interes,
        cod_sucursal
    )
VALUES
    (121236, 'ARUBIO', 36900, 0.05, 1);

INSERT INTO
    CUENTA (
        cod_cuenta,
        cod_cliente,
        saldo,
        interes,
        cod_sucursal
    )
VALUES
    (121237, 'CALONSO', 12300, 0.07, 3);

INSERT INTO
    CUENTA (
        cod_cuenta,
        cod_cliente,
        saldo,
        interes,
        cod_sucursal
    )
VALUES
    (121255, 'EPEREZ', 36900, 0.01, 3);

INSERT INTO
    CUENTA (
        cod_cuenta,
        cod_cliente,
        saldo,
        interes,
        cod_sucursal
    )
VALUES
    (121574, 'JBECERRA', 184500, 0.1, 2);

INSERT INTO
    CUENTA (
        cod_cuenta,
        cod_cliente,
        saldo,
        interes,
        cod_sucursal
    )
VALUES
    (124334, 'IBUADES', 15375, 0.01, 3);

INSERT INTO
    CUENTA (
        cod_cuenta,
        cod_cliente,
        saldo,
        interes,
        cod_sucursal
    )
VALUES
    (131274, 'EPEREZ', 14760, 0.11, 1);

INSERT INTO
    CUENTA (
        cod_cuenta,
        cod_cliente,
        saldo,
        interes,
        cod_sucursal
    )
VALUES
    (156234, 'JALONSO', 4920, 0.03, 4);

INSERT INTO
    CUENTA (
        cod_cuenta,
        cod_cliente,
        saldo,
        interes,
        cod_sucursal
    )
VALUES
    (185964, 'EPEREZ', 36900, 0.025, 4);

INSERT INTO
    CUENTA (
        cod_cuenta,
        cod_cliente,
        saldo,
        interes,
        cod_sucursal
    )
VALUES
    (199234, 'FSANTOS', 49200, 0.11, 2);

INSERT INTO
    CUENTA (
        cod_cuenta,
        cod_cliente,
        saldo,
        interes,
        cod_sucursal
    )
VALUES
    (331234, 'FSANTOS', 15375, 0.01, 2);

INSERT INTO
    CUENTA (
        cod_cuenta,
        cod_cliente,
        saldo,
        interes,
        cod_sucursal
    )
VALUES
    (881234, 'ASOTILLO', 7380, 0.031, 4);

INSERT INTO
    CUENTA (
        cod_cuenta,
        cod_cliente,
        saldo,
        interes,
        cod_sucursal
    )
VALUES
    (921234, 'FSANTOS', 29520, 0.2, 3);

INSERT INTO
    CUENTA (
        cod_cuenta,
        cod_cliente,
        saldo,
        interes,
        cod_sucursal
    )
VALUES
    (961234, 'JARANAZ', 73800, 0.014, 1);

INSERT INTO
    MOVIMIENTO (
        cod_cuenta,
        mes,
        num_mov_mes,
        cod_tipo_movimiento,
        importe,
        fecha_hora
    )
VALUES
    (121221, 1, 1, 'IE', 120, '2007/1/23 16:33:00');

INSERT INTO
    MOVIMIENTO (
        cod_cuenta,
        mes,
        num_mov_mes,
        cod_tipo_movimiento,
        importe,
        fecha_hora
    )
VALUES
    (121221, 1, 2, 'TR-S', 300, '2007/1/30 22:00:00');

INSERT INTO
    MOVIMIENTO (
        cod_cuenta,
        mes,
        num_mov_mes,
        cod_tipo_movimiento,
        importe,
        fecha_hora
    )
VALUES
    (121221, 1, 3, 'RC', 300, '2007/1/23 21:05:00');

INSERT INTO
    MOVIMIENTO (
        cod_cuenta,
        mes,
        num_mov_mes,
        cod_tipo_movimiento,
        importe,
        fecha_hora
    )
VALUES
    (121221, 1, 4, 'PT', 1500, '2007/1/22 14:55:00');

INSERT INTO
    MOVIMIENTO (
        cod_cuenta,
        mes,
        num_mov_mes,
        cod_tipo_movimiento,
        importe,
        fecha_hora
    )
VALUES
    (121221, 1, 5, 'IE', 600, '2007/1/21 12:43:00');

INSERT INTO
    MOVIMIENTO (
        cod_cuenta,
        mes,
        num_mov_mes,
        cod_tipo_movimiento,
        importe,
        fecha_hora
    )
VALUES
    (121221, 1, 6, 'IE', 40, '2007/1/20 23:30:00');

INSERT INTO
    MOVIMIENTO (
        cod_cuenta,
        mes,
        num_mov_mes,
        cod_tipo_movimiento,
        importe,
        fecha_hora
    )
VALUES
    (121221, 1, 7, 'TR-S', 125, '2007/1/1 22:14:00');

INSERT INTO
    MOVIMIENTO (
        cod_cuenta,
        mes,
        num_mov_mes,
        cod_tipo_movimiento,
        importe,
        fecha_hora
    )
VALUES
    (121221, 1, 8, 'RC', 125, '2007/1/13 16:33:00');

INSERT INTO
    MOVIMIENTO (
        cod_cuenta,
        mes,
        num_mov_mes,
        cod_tipo_movimiento,
        importe,
        fecha_hora
    )
VALUES
    (121221, 1, 9, 'PT', 100, '2007/1/12 22:00:00');

INSERT INTO
    MOVIMIENTO (
        cod_cuenta,
        mes,
        num_mov_mes,
        cod_tipo_movimiento,
        importe,
        fecha_hora
    )
VALUES
    (121221, 1, 10, 'IE', 240, '2007/1/12 23:30:00');

INSERT INTO
    MOVIMIENTO (
        cod_cuenta,
        mes,
        num_mov_mes,
        cod_tipo_movimiento,
        importe,
        fecha_hora
    )
VALUES
    (121221, 1, 11, 'TR-S', 400, '2007/1/11 22:14:00');

INSERT INTO
    MOVIMIENTO (
        cod_cuenta,
        mes,
        num_mov_mes,
        cod_tipo_movimiento,
        importe,
        fecha_hora
    )
VALUES
    (121221, 2, 1, 'TR-S', 125, '2007/2/1 22:14:00');

INSERT INTO
    MOVIMIENTO (
        cod_cuenta,
        mes,
        num_mov_mes,
        cod_tipo_movimiento,
        importe,
        fecha_hora
    )
VALUES
    (121221, 2, 2, 'RC', 125, '2007/2/13 16:33:00');

INSERT INTO
    MOVIMIENTO (
        cod_cuenta,
        mes,
        num_mov_mes,
        cod_tipo_movimiento,
        importe,
        fecha_hora
    )
VALUES
    (121221, 2, 3, 'PT', 100, '2007/2/12 22:00:00');

INSERT INTO
    MOVIMIENTO (
        cod_cuenta,
        mes,
        num_mov_mes,
        cod_tipo_movimiento,
        importe,
        fecha_hora
    )
VALUES
    (121221, 2, 4, 'TR-S', 400, '2007/2/2 14:55:00');

INSERT INTO
    MOVIMIENTO (
        cod_cuenta,
        mes,
        num_mov_mes,
        cod_tipo_movimiento,
        importe,
        fecha_hora
    )
VALUES
    (121221, 2, 5, 'RC', 60, '2007/2/13 12:43:00');

INSERT INTO
    MOVIMIENTO (
        cod_cuenta,
        mes,
        num_mov_mes,
        cod_tipo_movimiento,
        importe,
        fecha_hora
    )
VALUES
    (121231, 1, 1, 'PR', 300, '2007/1/1 12:45:00');

INSERT INTO
    MOVIMIENTO (
        cod_cuenta,
        mes,
        num_mov_mes,
        cod_tipo_movimiento,
        importe,
        fecha_hora
    )
VALUES
    (121231, 1, 2, 'IE', 30, '2007/1/11 21:05:00');

INSERT INTO
    MOVIMIENTO (
        cod_cuenta,
        mes,
        num_mov_mes,
        cod_tipo_movimiento,
        importe,
        fecha_hora
    )
VALUES
    (121231, 2, 1, 'RC', 260, '2007/2/2 13:20:00');

INSERT INTO
    MOVIMIENTO (
        cod_cuenta,
        mes,
        num_mov_mes,
        cod_tipo_movimiento,
        importe,
        fecha_hora
    )
VALUES
    (121231, 2, 2, 'PT', 100, '2007/2/12 22:00:00');

INSERT INTO
    MOVIMIENTO (
        cod_cuenta,
        mes,
        num_mov_mes,
        cod_tipo_movimiento,
        importe,
        fecha_hora
    )
VALUES
    (121231, 2, 3, 'TR-S', 125, '2007/2/1 22:14:00');

INSERT INTO
    MOVIMIENTO (
        cod_cuenta,
        mes,
        num_mov_mes,
        cod_tipo_movimiento,
        importe,
        fecha_hora
    )
VALUES
    (121231, 2, 4, 'IE', 40, '2007/2/20 23:30:00');

INSERT INTO
    MOVIMIENTO (
        cod_cuenta,
        mes,
        num_mov_mes,
        cod_tipo_movimiento,
        importe,
        fecha_hora
    )
VALUES
    (121231, 3, 1, 'TR-S', 100, '2007/3/3 14:15:00');

INSERT INTO
    MOVIMIENTO (
        cod_cuenta,
        mes,
        num_mov_mes,
        cod_tipo_movimiento,
        importe,
        fecha_hora
    )
VALUES
    (121231, 3, 2, 'RC', 125, '2007/3/13 16:33:00');

INSERT INTO
    MOVIMIENTO (
        cod_cuenta,
        mes,
        num_mov_mes,
        cod_tipo_movimiento,
        importe,
        fecha_hora
    )
VALUES
    (121236, 1, 1, 'IE', 600, '2007/1/21 12:43:00');

INSERT INTO
    MOVIMIENTO (
        cod_cuenta,
        mes,
        num_mov_mes,
        cod_tipo_movimiento,
        importe,
        fecha_hora
    )
VALUES
    (121236, 1, 2, 'TR-S', 300, '2007/1/30 22:00:00');

INSERT INTO
    MOVIMIENTO (
        cod_cuenta,
        mes,
        num_mov_mes,
        cod_tipo_movimiento,
        importe,
        fecha_hora
    )
VALUES
    (121236, 2, 1, 'PT', 1500, '2007/2/22 14:55:00');

INSERT INTO
    MOVIMIENTO (
        cod_cuenta,
        mes,
        num_mov_mes,
        cod_tipo_movimiento,
        importe,
        fecha_hora
    )
VALUES
    (121236, 2, 2, 'IE', 120, '2007/2/23 16:33:00');

INSERT INTO
    MOVIMIENTO (
        cod_cuenta,
        mes,
        num_mov_mes,
        cod_tipo_movimiento,
        importe,
        fecha_hora
    )
VALUES
    (121236, 2, 3, 'IE', 240, '2007/2/12 23:30:00');

INSERT INTO
    MOVIMIENTO (
        cod_cuenta,
        mes,
        num_mov_mes,
        cod_tipo_movimiento,
        importe,
        fecha_hora
    )
VALUES
    (121236, 2, 4, 'RC', 60, '2007/2/13 12:43:00');

INSERT INTO
    MOVIMIENTO (
        cod_cuenta,
        mes,
        num_mov_mes,
        cod_tipo_movimiento,
        importe,
        fecha_hora
    )
VALUES
    (121236, 3, 1, 'RC', 300, '2007/3/23 21:05:00');

INSERT INTO
    MOVIMIENTO (
        cod_cuenta,
        mes,
        num_mov_mes,
        cod_tipo_movimiento,
        importe,
        fecha_hora
    )
VALUES
    (121236, 3, 2, 'TR-S', 400, '2007/3/11 22:14:00');

INSERT INTO
    MOVIMIENTO (
        cod_cuenta,
        mes,
        num_mov_mes,
        cod_tipo_movimiento,
        importe,
        fecha_hora
    )
VALUES
    (121574, 2, 1, 'TR-S', 125, '2007/2/1 22:14:00');

INSERT INTO
    MOVIMIENTO (
        cod_cuenta,
        mes,
        num_mov_mes,
        cod_tipo_movimiento,
        importe,
        fecha_hora
    )
VALUES
    (121574, 2, 2, 'RC', 125, '2007/2/13 16:33:00');

INSERT INTO
    MOVIMIENTO (
        cod_cuenta,
        mes,
        num_mov_mes,
        cod_tipo_movimiento,
        importe,
        fecha_hora
    )
VALUES
    (121574, 2, 3, 'PT', 100, '2007/2/12 22:00:00');

INSERT INTO
    MOVIMIENTO (
        cod_cuenta,
        mes,
        num_mov_mes,
        cod_tipo_movimiento,
        importe,
        fecha_hora
    )
VALUES
    (121574, 2, 4, 'TR-S', 400, '2007/2/2 14:55:00');

INSERT INTO
    MOVIMIENTO (
        cod_cuenta,
        mes,
        num_mov_mes,
        cod_tipo_movimiento,
        importe,
        fecha_hora
    )
VALUES
    (121574, 3, 1, 'RC', 60, '2007/3/13 12:43:00');

INSERT INTO
    MOVIMIENTO (
        cod_cuenta,
        mes,
        num_mov_mes,
        cod_tipo_movimiento,
        importe,
        fecha_hora
    )
VALUES
    (121574, 3, 2, 'IE', 240, '2007/3/12 23:30:00');

INSERT INTO
    MOVIMIENTO (
        cod_cuenta,
        mes,
        num_mov_mes,
        cod_tipo_movimiento,
        importe,
        fecha_hora
    )
VALUES
    (121574, 3, 3, 'TR-S', 400, '2007/3/11 22:14:00');

INSERT INTO
    MOVIMIENTO (
        cod_cuenta,
        mes,
        num_mov_mes,
        cod_tipo_movimiento,
        importe,
        fecha_hora
    )
VALUES
    (121574, 3, 4, 'IE', 120, '2007/3/23 16:33:00');

INSERT INTO
    MOVIMIENTO (
        cod_cuenta,
        mes,
        num_mov_mes,
        cod_tipo_movimiento,
        importe,
        fecha_hora
    )
VALUES
    (121574, 3, 5, 'TR-S', 300, '2007/3/30 22:00:00');

INSERT INTO
    MOVIMIENTO (
        cod_cuenta,
        mes,
        num_mov_mes,
        cod_tipo_movimiento,
        importe,
        fecha_hora
    )
VALUES
    (121574, 3, 6, 'RC', 300, '2007/3/23 21:05:00');

INSERT INTO
    MOVIMIENTO (
        cod_cuenta,
        mes,
        num_mov_mes,
        cod_tipo_movimiento,
        importe,
        fecha_hora
    )
VALUES
    (121574, 3, 7, 'PT', 1500, '2007/3/22 14:55:00');

INSERT INTO
    MOVIMIENTO (
        cod_cuenta,
        mes,
        num_mov_mes,
        cod_tipo_movimiento,
        importe,
        fecha_hora
    )
VALUES
    (121574, 3, 8, 'IE', 600, '2007/3/21 12:43:00');

INSERT INTO
    MOVIMIENTO (
        cod_cuenta,
        mes,
        num_mov_mes,
        cod_tipo_movimiento,
        importe,
        fecha_hora
    )
VALUES
    (121574, 3, 9, 'IE', 40, '2007/3/20 23:30:00');

INSERT INTO
    MOVIMIENTO (
        cod_cuenta,
        mes,
        num_mov_mes,
        cod_tipo_movimiento,
        importe,
        fecha_hora
    )
VALUES
    (156234, 1, 1, 'RC', 300, '2007/1/23 21:05:00');

INSERT INTO
    MOVIMIENTO (
        cod_cuenta,
        mes,
        num_mov_mes,
        cod_tipo_movimiento,
        importe,
        fecha_hora
    )
VALUES
    (156234, 1, 2, 'PT', 1500, '2007/1/22 14:55:00');

INSERT INTO
    MOVIMIENTO (
        cod_cuenta,
        mes,
        num_mov_mes,
        cod_tipo_movimiento,
        importe,
        fecha_hora
    )
VALUES
    (156234, 1, 3, 'IE', 600, '2007/1/21 12:43:00');

INSERT INTO
    MOVIMIENTO (
        cod_cuenta,
        mes,
        num_mov_mes,
        cod_tipo_movimiento,
        importe,
        fecha_hora
    )
VALUES
    (156234, 1, 4, 'IE', 40, '2007/1/20 23:30:00');

INSERT INTO
    MOVIMIENTO (
        cod_cuenta,
        mes,
        num_mov_mes,
        cod_tipo_movimiento,
        importe,
        fecha_hora
    )
VALUES
    (156234, 1, 5, 'TR-S', 125, '2007/1/1 22:14:00');

INSERT INTO
    MOVIMIENTO (
        cod_cuenta,
        mes,
        num_mov_mes,
        cod_tipo_movimiento,
        importe,
        fecha_hora
    )
VALUES
    (156234, 1, 6, 'RC', 125, '2007/1/13 16:33:00');

INSERT INTO
    MOVIMIENTO (
        cod_cuenta,
        mes,
        num_mov_mes,
        cod_tipo_movimiento,
        importe,
        fecha_hora
    )
VALUES
    (156234, 2, 1, 'RC', 125, '2007/2/13 16:33:00');

INSERT INTO
    MOVIMIENTO (
        cod_cuenta,
        mes,
        num_mov_mes,
        cod_tipo_movimiento,
        importe,
        fecha_hora
    )
VALUES
    (156234, 2, 2, 'PT', 100, '2007/2/12 22:00:00');

INSERT INTO
    MOVIMIENTO (
        cod_cuenta,
        mes,
        num_mov_mes,
        cod_tipo_movimiento,
        importe,
        fecha_hora
    )
VALUES
    (156234, 2, 3, 'TR-S', 400, '2007/2/2 14:55:00');

INSERT INTO
    MOVIMIENTO (
        cod_cuenta,
        mes,
        num_mov_mes,
        cod_tipo_movimiento,
        importe,
        fecha_hora
    )
VALUES
    (156234, 2, 4, 'RC', 60, '2007/2/13 12:43:00');

INSERT INTO
    MOVIMIENTO (
        cod_cuenta,
        mes,
        num_mov_mes,
        cod_tipo_movimiento,
        importe,
        fecha_hora
    )
VALUES
    (156234, 2, 5, 'IE', 240, '2007/2/12 23:30:00');

INSERT INTO
    MOVIMIENTO (
        cod_cuenta,
        mes,
        num_mov_mes,
        cod_tipo_movimiento,
        importe,
        fecha_hora
    )
VALUES
    (156234, 2, 6, 'TR-S', 400, '2007/2/11 22:14:00');

INSERT INTO
    MOVIMIENTO (
        cod_cuenta,
        mes,
        num_mov_mes,
        cod_tipo_movimiento,
        importe,
        fecha_hora
    )
VALUES
    (156234, 2, 7, 'IE', 120, '2007/2/23 16:33:00');

INSERT INTO
    MOVIMIENTO (
        cod_cuenta,
        mes,
        num_mov_mes,
        cod_tipo_movimiento,
        importe,
        fecha_hora
    )
VALUES
    (156234, 2, 8, 'TR-S', 300, '2007/2/28 22:00:00');

INSERT INTO
    MOVIMIENTO (
        cod_cuenta,
        mes,
        num_mov_mes,
        cod_tipo_movimiento,
        importe,
        fecha_hora
    )
VALUES
    (156234, 3, 1, 'IE', 120, '2007/3/23 16:33:00');

INSERT INTO
    MOVIMIENTO (
        cod_cuenta,
        mes,
        num_mov_mes,
        cod_tipo_movimiento,
        importe,
        fecha_hora
    )
VALUES
    (156234, 3, 2, 'TR-S', 300, '2007/3/30 22:00:00');

INSERT INTO
    MOVIMIENTO (
        cod_cuenta,
        mes,
        num_mov_mes,
        cod_tipo_movimiento,
        importe,
        fecha_hora
    )
VALUES
    (156234, 3, 3, 'IE', 40, '2007/3/20 23:30:00');

INSERT INTO
    MOVIMIENTO (
        cod_cuenta,
        mes,
        num_mov_mes,
        cod_tipo_movimiento,
        importe,
        fecha_hora
    )
VALUES
    (156234, 3, 4, 'TR-S', 125, '2007/3/1 22:14:00');

INSERT INTO
    MOVIMIENTO (
        cod_cuenta,
        mes,
        num_mov_mes,
        cod_tipo_movimiento,
        importe,
        fecha_hora
    )
VALUES
    (881234, 1, 1, 'TR-S', 400, '2007/1/2 14:55:00');

INSERT INTO
    MOVIMIENTO (
        cod_cuenta,
        mes,
        num_mov_mes,
        cod_tipo_movimiento,
        importe,
        fecha_hora
    )
VALUES
    (881234, 1, 2, 'TR-S', 150, '2007/1/11 13:20:00');

INSERT INTO
    MOVIMIENTO (
        cod_cuenta,
        mes,
        num_mov_mes,
        cod_tipo_movimiento,
        importe,
        fecha_hora
    )
VALUES
    (881234, 3, 1, 'IE', 100, '2007/3/3 12:45:00');

INSERT INTO
    MOVIMIENTO (
        cod_cuenta,
        mes,
        num_mov_mes,
        cod_tipo_movimiento,
        importe,
        fecha_hora
    )
VALUES
    (881234, 3, 2, 'IE', 300, '2007/3/12 14:15:00');

--COMMIT;