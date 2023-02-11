# Frases para compartir

Aplicación móvil desarrollada con Flutter ♥.
Te permite compartir imagenes y textos ademas de guardar
tus frases favoritas.  

## Requerimientos
Base de Datos SQLite:
Crear una base de datos SQLite con el nombre de phrases.db
Tablas
 category
 *Donde icon debe ser una url a una imagen
 phrase
 *Donde img debe ser una url a una imagen
Crear en la raíz del proyecto la siguiente estructura de directorios
assets/db y dentro agregar la base de datos creada.

## Caracteristicas principales
* Provider como manejador de estados
* Inyección de dependencias
* Base de Datos SQLite
* Manejo de Singleton
* Tema personalizado
* Rutas con nombre y con argumentos
* Uso de controllers
* Listas paginadas
* Buscador de frases con SearchDelegate
* Manejo de Streams
* Manejo de StatefulWidget y StatelessWidget
* Widgets personalizados y reutilizables
* Diseño responsivo para Tablet y Celulares en vertical y horitontal
* Modelos de Datos
* Compartir textos e imagenes
* Imports con rutas relativas y ordenados
* Bearer Files

## Paquetes utilizados
* sqflite
* path_provider
* like_button
* share_plus
* http
* cached_network_image
* pull_to_refresh
* provider
* flutter_launcher_icons
