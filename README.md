# Practica 9
Rebeca Moreno González

## Objetivo

Entender los conceptos esenciales de administración: asignación de roles y permisos, copia de seguridad (backup) y recuperación, y planificación de recuperación ante desastres.

## Decisiones

En esta práctica trabajé con la administración de seguridad y recuperación de una base de datos en PostgreSQL utilizando la base de datos `empresa`, desarrollada en actividades anteriores. Para proteger la información, creé roles con diferentes niveles de acceso mediante las sentencias `CREATE ROLE`, `GRANT` y `REVOKE`. Se definió un rol de solo lectura llamado `lector` y un rol con permisos de consulta y modificación llamado `editor`, permitiendo controlar las operaciones que cada usuario podía realizar sobre las tablas de la base de datos.

Además, implementé una estrategia básica de respaldo y recuperación utilizando las herramientas `pg_dump` y `pg_restore` de PostgreSQL. Para ello, generé una copia de seguridad lógica de la base de datos y posteriormente la restauré en una nueva base denominada `empresa_recuperada`, verificando que tanto la estructura como los datos se recuperaran correctamente. Finalmente, diseñé un plan de recuperación que contempla la frecuencia de los respaldos, los tiempos de recuperación tolerables y los procedimientos necesarios para restaurar la operación del sistema en caso de fallo.

## Pruebas realizadas

**Para la actividad:**

- Creé los roles `lector` y `editor` para comprobar que PostgreSQL permitiera gestionar usuarios con diferentes niveles de acceso.
- Asigné permisos mediante la instrucción `GRANT` y verifiqué que los privilegios quedaran registrados correctamente utilizando consultas sobre `information_schema.role_table_grants`.
- Retiré permisos específicos con `REVOKE` para comprobar que ciertos usuarios ya no pudieran realizar determinadas operaciones sobre las tablas.
- Generé una copia de seguridad completa de la base de datos utilizando el comando `pg_dump`.
- Restauré el respaldo en una nueva base de datos mediante `pg_restore` para validar el proceso de recuperación.
- Consulté las tablas restauradas y sus registros para verificar que la información se hubiera recuperado correctamente.

**Para el reto:**

- Diseñé un plan de recuperación para la base de datos considerando posibles fallos de hardware, errores humanos y pérdida de información.
- Definí una frecuencia de respaldos diarios para garantizar la disponibilidad de los datos.
- Establecí un RPO de 24 horas para determinar la pérdida máxima de información aceptable.
- Establecí un RTO de 30 minutos como tiempo máximo permitido para restablecer el servicio.
- Documenté el procedimiento completo de restauración, incluyendo la creación de una nueva base de datos y la recuperación del respaldo generado.

## Errores

Uno de los principales errores que encontré durante la práctica fue:

```sql
ERROR: el rol "lector" ya existe
```
Este problema ocurrió porque el rol había sido creado anteriormente y PostgreSQL no permite crear dos roles con el mismo nombre. La solución consistió en eliminar el rol existente utilizando DROP ROLE IF EXISTS o reutilizar el rol ya creado para continuar con la práctica.
También surgieron dificultades al ejecutar los comandos pg_dump y pg_restore, ya que inicialmente la terminal no reconocía dichos comandos. El problema se debía a que la carpeta bin de PostgreSQL no estaba agregada a la variable de entorno PATH de Windows. Después de agregar la ruta correspondiente, fue posible utilizar las herramientas de respaldo y restauración desde la línea de comandos.

## Conclusión

En esta práctica aprendí a implementar mecanismos básicos de seguridad y recuperación en PostgreSQL, comprendiendo la importancia de controlar los permisos de acceso a la información mediante roles y privilegios. También aprendí a generar copias de seguridad y restaurarlas utilizando las herramientas proporcionadas por PostgreSQL, lo que me permitió entender cómo proteger los datos frente a posibles fallos o pérdidas de información.

