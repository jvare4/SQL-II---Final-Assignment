CREATE DATABASE Biblioteca;

USE Biblioteca;

CREATE TABLE  Generos (
	id_genero int,
	genero varchar(30) NOT NULL,
	CONSTRAINT pk_Generos PRIMARY KEY (id_genero),
	CONSTRAINT unique_genero UNIQUE (genero) );

CREATE TABLE Libros (
	id_libro int,
	titulo varchar(90) NOT NULL,
	año int,
	id_genero int,
	CONSTRAINT pk_Libros PRIMARY KEY (id_libro),
	CONSTRAINT fk_Lib__Gen FOREIGN KEY (id_genero) REFERENCES Generos );

CREATE TABLE Carreras (
	id_carrera int,
	carrera varchar(30) NOT NULL,
	CONSTRAINT pk_Carreras PRIMARY KEY (id_carrera),
	CONSTRAINT unique_carrera UNIQUE (carrera) );

CREATE TABLE Estudiantes (
	id_estudiante int,
	cedula varchar(9),
	nombre varchar(30) NOT NULL,
	apellido varchar (30),
	edad tinyint,
	genero varchar(1),
	direccion varchar(60),
	telefono varchar(8) NOT NULL,
	id_carrera int,
	CONSTRAINT pk_Estudiantes PRIMARY KEY (id_estudiante),
	CONSTRAINT fk_Est__Car FOREIGN KEY (id_carrera) REFERENCES Carreras );

CREATE TABLE Prestamos (
	id_prestamo int,
	id_libro int NOT NULL,
	id_estudiante int NOT NULL,
	fecha_prestamo date NOT NULL,
	devuelto bit NOT NULL,
	fecha_devolucion date,
	fecha_expiracion date NOT NULL,
	CONSTRAINT pk_Prestamos PRIMARY KEY (id_prestamo),
	CONSTRAINT fk_Pre__Lib FOREIGN KEY (id_libro) REFERENCES Libros,
	CONSTRAINT fk_Pre__Est FOREIGN KEY (id_estudiante) REFERENCES Estudiantes );

CREATE TABLE Paises (
	id_pais int,
	pais varchar (20) NOT NULL,
	CONSTRAINT pk_Paises PRIMARY KEY (id_pais),
	CONSTRAINT unique_pais UNIQUE (pais) );

CREATE TABLE Autores (
	id_autor int,
	nombre varchar(30) NOT NULL,
	apellido varchar(30) NOT NULL,
	id_pais int,
	CONSTRAINT pk_Autores PRIMARY KEY (id_autor),
	CONSTRAINT fk_Aut__Pai FOREIGN KEY (id_pais) REFERENCES Paises );

CREATE TABLE Libros_Autores (
	id_libro int,
	id_autor int,
	CONSTRAINT pk_Lib_Aut PRIMARY KEY (id_libro, id_autor),
	CONSTRAINT fk_Lib_Aut__Lib FOREIGN KEY (id_libro) REFERENCES Libros,
	CONSTRAINT fk_Lib_Aut__Aut FOREIGN KEY (id_autor) REFERENCES Autores );

CREATE TABLE Editoriales (
	id_editorial int,
	editorial varchar(30) NOT NULL,
	id_pais int NOT NULL,
	CONSTRAINT pk_Editoriales PRIMARY KEY (id_editorial),
	CONSTRAINT unique_editorial UNIQUE (editorial),
	CONSTRAINT fk_Edi__Pai FOREIGN KEY (id_pais) REFERENCES Paises );

CREATE TABLE Libros_Editoriales (
	id_libro int,
	id_editorial int,
	CONSTRAINT pk_Lib_Edi PRIMARY KEY (id_libro, id_editorial),
	CONSTRAINT fk_Lib_Edi__Lib FOREIGN KEY (id_libro) REFERENCES Libros,
	CONSTRAINT fk_Lib_Edi__Edi FOREIGN KEY (id_editorial) REFERENCES Editoriales );