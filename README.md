![Cabecera. Evaluacion Final Modulo 2. Elena Águila Garcia](https://github.com/eaguilag/testing-git/blob/main/assets/elena-aguila-cabecera-evaluacion-modulo-2.png)
# EVALUACIÓN FINAL MÓDULO 2
*Elena Águila García* [@eaguilag](https://github.com/eaguilag)

## INTRODUCCIÓN

Ejercicio de evaluación final del **Módulo 2** del Bootcamp de **Análisis de Datos**. Durante este módulo se ha profundizado en diversas técnicas de extracción de datos utilizando Python y SQL. Este ejercicio tiene el objetivo interactuar con bases de datos relacionales utilizando SQL para realizar consultas y extraer datos relevantes.

## ANTES DE EMPEZAR

### Requisitos del Sistema

- **Sistema Operativo**: Windows, macOS, Linux

- **Software**:
  - MySQL Workbench 8.0+
  - MySQL Server 8.0+
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

Una vez instalado y configurado lo necesario, se recomienda tener una visión general de con qué base de datos se vaa trabajar:

### Sakila Database:

Para este ejercicio se ha utilizado Sakila, una base de datos de ejemplo que simula una tienda de alquiler de películas. Estas tablas contienen información sobre películas, actores, clientes, alquileres y más, y se utilizan para realizar consultas y análisis de datos en el contexto de una tienda de alquiler de películas.

Esta base de datos contiene tablas como `film` (películas), `actor` (actores), `customer` (clientes), `rental` (alquileres), `category` (categorías), entre otras. Para ver la relación entre las diferentes tablas y sus atributos, podemos emplear el proceso de ingeniería inversa para obtener un diagrama de flujo:

![Diagrama de BBDD Sakila](https://github.com/eaguilag/testing-git/blob/main/assets/diagrama-sakila.jpg)

## HORA DE CONSULTAR

Para realizar un análisis de los

### Objetivos

Este proyecto tiene como próposito demostrar cómo realizar consultas SQL en la base de datos Sakila utilizando MySQL Workbench. Se marcan como objetivos:

- Dominar las queries básicas: SELECT; UPDATE; DELETE; INSERT
- Dominar las funciones `group by`, `where` y `having`.
- Dominar el uso de joins (incluyendo `union` y `union all`)
- Dominar el uso de subconsultas.
- Dominar el uso de las subconsultas correlacionadas
- CTE’s

### Pasos para ejecutar el fichero

1. Abrir el archivo desde MySQL Workbench una vez estoy conectada al servido: File > Open SQL Script

2. Asegurarse que tienes Sakila ejecutando `USE sakila`

3. Seleccionar la consulta que quieres hacer y ejecutar la query para ver los resultados

## ENTENDIENDO EL FICHERO

El ejercicio de evaluación se encuentra en un SQL script dentro del repositorio. El archivo está nombrado como [bda-modulo-2-evaluacion-final-promo-angela-elena-aguila.sql](https://github.com/Adalab/bda-modulo-2-evaluacion-final-eaguilag/blob/main/bda-modulo-2-evaluacion-final-promo-angela-elena-aguila.sql) y se estructura de la siguiente forma:

- Enunciado del ejercicio de evaluación provisto por Adalab (como comentario).

- Query correspondiente a cada enunciado del ejercicio. La query viene acompañada de comentarios cuando se considera necesario.

- Número de resultados devueltos por la consulta que, aunque no confirma directamente que la consulta es correcta, puede servir de guía para saber si está bien encaminada.

    ```sql
    -- 1.
    /* Selecciona todos los nombres de las películas
    sin que aparezcan duplicados. */

    SELECT DISTINCT title -- uso la clausula 'DISTINCT' para seleccionar varoles unicos
    FROM film
    ORDER BY title; -- organizo los resultados con la clausula 'ORDER BY' para visualizar los datos de manera efectiva
    -- 1000 rows returned
    ```