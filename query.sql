---------------------------
--PRIMERA PARTE--
---------------------------

-- CREAR TABLAS DETERMINADAS EN EL DOC DE APOYO --
DROP TABLE IF EXISTS reparto_soltera_otra_vez;
CREATE TABLE reparto_soltera_otra_vez
(
    nombre character varying(255) NOT NULL,
    temporadas integer,
    protagonico boolean,
    sueldo integer,
    PRIMARY KEY (nombre)
);

insert into reparto_soltera_otra_vez (nombre, temporadas, protagonico, sueldo) values ('Paz Bascuñán', 3, true, 100);
insert into reparto_soltera_otra_vez (nombre, temporadas, protagonico, sueldo) values ('Pablo Macaya', 3, true, 100);
insert into reparto_soltera_otra_vez (nombre, temporadas, protagonico, sueldo) values ('Cristián Arriagada', 3, true, 95);
insert into reparto_soltera_otra_vez (nombre, temporadas, protagonico, sueldo) values ('Josefina Montané', 2, true, 90);
insert into reparto_soltera_otra_vez (nombre, temporadas, protagonico, sueldo) values ('Loreto Aravena', 3, true, 95);
insert into reparto_soltera_otra_vez (nombre, temporadas, protagonico, sueldo) values ('Lorena Bosch', 2, true, 90);
insert into reparto_soltera_otra_vez (nombre, temporadas, protagonico, sueldo) values ('Nicolás Poblete', 2, true, 85);
insert into reparto_soltera_otra_vez (nombre, temporadas, protagonico, sueldo) values ('Héctor Morales', 3, true, 80);
insert into reparto_soltera_otra_vez (nombre, temporadas, protagonico, sueldo) values ('Aranzazú Yankovic', 2, true, 80);
insert into reparto_soltera_otra_vez (nombre, temporadas, protagonico, sueldo) values ('Luis Gnecco', 3, true, 95);
insert into reparto_soltera_otra_vez (nombre, temporadas, protagonico, sueldo) values ('Catalina Guerra', 3, true, 90);
insert into reparto_soltera_otra_vez (nombre, temporadas, protagonico, sueldo) values ('Solange Lackington', 2, true, 70);
insert into reparto_soltera_otra_vez (nombre, temporadas, protagonico, sueldo) values ('Ignacio Garmendia', 2, true, 70);
insert into reparto_soltera_otra_vez (nombre, temporadas, protagonico, sueldo) values ('Julio González', 3, true, 75);
insert into reparto_soltera_otra_vez (nombre, temporadas, protagonico, sueldo) values ('Antonella Orsini', 3, true, 70);
insert into reparto_soltera_otra_vez (nombre, temporadas, protagonico, sueldo) values ('Tamara Acosta', 1, false, 60);
insert into reparto_soltera_otra_vez (nombre, temporadas, protagonico, sueldo) values ('Silvia Santelices', 1, false, 55);
insert into reparto_soltera_otra_vez (nombre, temporadas, protagonico, sueldo) values ('Alejandro Trejo', 1, false, 55);
insert into reparto_soltera_otra_vez (nombre, temporadas, protagonico, sueldo) values ('Grimanesa Jiménez', 1, false, 60);

DROP TABLE IF EXISTS reparto_papi_ricky;
CREATE TABLE reparto_papi_ricky
(
    nombre character varying(255) NOT NULL,
    capitulos integer,
    protagonico boolean,
    sueldo integer,
    PRIMARY KEY (nombre)
);

