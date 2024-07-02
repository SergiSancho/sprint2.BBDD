use pizzeria;

-- Llista quants productes de categoria 'Begudes' s'han venut en una determinada localitat.

SELECT SUM(lc.quantitat) AS quantitat_begudes_venudes, l.nom
FROM linia_comanda lc
JOIN comanda c ON lc.id_comanda = c.id_comanda
JOIN producte p ON lc.id_producte = p.id_producte
JOIN botiga b ON c.id_botiga = b.id_botiga
JOIN adreca a ON b.id_adreca = a.id_adreca
JOIN localitat l ON a.id_localitat = l.id_localitat
WHERE p.categoria = 'begudes'
AND l.nom = 'Badalona';

-- Llista quantes comandes ha efectuat un determinat empleat/da.

SELECT COUNT(r.id_comanda) AS quantitat_comandes_efectuades
FROM repartiment r
JOIN empleat e ON r.id_empleat = e.id_empleat
WHERE e.nom = 'Anna' AND e.cognoms = 'Perez';
