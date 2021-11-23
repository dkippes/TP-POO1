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
