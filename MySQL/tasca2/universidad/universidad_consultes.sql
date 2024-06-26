USE universidad;

-- 1. Retorna un llistat amb el primer cognom, segon cognom i el nom de tots els/les alumnes. El llistat haurà d'estar ordenat alfabèticament de menor a major pel primer cognom, segon cognom i nom.
SELECT apellido1, apellido2, nombre FROM persona
WHERE tipo='alumno' ORDER BY apellido1, apellido2, nombre;

-- 2. Esbrina el nom i els dos cognoms dels alumnes que no han donat d'alta el seu número de telèfon en la base de dades.
SELECT nombre, apellido1, apellido2 FROM persona
WHERE tipo='alumno' AND telefono IS NULL;

-- 3. Retorna el llistat dels alumnes que van néixer en 1999.
SELECT * FROM persona
WHERE tipo='alumno' AND YEAR(fecha_nacimiento) = 1999;

-- 4. Retorna el llistat de professors/es que no han donat d'alta el seu número de telèfon en la base de dades i a més el seu NIF acaba en K.
SELECT * FROM persona WHERE tipo='profesor'
AND telefono IS NULL AND nif LIKE '%K';

-- 5. Retorna el llistat de les assignatures que s'imparteixen en el primer quadrimestre, en el tercer curs del grau que té l'identificador 7.
SELECT * FROM  asignatura WHERE cuatrimestre=1
AND curso=3 AND id_grado=7;

-- 6. Retorna un llistat dels professors/es juntament amb el nom del departament al qual estan vinculats. El llistat ha de retornar quatre columnes, primer cognom, segon cognom, nom i nom del departament. El resultat estarà ordenat alfabèticament de menor a major pels cognoms i el nom.
SELECT p.apellido1, p.apellido2, p.nombre, d.nombre AS nombre_departamento FROM persona p
INNER JOIN profesor pr ON p.id = pr.id_profesor
INNER JOIN departamento d ON pr.id_departamento = d.id
ORDER BY p.apellido1, p.apellido2, p.nombre; 

-- 7. Retorna un llistat amb el nom de les assignatures, any d'inici i any de fi del curs escolar de l'alumne/a amb NIF 26902806M.
SELECT a.nombre, c.anyo_inicio, c.anyo_fin FROM asignatura a
INNER JOIN alumno_se_matricula_asignatura am ON a.id=am.id_asignatura
INNER JOIN curso_escolar c ON am.id_curso_escolar=c.id
INNER JOIN persona p ON am.id_alumno=p.id
WHERE p.nif='26902806M';

-- 8. Retorna un llistat amb el nom de tots els departaments que tenen professors/es que imparteixen alguna assignatura en el Grau en Enginyeria Informàtica (Pla 2015).
SELECT DISTINCT d.nombre FROM departamento d
INNER JOIN profesor pr ON d.id = pr.id_departamento
INNER JOIN asignatura a ON pr.id_profesor = a.id_profesor
INNER JOIN grado g ON a.id_grado = g.id
WHERE g.nombre = 'Grado en Ingeniería Informática (Plan 2015)';

-- 9. Retorna un llistat amb tots els alumnes que s'han matriculat en alguna assignatura durant el curs escolar 2018/2019.
SELECT DISTINCT p.nombre, p.apellido1, p.apellido2 FROM persona p
INNER JOIN alumno_se_matricula_asignatura am ON p.id=am.id_alumno
INNER JOIN curso_escolar c ON am.id_curso_escolar=c.id
WHERE c.anyo_inicio = 2018 AND c.anyo_fin = 2019;

-- CONSULTES AMB LEFT JOIN i RIGHT JOIN:

-- 1. Retorna un llistat amb els noms de tots els professors/es i els departaments que tenen vinculats. El llistat també ha de mostrar aquells professors/es que no tenen cap departament associat. El llistat ha de retornar quatre columnes, nom del departament, primer cognom, segon cognom i nom del professor/a. El resultat estarà ordenat alfabèticament de menor a major pel nom del departament, cognoms i el nom.
SELECT d.nombre AS nombre_departamento, p.apellido1, p.apellido2, p.nombre FROM persona p
LEFT JOIN profesor pr ON p.id = pr.id_profesor
LEFT JOIN departamento d ON pr.id_departamento = d.id
WHERE p.tipo = 'profesor'
ORDER BY d.nombre, p.apellido1, p.apellido2, p.nombre;

-- 2. Retorna un llistat amb els professors/es que no estan associats a un departament.
SELECT d.nombre AS nombre_departamento, p.apellido1, p.apellido2, p.nombre FROM persona p
LEFT JOIN profesor pr ON p.id = pr.id_profesor
LEFT JOIN departamento d ON pr.id_departamento = d.id
WHERE p.tipo = 'profesor' AND pr.id_departamento IS NULL;

