/* 
-----------------------------------------------------------------------------------------------------------------------------------

   INGENIER�A INFORM�TICA � SISTEMAS DE BASES DE DATOS - EJERCICIO SQL

   Un Instituto de Capacitaci�n decide sistematizar sus actividades acad�micas. 
   Del an�lisis de requerimientos se obtuvo lo siguiente:

   - Para cada curso se requiere:
     - Un c�digo de 4 letras que lo identifica
	 - Denominaci�n del curso
	 - Fecha de inicio
	 - Duraci�n en horas (entre 4 y 48)
	 - Cupo total (entre 10 y 100)
	 - Cupo por grupo (entre 10 y 20) (cupo por grupo debe ser menor o igual al cupo total)
	 - Arancel (con decimales > 0.00)

   - Para cada alumno se requiere:
     - Nro. de legajo (�nico y > 0)
	 - Nro. de documento de identidad (�nico)
	 - Apellido
	 - Nombre
	 - Domicilio (no obligatorio) 
	 - Tel�fonos

   - Para cada docente se requiere:
     - Nro. de legajo (�nico y > 0)
	 - Nro. de documento de identidad (�nico)
	 - Apellido
	 - Nombre

   - Otras consideraciones:
     - Un alumno puede inscribirse en varios cursos, pero solo en un grupo por curso
     - Seg�n la cantidad de inscriptos, el curso se puede dividir en m�s de un grupo
     - Cada grupo puede estar a cargo de uno o m�s docentes
     - Cada docente puede estar designado en diferentes grupos
     - Cada grupo se identifica con un nro. correlativo por curso y tiene un horario semanal 
	   determinado que puede incluir uno o m�s d�as de la semana. Por ejemplo: lunes de 18 a 21 y s�bados de 9 a 12
     - El horario del curso se representa a trav�s del d�a de la semana (entre 2 y 7), hora de inicio y hora de fin 
	   (usar tipo de dato time), donde la hora de inicio debe ser menor a la de fin)
	 - Si se elimina el grupo, se deben eliminar autom�ticamente los horarios del mismo

   Se dise�� una base de datos cuyo modelo de datos se adjunta.

-----------------------------------------------------------------------------------------------------------------------------------

   SE SOLICITA:

   1. Programar un script para la creaci�n de todas las tablas con todas las reglas de integridad declarativas (clave primaria,
      claves alternativas, claves for�neas y checks)

   2. Programar un script con inserci�n de datos en las tablas creadas

   3. Agregar la columna cant_alumnos a la tabla grupos y programar una sentencia de actualizaci�n de 
      esa columna

   4. Eliminar los grupos que no tienen alumnos inscriptos y docentes designados

   5. Programar una consulta que muestre los grupos que tienen m�s cantidad de alumnos que el cupo m�ximo por grupo
   
   6. Programar una consulta que muestre los cursos y grupos que se dictan SOLO los d�as mi�rcoles entre las 17 y las 20 horas 
      (aunque ocupen una parte de ese horario) y que tengan m�s de 3 alumnos inscriptos

-----------------------------------------------------------------------------------------------------------------------------------
*/


CREATE TABLE cursos {
   cod_curso VARCHAR(4) NOT NULL,
   nom_curso VARCHAR(50) NOT NULL,
   fecha_inicio DATE NOT NULL,
   duracion INT NOT NULL,
   cupo_total INT NOT NULL,
   cupo_grupo INT NOT NULL,
   arancel DECIMAL(5,2) NOT NULL,
   PRIMARY KEY (cod_curso),
}

CREATE TABLE grupos{
   cod_curso VARCHAR(4) NOT NULL,
   nro_grupo INT NOT NULL,
   PRIMARY KEY (cod_curso, nro_grupo),
   FOREIGN KEY (cod_curso) REFERENCES cursos(cod_curso) ON DELETE CASCADE
}

CREATE TABLE alumnos_grupos{
   cod_curso VARCHAR(4) NOT NULL,
   nro_grupo INT NOT NULL,
   nro_alumno INT NOT NULL,
   PRIMARY KEY (cod_curso, nro_alumno),
   FOREIGN KEY (cod_curso, nro_grupo, nro_alumno) REFERENCES grupos(cod_curso, nro_grupo) ON DELETE CASCADE
}

CREATE TABLE alumnos{
   nro_alumno INT NOT NULL,
   nro_documento INT NOT NULL,
   apellido VARCHAR(50) NOT NULL,
   nombre VARCHAR(50) NOT NULL,
   domicilio VARCHAR(50) NULL,
   telefono VARCHAR(50) NULL,
   PRIMARY KEY (nro_alumno),
}

CREATE TABLE horarios_grupos{
   cod_curso VARCHAR(4) NOT NULL,
   nro_grupo INT NOT NULL,
   nro_horario INT NOT NULL,
   dia INT NOT NULL,
   hora_inicio TIME NOT NULL,
   hora_fin TIME NOT NULL,
   PRIMARY KEY (cod_curso, nro_grupo, nro_horario),
   FOREIGN KEY (cod_curso, nro_grupo) REFERENCES grupos(cod_curso, nro_grupo) ON DELETE CASCADE
}

CREATE TABLE docentes{
   nro_docente INT NOT NULL,
   nro_documento INT NOT NULL,
   apellido VARCHAR(50) NOT NULL,
   nombre VARCHAR(50) NOT NULL,
   PRIMARY KEY (nro_docente),
}

CREATE TABLE docentes_grupos{
   cod_curso VARCHAR(4) NOT NULL,
   nro_grupo INT NOT NULL,
   nro_docente INT NOT NULL,
   PRIMARY KEY (cod_curso, nro_grupo, nro_docente),
   FOREIGN KEY (cod_curso, nro_grupo, nro_docente) REFERENCES docentes(cod_curso, nro_grupo) ON DELETE CASCADE
}