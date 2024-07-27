--Crear la base de datos

CREATE DATABASE PokeDataMaster;

--Crear tabla de pokemones

CREATE TABLE Pokemon (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    tipo VARCHAR(50),
    habilidad VARCHAR(50),
    hp INT,
    ataque INT,
    defensa INT,
    velocidad INT
);

--Crear tabla de entrenadores

CREATE TABLE Entrenador (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    edad INT,
    ciudad VARCHAR(50)
);

--Tabla de relación Entrenadores-Pokémon

CREATE TABLE Entrenador_Pokemon (
    id_entrenador INT REFERENCES Entrenador(id),
    id_pokemon INT REFERENCES Pokemon(id),
    PRIMARY KEY (id_entrenador, id_pokemon)
);

--Tabla de Batallas

CREATE TABLE Batalla (
    id SERIAL PRIMARY KEY,
    id_entrenador1 INT REFERENCES Entrenador(id),
    id_entrenador2 INT REFERENCES Entrenador(id),
    id_pokemon1 INT REFERENCES Pokemon(id),
    id_pokemon2 INT REFERENCES Pokemon(id),
    fecha DATE,
    resultado VARCHAR(50)
);


-----Insercion de datos-----

---Tabla Pokemon

INSERT INTO Pokemon (nombre, tipo, habilidad, hp, ataque, defensa, velocidad)
VALUES 
('Pikachu', 'Eléctrico', 'Electricidad estática', 35, 55, 40, 90),
('Charmander', 'Fuego', 'Mar de llamas', 39, 52, 43, 65),
('Squirtle', 'Agua', 'Torrente', 44, 48, 65, 43),
('Jigglypuff', 'Normal', 'Cuerpo puro', 115, 45, 20, 20),
('Meowth', 'Normal', 'Recogida', 40, 45, 35, 90),
('Psyduck', 'Agua', 'Desconcierto', 50, 52, 48, 55),
('Machop', 'Lucha', 'Agallas', 70, 80, 50, 35),
('Geodude', 'Roca/Tierra', 'Cabeza Roca', 40, 80, 100, 20),
('Magikarp', 'Agua', 'Nado rápido', 20, 10, 55, 80),
('Eevee', 'Normal', 'Fuga', 55, 55, 50, 55),
('Snorlax', 'Normal', 'Inmunidad', 160, 110, 65, 30),
('Pidgey', 'Normal/Volador', 'Vista Lince', 40, 45, 40, 56);

---Tabla entrendadores 

INSERT INTO Entrenador (nombre, edad, ciudad)
VALUES 
('Ash Ketchum', 10, 'Pueblo Paleta'),
('Misty', 12, 'Ciudad Celeste'),
('Brock', 15, 'Ciudad Plateada'),
('Gary Oak', 10, 'Pueblo Paleta'),
('Jessie', 17, 'Desconocido'),
('James', 17, 'Desconocido'),
('Tracey', 14, 'Pueblo Paleta'),
('May', 10, 'Ciudad Petalia'),
('Dawn', 10, 'Pueblo Hojaverde'),
('Iris', 12, 'Ciudad Opelucid'),
('Cilan', 15, 'Ciudad Gres'),
('Clemont', 12, 'Ciudad Luminalia');

-----Insertar datos en la tabla de relación Entrenadores-Pokémon------

INSERT INTO Entrenador_Pokemon (id_entrenador, id_pokemon)
VALUES 
(1, 1),  -- Ash - Pikachu
(1, 2),  -- Ash - Charmander
(2, 3),  -- Misty - Squirtle
(3, 4),  -- Brock - Jigglypuff
(4, 5),  -- Gary - Meowth
(5, 6),  -- Jessie - Psyduck
(6, 7),  -- James - Machop
(7, 8),  -- Tracey - Geodude
(8, 9),  -- May - Magikarp
(9, 10), -- Dawn - Eevee
(10, 1), -- Iris - Pikachu
(11, 2), -- Cilan - Charmander
(12, 11),-- Clemont - Snorlax
(12, 12);-- Clemont - Pidgey