insert into reparto_papi_ricky (nombre, capitulos, protagonico, sueldo) values ('Jorge Zabaleta', 135, true, 100);
insert into reparto_papi_ricky (nombre, capitulos, protagonico, sueldo) values ('Belén Soto', 135, true, 100);
insert into reparto_papi_ricky (nombre, capitulos, protagonico, sueldo) values ('Tamara Acosta', 135, true, 100);
insert into reparto_papi_ricky (nombre, capitulos, protagonico, sueldo) values ('María Elena Swett', 135, true, 100);
insert into reparto_papi_ricky (nombre, capitulos, protagonico, sueldo) values ('Juan Falcón', 135, true, 95);
insert into reparto_papi_ricky (nombre, capitulos, protagonico, sueldo) values ('Silvia Santelices', 135, true, 85);
insert into reparto_papi_ricky (nombre, capitulos, protagonico, sueldo) values ('Leonardo Perucci', 135, true, 85);
insert into reparto_papi_ricky (nombre, capitulos, protagonico, sueldo) values ('Teresita Reyes', 135, true, 80);
insert into reparto_papi_ricky (nombre, capitulos, protagonico, sueldo) values ('Luis Gnecco', 135, true, 75);
insert into reparto_papi_ricky (nombre, capitulos, protagonico, sueldo) values ('Alejandro Trejo', 135, true, 65);
insert into reparto_papi_ricky (nombre, capitulos, protagonico, sueldo) values ('Grimanesa Jiménez', 135, true, 60);
insert into reparto_papi_ricky (nombre, capitulos, protagonico, sueldo) values ('Remigio Remedy', 135, true, 60);
insert into reparto_papi_ricky (nombre, capitulos, protagonico, sueldo) values ('María Paz Grandjean', 135, true, 55);
insert into reparto_papi_ricky (nombre, capitulos, protagonico, sueldo) values ('Héctor Morales', 135, true, 50);
insert into reparto_papi_ricky (nombre, capitulos, protagonico, sueldo) values ('César Caillet', 135, true, 40);
insert into reparto_papi_ricky (nombre, capitulos, protagonico, sueldo) values ('José Tomás Guzmán', 135, true, 25);
insert into reparto_papi_ricky (nombre, capitulos, protagonico, sueldo) values ('Manuel Aguirre', 135, true, 30);

-- Consulta 1: Obtener todos los actores que participaron en ambas teleseries, el sueldo que obtuvieron en cada una y la suma de ambos sueldos, todo esto ordenado por el nombre del actor --
SELECT 
    rp.nombre,
    rp.sueldo AS sueldo_papi_ricky,
    rs.sueldo AS sueldo_soltera,
    (rp.sueldo + rs.sueldo) AS sueldo_total
FROM reparto_papi_ricky AS rp
INNER JOIN reparto_soltera_otra_vez AS rs
    ON rp.nombre = rs.nombre
ORDER BY rp.nombre;

-- Consulta 2: obtener todos los actores que participaron exclusivamente en soltera otra vez, con un sueldo mayor a 90
SELECT s.nombre, s.sueldo
FROM reparto_soltera_otra_vez s 
LEFT JOIN reparto_papi_ricky p ON s.nombre = p.nombre
WHERE p.nombre IS NULL AND s.sueldo > 90

-- Consulta 3: obtener solo los actores con sueldo inferior a 85 que actuaron en cualquiera de las dos teleseries, pero no en las dos
SELECT nombre, sueldo
FROM reparto_soltera_otra_vez
WHERE sueldo < 85 AND nombre NOT IN (SELECT nombre FROM reparto_papi_ricky)
UNION
SELECT nombre, sueldo
FROM reparto_papi_ricky
WHERE sueldo < 85 AND nombre NOT IN (SELECT nombre FROM reparto_soltera_otra_vez);




---------------------------
--SEGUNDA PARTE--
---------------------------

-- Consulta 5: Crear los scripts de creación de tablas, campos y llaves necesarias. Para poblar las tablas, incluya inserts de los mismos datos del ejercicio anterior adaptados a este nuevo sistema mejorado--
DROP TABLE IF EXISTS actores_reparto CASCADE;
DROP TABLE IF EXISTS actores CASCADE;
DROP TABLE IF EXISTS teleseries CASCADE;

CREATE TABLE actores (
    id_actor SERIAL PRIMARY KEY,
    nombre VARCHAR(255) UNIQUE NOT NULL
);

