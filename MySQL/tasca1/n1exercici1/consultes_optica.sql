USE optica;

-- Llista el total de factures d'un client/a en un període determinat.

SELECT COUNT(*) AS total_factures
FROM venda
WHERE id_client=1
AND data_venda BETWEEN '2023-06-15' AND '2023-06-22';

SELECT *
FROM venda
WHERE id_client=1
AND data_venda BETWEEN '2023-06-15' AND '2023-06-22';

-- Llista els diferents models d'ulleres que ha venut un empleat/da durant un any.

SELECT distinct u.*
FROM ulleres u
INNER JOIN venda v USING (id_ulleres)
WHERE v.id_treballador=1
AND YEAR(v.data_venda)=2023;

-- Llista els diferents proveïdors que han subministrat ulleres venudes amb èxit per l'òptica.

SELECT distinct nom
FROM proveidor
INNER JOIN ulleres USING(id_proveidor)
INNER JOIN venda USING(id_ulleres);