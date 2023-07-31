# Proyecto_Blockbuster-SQL

![Blockbuster-Emblem](https://github.com/borjadola/Proyecto_Pandas_SQL/assets/132678800/73e1810c-d1ee-4ce2-9157-1b91f215f4f3)

## Objetivo:

Realización de una base de datos relacional en SQL para la reapertura de una tienda de alquiler de películas. Disponemos, por parte del cliente, de alguna base de datos parcial del año 2006.

## Metodología:

1. Visulaización de las tablas de la base de datos parcial de la que disponemos por parte del cliente.
2. Realización del DER para ver la estructura de nuestra tabla y las relaciones entre ellas.
3. Limpieza de las base de datos proporcionada.
4. Ajuste del DER y creación de la base de datos
5. Envío de la información de la base de datos antigua a la nueva.

## Realización:

1. En un primer lugar he realizado un primer análisis visual de las tablas que nos han proporcionado, para ver la clase de datos, la coherencia de estos entre las tablas y su estructura.

   Se puede ver que los datos son bastante consistentes y no hay apenas duplicidad ni valores nulos. Encuentro tablas con datos de nombre de películas y actores, así como información sobre estos, y columnas en varias tablas que hacen referencia a la relación entre estas por medio de ID.
   
   <<img width="383" alt="Ej tabla_1" src="https://github.com/borjadola/Proyecto_Pandas_SQL/assets/132678800/f5e03baf-cec7-418e-ae02-1b4ec93d2c9b">
   
   Ejemplo de tipo de tabla que nos encontramos en la base de datos proporcionada.

2. Una vez repasadas las tablas proporcionadas y la información que contienen, pasamos a esquematizar un Diagrama Entidad Relación (DER) en mysql.

   Este diagrama lo he hecho en base a un solo establecimiento. Si en el futuro se abriesen más, habría que añadir nuevas tablas y relaciones. Paso a mostrar el diagrama y comento. Los tipos de datos por columna están programados en base a la información que vamos a subir desde Pandas.

   <img width="837" alt="DER" src="https://github.com/borjadola/Proyecto_Pandas_SQL/assets/132678800/2b0561f2-845d-4c4b-9a5d-009938092454">

   Tenemos las siguientes tablas:

   - Actor: tabla donde veremos el nombre completo del actor y su id. Tiene una relación n:m con films por medio de la tabla film_actor.
   - Films: tabla donde encontraremos el nombre de las películas y la información relevante de estas. A parte de la relación con la tabla actor a través de film_actor, contiiene dos claves foráneas de category y language. Esta realción es 1:n en ambas, pues puede haber varias películas con un idioma y una categoría. 
   - film_actor: esta tabla viene originalmente de los datos proporcionados con nombre Old_HDD. Una vez revisada y extraida la información que es útil, la he convertido en tabla relacional para films y actor (lo veremos con más detalle en el análisis con pandas).
   - Category: tabla relacionada, junto con language, con la de film.
   - Language: lo dicho antes.
   - Customer: pasando a la segunda parte de la estructura de nuestra base de datos, empezamos con customer. La hemos creado de cero para contenter datos relevantes de cada cliente de la tienda.
   - Inventory: inventario que hay por película. Tiene también relación 1:n con rental, pues una película del inventario puede aparecer varias veces en rental.
   - Rental: relaciona 1:n los clientes, el inventario de peliculas y el dependiente. Un dependiente puede aparecer varias veces en rental, así como, un cliente también aparecerá varias veces en rental (alquila varias películas), e inventario también de la misma forma.
   - Staff: tabla sencilla, puede ampliarse y relacionarse dependiendo de cómo crezca el negocio.

3. Pasamos entonces a la limpieza de datos de la base de datos proporcionada y estructurarla de la misma forma que tenemos nuestro DER. Espongo la operaciones principales que he realizado con Pandas.

   Primeramente he tomado la determinación de borrar la columna 'last_update' de cada tabla donde aparecía por dos motivos, primero por ver que el dato proporcionado estaba repetido en todas la columnas y no daba información relevante, y segundo por no ver necesario esa columna en ninguna de las tablas proporcionadas. Sin embargo, si veía necesario esa columna, y así la he añadido, para customer. En esa tabla vería bien la introducción de la fecha de alta de un cliente para posteriormente usarla como estudio para la viabilidad económica del negocio, básicamente ver el número de clientes dados de alta a lo largo del tiempo.

   La columna de 'first_name' y 'last_name' las he sustituido por 'name' a secas con el full name de actores para poder trabajar con esa columna de una manera más fácil al relacionarla con otros id. Borramos de aquí una actriz que posee dos id (como son nonbres inventados no podemos saber si existen dos 'Susan Davies').

   Primera relación de id´s. Relacionamos los id de 'Category' con sus películas en la tabla de 'film_actor' (Old_HDD) traspasamos estos datos, mediante un diccionario, a la tabla de 'Films'. Como había películas que no tenían categoría, y esto nos puede dar un error al subir los datos a SQL, tomo la decisión de añadir un valor nuevo a 'Category'; id 0 y categoría 'no category'. Recorremos la columna creada 'category_id' de 'Films' e introducimos las categorías a cada película, proporcionando 0 a las que no tienen. Dejo una imagen del código.

   <img width="993" alt="Ej tabla_2" src="https://github.com/borjadola/Proyecto_Pandas_SQL/assets/132678800/f080c3a3-b78a-43ad-b3c1-4726b46b6e5c">

   <img width="1001" alt="Ej tabla_3" src="https://github.com/borjadola/Proyecto_Pandas_SQL/assets/132678800/2a5d0c1b-1727-4772-8709-fd4a9adcde22">

   <img width="997" alt="Ej tabla_4" src="https://github.com/borjadola/Proyecto_Pandas_SQL/assets/132678800/bd2b0ff7-369c-4213-a9de-82781d30a5b0">
   
   La segunda relación de id´s será para construir la tabla relación entre 'Films' y 'Actor'. Construimos nuestros diccionarios de actor y su id y de películas con su id y los volvamos en las columnas creadas en film_actor. Esta tabla le dejaremos como estructura estas dos columnas únicamente, pues el resto ya nos nos sirve aquí, ya tenemos es información en otras columnas.

   <img width="572" alt="Ej tabla_5" src="https://github.com/borjadola/Proyecto_Pandas_SQL/assets/132678800/fe8f7c68-132c-43fb-8921-4bcf38f32ed1">

   <img width="151" alt="Ej tabla_6" src="https://github.com/borjadola/Proyecto_Pandas_SQL/assets/132678800/7d436cbc-19bc-40a5-9475-a507cc60effe">

4. Para finalizar la limpieza hago una reestructuración del orden y número de columnas por tabla para que sea igual que en el DER.

5. Ahora sí, tenemos los datos preparados para hacer la migración a nuestra base de datos SQL. He elegido hacerlo con ALQUEMY por la facilidad que tiene para crear el cursos y subir los datos.

  <img width="1006" alt="E tabla_7" src="https://github.com/borjadola/Proyecto_Pandas_SQL/assets/132678800/64f2a741-045e-455f-81ad-d7514ec24fe4">

## Conclusión:

Finalizada la exportación de datos de pandas a mySQL ya tenemos nuestra base de datos construida. Como ya he dicho, esta estructura es para una sola tienda y una estructura básica. Si el negocio se va a ampliar, aumento del número de clientes y de registros introducidos en base de datos, podemos crear nuevas tablas a partir de columnas de otras para clasificar mejor la información y crear índices que hagan que cuando queramos buscar un dato se nos muestre de una forma más rápida. Por ejemplo, también introducir una tabla de métodos de pago para registrar las formas de pago de rental, o una de store para registrar nuevas tiendas.

## Consulta de nuestra base de datos:

- Número de películas por categoría.
  
  <img width="158" alt="query1" src="https://github.com/borjadola/Proyecto_Pandas_SQL/assets/132678800/bc15b499-b83f-4010-896a-87fcec317fff">

- Títulos por duración.

  <img width="179" alt="query2" src="https://github.com/borjadola/Proyecto_Pandas_SQL/assets/132678800/06b17e54-fd82-4c24-864d-774739f96faf">
  