CREATE TABLE teleseries (
    id_teleserie SERIAL PRIMARY KEY,
    nombre VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE actores_reparto (
    id_reparto SERIAL PRIMARY KEY,
    id_actor INT NOT NULL,
    id_teleserie INT NOT NULL,
    temporadas INT,
    capitulos INT,
    protagonico BOOLEAN,
    sueldo INT NOT NULL,

    CONSTRAINT fk_actor
        FOREIGN KEY (id_actor)
        REFERENCES actores(id_actor),

    CONSTRAINT fk_teleserie
        FOREIGN KEY (id_teleserie)
        REFERENCES teleseries(id_teleserie),

    CONSTRAINT unq_actor_teleserie
        UNIQUE (id_actor, id_teleserie)
);

-- Insertar teleseries
INSERT INTO teleseries (nombre) VALUES ('Soltera otra vez');
INSERT INTO teleseries (nombre) VALUES ('Papi Ricky');

-- Insertar actores únicos
INSERT INTO actores (nombre) VALUES ('Paz Bascuñán');
INSERT INTO actores (nombre) VALUES ('Pablo Macaya');
INSERT INTO actores (nombre) VALUES ('Cristián Arriagada');
INSERT INTO actores (nombre) VALUES ('Josefina Montané');
INSERT INTO actores (nombre) VALUES ('Loreto Aravena');
INSERT INTO actores (nombre) VALUES ('Lorena Bosch');
INSERT INTO actores (nombre) VALUES ('Nicolás Poblete');
INSERT INTO actores (nombre) VALUES ('Héctor Morales');
INSERT INTO actores (nombre) VALUES ('Aranzazú Yankovic');
INSERT INTO actores (nombre) VALUES ('Luis Gnecco');
INSERT INTO actores (nombre) VALUES ('Catalina Guerra');
INSERT INTO actores (nombre) VALUES ('Solange Lackington');
INSERT INTO actores (nombre) VALUES ('Ignacio Garmendia');
INSERT INTO actores (nombre) VALUES ('Julio González');
INSERT INTO actores (nombre) VALUES ('Antonella Orsini');
INSERT INTO actores (nombre) VALUES ('Tamara Acosta');
INSERT INTO actores (nombre) VALUES ('Silvia Santelices');
INSERT INTO actores (nombre) VALUES ('Alejandro Trejo');
INSERT INTO actores (nombre) VALUES ('Grimanesa Jiménez');
INSERT INTO actores (nombre) VALUES ('Jorge Zabaleta');
INSERT INTO actores (nombre) VALUES ('Belén Soto');
INSERT INTO actores (nombre) VALUES ('María Elena Swett');
INSERT INTO actores (nombre) VALUES ('Juan Falcón');
INSERT INTO actores (nombre) VALUES ('Leonardo Perucci');
INSERT INTO actores (nombre) VALUES ('Teresita Reyes');
INSERT INTO actores (nombre) VALUES ('Remigio Remedy');
INSERT INTO actores (nombre) VALUES ('María Paz Grandjean');
INSERT INTO actores (nombre) VALUES ('César Caillet');
INSERT INTO actores (nombre) VALUES ('José Tomás Guzmán');
INSERT INTO actores (nombre) VALUES ('Manuel Aguirre');

-- Insertar reparto de Soltera otra vez
INSERT INTO actores_reparto (id_actor, id_teleserie, temporadas, protagonico, sueldo) VALUES ((SELECT id_actor FROM actores WHERE nombre = 'Paz Bascuñán'), 1, 3, true, 100);
INSERT INTO actores_reparto (id_actor, id_teleserie, temporadas, protagonico, sueldo) VALUES ((SELECT id_actor FROM actores WHERE nombre = 'Pablo Macaya'), 1, 3, true, 100);
INSERT INTO actores_reparto (id_actor, id_teleserie, temporadas, protagonico, sueldo) VALUES ((SELECT id_actor FROM actores WHERE nombre = 'Cristián Arriagada'), 1, 3, true, 95);
INSERT INTO actores_reparto (id_actor, id_teleserie, temporadas, protagonico, sueldo) VALUES ((SELECT id_actor FROM actores WHERE nombre = 'Josefina Montané'), 1, 2, true, 90);
INSERT INTO actores_reparto (id_actor, id_teleserie, temporadas, protagonico, sueldo) VALUES ((SELECT id_actor FROM actores WHERE nombre = 'Loreto Aravena'), 1, 3, true, 95);
INSERT INTO actores_reparto (id_actor, id_teleserie, temporadas, protagonico, sueldo) VALUES ((SELECT id_actor FROM actores WHERE nombre = 'Lorena Bosch'), 1, 2, true, 90);
INSERT INTO actores_reparto (id_actor, id_teleserie, temporadas, protagonico, sueldo) VALUES ((SELECT id_actor FROM actores WHERE nombre = 'Nicolás Poblete'), 1, 2, true, 85);
INSERT INTO actores_reparto (id_actor, id_teleserie, temporadas, protagonico, sueldo) VALUES ((SELECT id_actor FROM actores WHERE nombre = 'Héctor Morales'), 1, 3, true, 80);
INSERT INTO actores_reparto (id_actor, id_teleserie, temporadas, protagonico, sueldo) VALUES ((SELECT id_actor FROM actores WHERE nombre = 'Aranzazú Yankovic'), 1, 2, true, 80);
INSERT INTO actores_reparto (id_actor, id_teleserie, temporadas, protagonico, sueldo) VALUES ((SELECT id_actor FROM actores WHERE nombre = 'Luis Gnecco'), 1, 3, true, 95);
INSERT INTO actores_reparto (id_actor, id_teleserie, temporadas, protagonico, sueldo) VALUES ((SELECT id_actor FROM actores WHERE nombre = 'Catalina Guerra'), 1, 3, true, 90);
INSERT INTO actores_reparto (id_actor, id_teleserie, temporadas, protagonico, sueldo) VALUES ((SELECT id_actor FROM actores WHERE nombre = 'Solange Lackington'), 1, 2, true, 70);
INSERT INTO actores_reparto (id_actor, id_teleserie, temporadas, protagonico, sueldo) VALUES ((SELECT id_actor FROM actores WHERE nombre = 'Ignacio Garmendia'), 1, 2, true, 70);
INSERT INTO actores_reparto (id_actor, id_teleserie, temporadas, protagonico, sueldo) VALUES ((SELECT id_actor FROM actores WHERE nombre = 'Julio González'), 1, 3, true, 75);
INSERT INTO actores_reparto (id_actor, id_teleserie, temporadas, protagonico, sueldo) VALUES ((SELECT id_actor FROM actores WHERE nombre = 'Antonella Orsini'), 1, 3, true, 70);
INSERT INTO actores_reparto (id_actor, id_teleserie, temporadas, protagonico, sueldo) VALUES ((SELECT id_actor FROM actores WHERE nombre = 'Tamara Acosta'), 1, 1, false, 60);
INSERT INTO actores_reparto (id_actor, id_teleserie, temporadas, protagonico, sueldo) VALUES ((SELECT id_actor FROM actores WHERE nombre = 'Silvia Santelices'), 1, 1, false, 55);
INSERT INTO actores_reparto (id_actor, id_teleserie, temporadas, protagonico, sueldo) VALUES ((SELECT id_actor FROM actores WHERE nombre = 'Alejandro Trejo'), 1, 1, false, 55);
INSERT INTO actores_reparto (id_actor, id_teleserie, temporadas, protagonico, sueldo) VALUES ((SELECT id_actor FROM actores WHERE nombre = 'Grimanesa Jiménez'), 1, 1, false, 60);

-- Insertar reparto de Papi Ricky
INSERT INTO actores_reparto (id_actor, id_teleserie, capitulos, protagonico, sueldo) VALUES ((SELECT id_actor FROM actores WHERE nombre = 'Jorge Zabaleta'), 2, 135, true, 100);
INSERT INTO actores_reparto (id_actor, id_teleserie, capitulos, protagonico, sueldo) VALUES ((SELECT id_actor FROM actores WHERE nombre = 'Belén Soto'), 2, 135, true, 100);
INSERT INTO actores_reparto (id_actor, id_teleserie, capitulos, protagonico, sueldo) VALUES ((SELECT id_actor FROM actores WHERE nombre = 'Tamara Acosta'), 2, 135, true, 100);
INSERT INTO actores_reparto (id_actor, id_teleserie, capitulos, protagonico, sueldo) VALUES ((SELECT id_actor FROM actores WHERE nombre = 'María Elena Swett'), 2, 135, true, 100);
INSERT INTO actores_reparto (id_actor, id_teleserie, capitulos, protagonico, sueldo) VALUES ((SELECT id_actor FROM actores WHERE nombre = 'Juan Falcón'), 2, 135, true, 95);
INSERT INTO actores_reparto (id_actor, id_teleserie, capitulos, protagonico, sueldo) VALUES ((SELECT id_actor FROM actores WHERE nombre = 'Silvia Santelices'), 2, 135, true, 85);
INSERT INTO actores_reparto (id_actor, id_teleserie, capitulos, protagonico, sueldo) VALUES ((SELECT id_actor FROM actores WHERE nombre = 'Leonardo Perucci'), 2, 135, true, 85);
INSERT INTO actores_reparto (id_actor, id_teleserie, capitulos, protagonico, sueldo) VALUES ((SELECT id_actor FROM actores WHERE nombre = 'Teresita Reyes'), 2, 135, true, 80);
INSERT INTO actores_reparto (id_actor, id_teleserie, capitulos, protagonico, sueldo) VALUES ((SELECT id_actor FROM actores WHERE nombre = 'Luis Gnecco'), 2, 135, true, 75);
INSERT INTO actores_reparto (id_actor, id_teleserie, capitulos, protagonico, sueldo) VALUES ((SELECT id_actor FROM actores WHERE nombre = 'Alejandro Trejo'), 2, 135, true, 65);
INSERT INTO actores_reparto (id_actor, id_teleserie, capitulos, protagonico, sueldo) VALUES ((SELECT id_actor FROM actores WHERE nombre = 'Grimanesa Jiménez'), 2, 135, true, 60);
INSERT INTO actores_reparto (id_actor, id_teleserie, capitulos, protagonico, sueldo) VALUES ((SELECT id_actor FROM actores WHERE nombre = 'Remigio Remedy'), 2, 135, true, 60);
INSERT INTO actores_reparto (id_actor, id_teleserie, capitulos, protagonico, sueldo) VALUES ((SELECT id_actor FROM actores WHERE nombre = 'María Paz Grandjean'), 2, 135, true, 55);
INSERT INTO actores_reparto (id_actor, id_teleserie, capitulos, protagonico, sueldo) VALUES ((SELECT id_actor FROM actores WHERE nombre = 'Héctor Morales'), 2, 135, true, 50);
INSERT INTO actores_reparto (id_actor, id_teleserie, capitulos, protagonico, sueldo) VALUES ((SELECT id_actor FROM actores WHERE nombre = 'César Caillet'), 2, 135, true, 40);
INSERT INTO actores_reparto (id_actor, id_teleserie, capitulos, protagonico, sueldo) VALUES ((SELECT id_actor FROM actores WHERE nombre = 'José Tomás Guzmán'), 2, 135, true, 25);
INSERT INTO actores_reparto (id_actor, id_teleserie, capitulos, protagonico, sueldo) VALUES ((SELECT id_actor FROM actores WHERE nombre = 'Manuel Aguirre'), 2, 135, true, 30);

-- Consulta 6: Crear una consulta que muestre todas las teleseries y todos los actores de reparto asociados. No incluya los actores de rol secundario.
SELECT 
    t.nombre AS teleserie, a.nombre AS actor, ar.sueldo
FROM teleseries t
INNER JOIN actores_reparto ar ON t.id_teleserie = ar.id_teleserie AND ar.protagonico = true
INNER JOIN actores a ON ar.id_actor = a.id_actor
ORDER BY t.nombre, a.nombre;
