![Cabecera. Evaluacion Final Modulo 2. Elena Águila Garcia](https://github.com/eaguilag/testing-git/blob/main/assets/elena-aguila-cabecera-evaluacion-modulo-2.png)
# EVALUACIÓN FINAL MÓDULO 2
*Elena Águila García* [@eaguilag](https://github.com/eaguilag)

## INTRODUCCIÓN

Ejercicio de evaluación final del **Módulo 2** del Bootcamp de **Análisis de Datos**. Durante este módulo se ha profundizado en diversas técnicas de extracción de datos utilizando Python y SQL. Este ejercicio tiene el objetivo interactuar con bases de datos relacionales utilizando SQL para realizar consultas y extraer datos relevantes.

## ANTES DE EMPEZAR

### Requisitos del Sistema

- **Sistema Operativo**: Windows, macOS o Linux

- **Software**:
  - MySQL Workbench
  - MySQL Server
  - Sakila Database

###  Instalación de MySQL Workbench y MySQL Server

1. Descargar e instalar [MySQL Workbench](https://dev.mysql.com/downloads/workbench/)

2. Descargar e instalar [MySQL Server](https://dev.mysql.com/downloads/mysql/)

### Configuración de la Base de Datos Sakila

1. Descargar la [base de datos Sakila](https://dev.mysql.com/doc/sakila/en/)

2. Importar la base de datos Sakila:
   - Abrir MySQL Workbench.
   - Conectar a tu servidor MySQL.
   - Ir a **File > Run SQL Script** y seleccionar el archivo `sakila-schema.sql`.
   - Ejecutar el script para crear la estructura de la base de datos.
   - Repetir el proceso para `sakila-data.sql` para importar datos.

### Conexión a la Base de Datos

1. Abrir MySQL Workbench.

2. Crear una nueva conexión o conectarte a una existente:
   - **Host**: `localhost`
   - **Puerto**: `3306`
   - **Nombre de Usuario**: `root`
   - **Contraseña**: tu contraseña
   - **Esquema de la Base de Datos**: `sakila`

## LA PUESTA A PUNTO

Una vez instalado y configurado lo necesario, se recomienda tener una visión general de los datos con los que se va a trabajar:

### Sakila Database:

Para este ejercicio se ha utilizado Sakila, una base de datos de ejemplo que simula una tienda de alquiler de películas. Contiene tablas como `film` (películas), `actor` (actores), `customer` (clientes), `rental` (alquileres), `category` (categorías), entre otras. Para ver la relación entre las diferentes tablas, sus atributos, las `PRIMARY KEY`y las `FOREIGN KEY`, o los tipos de datos, podemos emplear el proceso de ingeniería inversa para obtener un diagrama de flujo:

![Diagrama de BBDD Sakila](https://github.com/eaguilag/testing-git/blob/main/assets/diagrama-sakila.JPG)

## HORA DE CONSULTAR

Las tablas de la base de datos Sakila contienen información sobre películas, actores, clientes, alquileres y más, y se utilizan para realizar consultas y análisis de datos en el contexto de una tienda de alquiler de películas.

### Objetivos

Este proyecto tiene como próposito demostrar cómo realizar consultas SQL en la base de datos Sakila utilizando MySQL Workbench. Se marcan como objetivos:

- Dominar las queries básicas: `SELECT`, `UPDATE`, `DELETE`, `INSERT`.
- Dominar las funciones `GROUP BY`, `WHERE` y `HAVING`.
- Dominar el uso de `JOIN` (incluyendo `UNION` y `UNION ALL`).
- Dominar el uso de subconsultas.
- Dominar el uso de las subconsultas correlacionadas.
- CTE’s.

### Pasos para ejecutar el fichero

1. Una vez conectada a la base de datos en MySQL Workbench, ir a **File > Open SQL Script** y seleccionar el archivo de este repositorio previamente descargado.

2. Asegurarse que estás usando el esquema Sakila ejecutando `USE sakila`.

3. Seleccionar la consulta que quieres hacer y ejecutar el script para ver los resultados de la query.

## ENTENDIENDO EL FICHERO

El ejercicio de evaluación se encuentra en un SQL script dentro del repositorio. El archivo está nombrado como [bda-modulo-2-evaluacion-final-promo-angela-elena-aguila.sql](https://github.com/Adalab/bda-modulo-2-evaluacion-final-eaguilag/blob/main/bda-modulo-2-evaluacion-final-promo-angela-elena-aguila.sql) y se estructura de la siguiente forma:

- Enunciado del ejercicio de evaluación provisto por Adalab (como comentario).

- Query o consulta correspondiente a cada enunciado. La query viene acompañada de comentarios cuando se considera necesario o para mostrar que se tiene conocimiento de los métodos empleados.

- Número de resultados devueltos por la consulta que, aunque no confirma directamente que la consulta es correcta, puede servir de guía para saber si está bien encaminada a la hora de corregir.

    ```sql
    -- 1. Selecciona todos los nombres de las películas sin que aparezcan duplicados.

    SELECT DISTINCT title -- uso la clausula 'DISTINCT' para seleccionar varoles unicos
    FROM film
    ORDER BY title; -- organizo los resultados con la clausula 'ORDER BY' para visualizar los datos de manera efectiva
    -- 1000 rows returned
    ```

## INSTRUCTORA DEL MÓDULO

Agradecimientos por la impartición del módulo y la evaluación a cargo de la instructora Almu Hernández @almuher