-----Insertar datos en la tabla de Batallas-----

INSERT INTO Batalla (id_entrenador1, id_entrenador2, id_pokemon1, id_pokemon2, fecha, resultado)
VALUES 
(1, 2, 1, 3, '2024-07-20', 'Ash gana'),
(2, 3, 3, 4, '2024-07-21', 'Misty gana'),
(4, 5, 5, 6, '2024-07-22', 'Gary gana'),
(6, 7, 7, 8, '2024-07-23', 'Jessie gana'),
(8, 9, 9, 10, '2024-07-24', 'May gana'),
(10, 11, 1, 2, '2024-07-25', 'Iris gana'),
(11, 12, 11, 12, '2024-07-26', 'Clemont gana'),
(1, 3, 1, 4, '2024-07-27', 'Ash gana'),
(2, 4, 3, 5, '2024-07-28', 'Misty gana'),
(5, 6, 6, 7, '2024-07-29', 'James gana');


------Operaciones CRUD------

---Create (Crear)

-- Añadir un nuevo Pokémon
INSERT INTO Pokemon (nombre, tipo, habilidad, hp, ataque, defensa, velocidad)
VALUES ('Bulbasaur', 'Planta', 'Clorofila', 45, 49, 49, 45);


--Reed(leer)

-- Recuperar información de un Pokémon
SELECT * FROM Pokemon WHERE nombre = 'Pikachu';

-- Mostrar una lista de todos los Pokémon
SELECT * FROM Pokemon;

-- Mostrar una lista de todos los Entrenadores
SELECT * FROM Entrenador;


---Update(actualizar)

-- Modificar la información de un Pokémon
UPDATE Pokemon SET hp = 50 WHERE nombre = 'Pikachu';


--- Delete (eliminar)

-- Modificar la información de un Pokémon
UPDATE Pokemon SET hp = 50 WHERE nombre = 'Pikachu';

------Relaciones y Operaciones Multi-Tabla-----

---Mostrar Pokémones y sus entrenadores

SELECT Entrenador.nombre AS entrenador, Pokemon.nombre AS pokemon
FROM Entrenador
JOIN Entrenador_Pokemon ON Entrenador.id = Entrenador_Pokemon.id_entrenador
JOIN Pokemon ON Pokemon.id = Entrenador_Pokemon.id_pokemon;

---Eliminar un Pokémon y sus relaciones

-- Eliminar un Pokémon de la tabla principal y las tablas relacionadas
DELETE FROM Entrenador_Pokemon
USING Pokemon
WHERE Entrenador_Pokemon.id_pokemon = Pokemon.id AND Pokemon.nombre = 'Pikachu';

DELETE FROM Pokemon WHERE nombre = 'Pikachu';


---Mostrar detalles de las batallas

SELECT Batalla.fecha, 
       e1.nombre AS entrenador1, 
       p1.nombre AS pokemon1, 
       e2.nombre AS entrenador2, 
       p2.nombre AS pokemon2, 
       Batalla.resultado
FROM Batalla
JOIN Entrenador e1 ON Batalla.id_entrenador1 = e1.id
JOIN Pokemon p1 ON Batalla.id_pokemon1 = p1.id
JOIN Entrenador e2 ON Batalla.id_entrenador2 = e2.id
JOIN Pokemon p2 ON Batalla.id_pokemon2 = p2.id;


---Mostrar detalles de las batallas

Copiar código
SELECT Batalla.fecha, 
       e1.nombre AS entrenador1, 
       p1.nombre AS pokemon1, 
       e2.nombre AS entrenador2, 
       p2.nombre AS pokemon2, 
       Batalla.resultado
FROM Batalla
JOIN Entrenador e1 ON Batalla.id_entrenador1 = e1.id
JOIN Pokemon p1 ON Batalla.id_pokemon1 = p1.id
JOIN Entrenador e2 ON Batalla.id_entrenador2 = e2.id
JOIN Pokemon p2 ON Batalla.id_pokemon2 = p2.id;