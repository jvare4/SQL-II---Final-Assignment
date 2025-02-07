USE Biblioteca;

--1. Listar todos los datos de los autores

SELECT id_autor, nombre, apellido, pais
FROM Autores
LEFT JOIN Paises
ON Autores.id_pais = Paises.id_pais;

--2. Listar nombre, apellido y edad de los estudiantes

SELECT nombre, apellido, edad
FROM Estudiantes;

--3. Cuales estudiantes pertenecen a la carrera de “Informatica”

SELECT nombre, apellido, carrera
FROM Estudiantes
JOIN Carreras
ON Estudiantes.id_carrera = Carreras.id_carrera
WHERE carrera = 'Informatica';

--4. Listar los nombres y apellido de los estudiantes cuyo nombre comience con la letra “G”

SELECT nombre, apellido
FROM Estudiantes
WHERE nombre LIKE 'G%';

--5. ¿Quien es el autor del libro “Introducción a Visual Studio .NET”?

SELECT CONCAT(nombre, ' ', apellido) AS autor
FROM Autores
JOIN Libros_Autores
ON Autores.id_autor = Libros_Autores.id_autor
JOIN Libros
ON Libros.id_libro = Libros_Autores.id_libro
WHERE titulo = 'Introducción a Visual Studio .NET';

--6. ¿Que autores son de nacionalidad Americana o Francesa?

SELECT CONCAT(nombre, ' ', apellido) AS autor, pais
FROM Autores
JOIN Paises
ON Autores.id_pais = Paises.id_pais
WHERE pais = 'Estados Unidos' OR pais = 'Francia';

--7. Que libros no son del area de “INTERNET”

SELECT titulo, genero
FROM Libros
LEFT JOIN Generos
ON Libros.id_genero = Generos.id_genero
WHERE genero NOT LIKE 'INTERNET';

--8. Que libro se prestó al lector “Raúl Valdez Alanes”

SELECT titulo, CONCAT(nombre, ' ', apellido) AS prestatario, fecha_prestamo
FROM Libros
JOIN Prestamos
ON Libros.id_libro = Prestamos.id_libro
JOIN Estudiantes
ON Estudiantes.id_estudiante = Prestamos.id_estudiante
WHERE nombre LIKE '%Raul%'
	AND apellido LIKE '%Valdez%'
	AND apellido LIKE '%Alanes%';

--9. Listar el nombre y el apellido del estudiante de menor edad

SELECT TOP 1 nombre, apellido
FROM Estudiantes
ORDER BY edad;

--10. Listar nombre y apellido de los estudiantes a los que se les prestaron libros de “Bases de Datos”

SELECT nombre, apellido
FROM Estudiantes
JOIN Prestamos
ON Estudiantes.id_estudiante = Prestamos.id_estudiante
JOIN Libros
ON Libros.id_libro = Prestamos.id_libro
JOIN Generos
ON Generos.id_genero = Libros.id_genero
WHERE titulo LIKE '%datos%'
	AND Generos.genero = 'Informatica';

--11. Listar los libros de la editorial “Alfa Omega”

SELECT titulo, editorial
FROM Libros
JOIN Libros_Editoriales
ON Libros.id_libro = Libros_Editoriales.id_libro
JOIN Editoriales
ON Editoriales.id_editorial = Libros_Editoriales.id_editorial
WHERE editorial = 'Alfa Omega';

--12. Listar los libros que pertenecen al autor “Mario Benedetti”

SELECT titulo, CONCAT(nombre, ' ', apellido) AS autor
FROM Libros
JOIN Libros_Autores
ON Libros.id_libro = Libros_Autores.id_libro
JOIN Autores
ON Autores.id_autor = Libros_Autores.id_autor
WHERE nombre = 'Mario' AND apellido = 'Benedetti';

--13. ¿Existen estudiantes que tengan el mismo nombre que un autor (solo el nombre)?

SELECT CONCAT(Estudiantes.nombre, ' ', Estudiantes.apellido) AS estudiante,
CONCAT(Autores.nombre, ' ', Autores.apellido) AS autor
FROM Estudiantes
JOIN Autores
ON Estudiantes.nombre = Autores.nombre;

--14. Listar nombre y apellido de los autores con sus correspondientes libros ordenados por area

SELECT nombre, apellido, titulo, genero
FROM Autores
JOIN Libros_Autores
ON Autores.id_autor = Libros_Autores.id_autor
JOIN Libros
ON Libros.id_libro = Libros_Autores.id_libro
JOIN Generos
ON Generos.id_genero = Libros.id_genero
ORDER BY genero;

--15. Listar area del libro, titulo del libro, Id del libro y fecha de prestamo (hacerlo a traves de la creación de una vista)

CREATE VIEW libros_prestados AS
SELECT genero, titulo, Libros.id_libro, fecha_prestamo
FROM Generos
JOIN Libros
ON Libros.id_genero = Generos.id_genero
JOIN Prestamos
ON Prestamos.id_libro = Libros.id_libro;


SELECT * FROM libros_prestados;

--16. Listar los titulos de los libros que debian devolverse el 10/04/12

SELECT titulo, fecha_expiracion
FROM Libros
JOIN Prestamos
ON Libros.id_libro = Prestamos.id_libro
WHERE fecha_expiracion = '2012/04/10';

--17. Hallar la suma de las edades de los estudiantes

SELECT SUM(edad) AS suma_edad
FROM Estudiantes;

--18. Hallar el promedio de edad de los estudiantes

SELECT AVG(edad) AS promedio_edad
FROM Estudiantes;

--19. Listar el nombre y el apellido de los estudiantes cuya edad es mayor al promedio

SELECT nombre, apellido, edad
FROM Estudiantes
WHERE edad > (SELECT AVG(edad) FROM Estudiantes);

--20. Listar cedula del estudiante, nombre, apellido, carrera, Id del libro y fecha de prestamo (hacerlo a traves de una vista).

CREATE VIEW estudiantes_prestatarios AS
SELECT cedula, nombre, apellido, carrera, id_libro, fecha_prestamo
FROM Estudiantes
JOIN Carreras
ON Estudiantes.id_carrera = Carreras.id_carrera
JOIN Prestamos
ON Prestamos.id_estudiante = Estudiantes.id_estudiante;

SELECT * FROM estudiantes_prestatarios;