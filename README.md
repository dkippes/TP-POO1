# TP-POO1
Proyecto final de Progracion Orientada a Objetos


 - Que el archivo de texto cuando sea editado pise el valor previo.
 - Utilizamos comandos reales como mensajes para crear acciones en los test. <- Incluir en el informe.
 - Filtramos Archivos en el directorio actual [OK-Parcial]. Faltan filtrar archivos por permiso dados y combinar los filtros(texto, date y permisos)[Falta].
 - Ponerle permisos a los archivos.
 - Filtrar por usuarios.
 - Fijarse si un archivo le pertenece a un usuario(que es el usuario dado por colaborador externo).
 - Los permisos los manejamos como listas(una lista para usuarios de escritura, otro para lectura y otro para ejecución).
 - Estamos filtrando por usuario logueado
 - El dilema es: Si el usuario logueado es root o es el creador del archivo, este no se agrega a la lista de permisos, pero en la parte de los filtros devolvemos la    lista completa para los usuarios que son root, y no hacemos la distinción de los tipos de permisos.

23/11: 
Completamos toda la parte de los filtros de las colecciones.

30/11:
-Se arreglaron parte de las correcciones que Gastón nos remarcó.
-Falta ponerle dueño a los archivos, es decir: Inicializar el archivo con el user creador.
-Falta cambiar el nombre a la clase padre "SistemaDeArchivos" por algo parecido a Archivos.
-Falta ver el tema de las excepciones/contratos que Gastón nos remarcó.
-Falta hacer refactor en los metodos de cada clase.
-Sacar el mensaje "isNil" y cambiarlo por otro que responda algo parecido a ese mensaje.

02/12:

-Para el agregado de streams: 
root: 
carpeta1  lectura  [Pepito, Laura] |escritura  [Pepito, Juancito]| 

-rm: <= tiene que borrar una carpeta.

