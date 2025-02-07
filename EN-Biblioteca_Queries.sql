USE Biblioteca;

--1. List all data of the authors

SELECT id_autor AS AUTHOR_ID, nombre AS FIRST_NAME, apellido AS LAST_NAME, pais AS COUNTRY
FROM Autores
LEFT JOIN Paises
ON Autores.id_pais = Paises.id_pais;

--2. List the first name, last name, and age of the students

SELECT nombre AS FIRST_NAME, apellido AS LAST_NAME, edad AS AGE
FROM Estudiantes;

--3. Which students belong to the "Informatica" major?

SELECT nombre AS FIRST_NAME, apellido AS LAST_NAME, carrera AS MAJOR
FROM Estudiantes
JOIN Carreras
ON Estudiantes.id_carrera = Carreras.id_carrera
WHERE carrera = 'Informatica';

--4. List the first and last names of students whose names start with the letter "G"

SELECT nombre AS FIRST_NAME, apellido AS LAST_NAME
FROM Estudiantes
WHERE nombre LIKE 'G%';

--5. Who is the author of the book "Introducción a Visual Studio .NET"?

SELECT CONCAT(nombre, ' ', apellido) AS AUTHOR
FROM Autores
JOIN Libros_Autores
ON Autores.id_autor = Libros_Autores.id_autor
JOIN Libros
ON Libros.id_libro = Libros_Autores.id_libro
WHERE titulo = 'Introducción a Visual Studio .NET';

--6. Which authors are of American or French nationality?

SELECT CONCAT(nombre, ' ', apellido) AS AUTHOR, pais AS COUNTRY
FROM Autores
JOIN Paises
ON Autores.id_pais = Paises.id_pais
WHERE pais = 'Estados Unidos' OR pais = 'Francia';

--7. Which books do not belong to the "INTERNET" category?

SELECT titulo AS BOOK_TITLE, genero AS CATEGORY
FROM Libros
LEFT JOIN Generos
ON Libros.id_genero = Generos.id_genero
WHERE genero NOT LIKE 'INTERNET';

--8. Which book was borrowed by the reader "Raúl Valdez Alanes"?

SELECT titulo AS BOOK_TITLE, CONCAT(nombre, ' ', apellido) AS READER, fecha_prestamo AS LOAN_DATE
FROM Libros
JOIN Prestamos
ON Libros.id_libro = Prestamos.id_libro
JOIN Estudiantes
ON Estudiantes.id_estudiante = Prestamos.id_estudiante
WHERE nombre LIKE '%Raul%'
	AND apellido LIKE '%Valdez%'
	AND apellido LIKE '%Alanes%';

--9. List the first and last name of the youngest student

SELECT TOP 1 nombre AS FIRST_NAME, apellido AS LAST_NAME
FROM Estudiantes
ORDER BY edad;

--10. List the first and last names of students who borrowed books on "Base de Datos"

SELECT nombre AS FIRST_NAME, apellido AS LAST_NAME
FROM Estudiantes
JOIN Prestamos
ON Estudiantes.id_estudiante = Prestamos.id_estudiante
JOIN Libros
ON Libros.id_libro = Prestamos.id_libro
JOIN Generos
ON Generos.id_genero = Libros.id_genero
WHERE titulo LIKE '%datos%'
	AND Generos.genero = 'Informatica';

--11. List the books from the publisher "Alfa Omega"

SELECT titulo AS BOOK_TITLE, editorial AS PUBLISHER
FROM Libros
JOIN Libros_Editoriales
ON Libros.id_libro = Libros_Editoriales.id_libro
JOIN Editoriales
ON Editoriales.id_editorial = Libros_Editoriales.id_editorial
WHERE editorial = 'Alfa Omega';

--12. List the books written by the author "Mario Benedetti"

SELECT titulo AS BOOK_TITLE, CONCAT(nombre, ' ', apellido) AS AUTHOR
FROM Libros
JOIN Libros_Autores
ON Libros.id_libro = Libros_Autores.id_libro
JOIN Autores
ON Autores.id_autor = Libros_Autores.id_autor
WHERE nombre = 'Mario' AND apellido = 'Benedetti';

--13. Are there any students who have the same first name as an author (first name only)?

SELECT CONCAT(Estudiantes.nombre, ' ', Estudiantes.apellido) AS STUDENT,
CONCAT(Autores.nombre, ' ', Autores.apellido) AS AUTHOR
FROM Estudiantes
JOIN Autores
ON Estudiantes.nombre = Autores.nombre;

--14. List the first and last names of authors along with their corresponding books, ordered by category

SELECT nombre AS FIRST_NAME, apellido AS LAST_NAME, titulo AS BOOK_TITLE, genero AS CATEGORY
FROM Autores
JOIN Libros_Autores
ON Autores.id_autor = Libros_Autores.id_autor
JOIN Libros
ON Libros.id_libro = Libros_Autores.id_libro
JOIN Generos
ON Generos.id_genero = Libros.id_genero
ORDER BY genero;

--15. List the book category, book title, book ID, and loan date (through the creation of a view)

CREATE VIEW BORROWED_BOOKS AS
SELECT genero AS CATEGORY, titulo AS BOOK_TITLE, Libros.id_libro AS BOOK_ID, fecha_prestamo AS LOAN_DATE
FROM Generos
JOIN Libros
ON Libros.id_genero = Generos.id_genero
JOIN Prestamos
ON Prestamos.id_libro = Libros.id_libro;


SELECT * FROM BORROWED_BOOKS;

--16. List the titles of books that were due for return on 04/10/12

SELECT titulo AS BOOK_TITLE, fecha_expiracion AS EXPIRATION_DATE
FROM Libros
JOIN Prestamos
ON Libros.id_libro = Prestamos.id_libro
WHERE fecha_expiracion = '2012/04/10';

--17. Find the sum of the age of the students

SELECT SUM(edad) AS SUM_AGE
FROM Estudiantes;

--18. Find the average age of the students

SELECT AVG(edad) AS AGE_AVERAGE
FROM Estudiantes;

--19. List the first and last names of students whose age is above the average

SELECT nombre AS FIRST_NAME, apellido AS LAST_NAME, edad AS AGE
FROM Estudiantes
WHERE edad > (SELECT AVG(edad) FROM Estudiantes);

--20. List the student's personal ID, first name, last name, major, book ID, and loan date (through the creation of a view)

CREATE VIEW BORROWING_STUDENTS AS
SELECT cedula AS PERSONAL_ID, nombre AS FIRST_NAME, apellido AS LAST_NAME, carrera AS MAJOR, id_libro AS BOOK_ID, fecha_prestamo AS LOAN_DATE
FROM Estudiantes
JOIN Carreras
ON Estudiantes.id_carrera = Carreras.id_carrera
JOIN Prestamos
ON Prestamos.id_estudiante = Estudiantes.id_estudiante;

SELECT * FROM BORROWING_STUDENTS;