-- 3. Retorna un llistat amb els departaments que no tenen professors/es associats.
SELECT nombre FROM departamento
WHERE id NOT IN (SELECT DISTINCT id_departamento FROM profesor);

SELECT d.nombre FROM departamento d
LEFT JOIN profesor pr ON d.id = pr.id_departamento
WHERE pr.id_profesor IS NULL;

-- 4. Retorna un llistat amb els professors/es que no imparteixen cap assignatura.
SELECT p.apellido1, p.apellido2, p.nombre FROM persona p
INNER JOIN profesor pr ON p.id = pr.id_profesor
LEFT JOIN asignatura a USING(id_profesor)
WHERE a.id IS NULL;

-- 5. Retorna un llistat amb les assignatures que no tenen un professor/a assignat.
SELECT a.nombre, pr.id_profesor FROM asignatura a
LEFT JOIN profesor pr ON a.id_profesor = pr.id_profesor
WHERE pr.id_profesor IS NULL;

-- 6. Retorna un llistat amb tots els departaments que no han impartit assignatures en cap curs escolar.
SELECT d.nombre FROM departamento d
LEFT JOIN profesor p ON d.id = p.id_departamento
LEFT JOIN asignatura a ON p.id_profesor = a.id_profesor
WHERE a.id IS NULL;

-- CONSULTES RESUM:

-- 1. Retorna el nombre total d'alumnes que hi ha.
SELECT COUNT(*) AS total_alumnes FROM persona 
WHERE tipo = 'alumno';

-- 2. Calcula quants alumnes van néixer en 1999.
SELECT COUNT(*) AS alumnes_nascuts_1999 FROM persona
WHERE tipo = 'alumno' AND YEAR(fecha_nacimiento) = 1999;

-- 3. Calcula quants professors/es hi ha en cada departament. El resultat només ha de mostrar dues columnes, una amb el nom del departament i una altra amb el nombre de professors/es que hi ha en aquest departament. El resultat només ha d'incloure els departaments que tenen professors/es associats i haurà d'estar ordenat de major a menor pel nombre de professors/es.
SELECT d.nombre AS departamento, COUNT(p.id_profesor) AS numero_profes
FROM departamento d
INNER JOIN profesor p ON d.id = p.id_departamento
GROUP BY d.nombre
ORDER BY numero_profes DESC;

-- 4. Retorna un llistat amb tots els departaments i el nombre de professors/es que hi ha en cadascun d'ells. Tingui en compte que poden existir departaments que no tenen professors/es associats. Aquests departaments també han d'aparèixer en el llistat.
SELECT d.nombre AS departamento, COUNT(p.id_profesor) AS numero_profes
FROM departamento d
LEFT JOIN profesor p ON d.id = p.id_departamento
GROUP BY d.nombre;

-- 5. Retorna un llistat amb el nom de tots els graus existents en la base de dades i el nombre d'assignatures que té cadascun. Tingues en compte que poden existir graus que no tenen assignatures associades. Aquests graus també han d'aparèixer en el llistat. El resultat haurà d'estar ordenat de major a menor pel nombre d'assignatures.
SELECT g.nombre AS grado, Count(a.id) AS numero_asignaturas FROM grado g
LEFT JOIN asignatura a on g.id = a.id_grado
GROUP BY 1
ORDER BY 2 DESC;

-- 6. Retorna un llistat amb el nom de tots els graus existents en la base de dades i el nombre d'assignatures que té cadascun, dels graus que tinguin més de 40 assignatures associades.
SELECT g.nombre AS grado, Count(a.id) AS numero_asignaturas FROM grado g
INNER JOIN asignatura a on g.id = a.id_grado
GROUP BY g.nombre
HAVING numero_asignaturas > 40;

-- 7. Retorna un llistat que mostri el nom dels graus i la suma del nombre total de crèdits que hi ha per a cada tipus d'assignatura. El resultat ha de tenir tres columnes: nom del grau, tipus d'assignatura i la suma dels crèdits de totes les assignatures que hi ha d'aquest tipus.
SELECT g.nombre AS grado, a.tipo AS tipo_asignatura, SUM(a.creditos) AS creditos_totales
FROM grado g
INNER JOIN asignatura a ON g.id = a.id_grado
GROUP BY 1, 2;

-- 10. Retorna totes les dades de l'alumne/a més jove.
SELECT * FROM persona
WHERE tipo = 'alumno' AND fecha_nacimiento = 
(SELECT MAX(fecha_nacimiento) FROM persona WHERE tipo = 'alumno');

-- 11. Retorna un llistat amb els professors/es que tenen un departament associat i que no imparteixen cap assignatura.
SELECT p.apellido1, p.apellido2, p.nombre , d.nombre AS departamento
FROM persona p
INNER JOIN profesor pr ON p.id = pr.id_profesor
INNER JOIN departamento d ON pr.id_departamento = d.id
LEFT JOIN asignatura a ON pr.id_profesor = a.id_profesor
WHERE a.id_profesor IS NULL;
