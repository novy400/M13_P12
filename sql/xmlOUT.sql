-- lister les films 
select * from yv.dvd;
-- formater nos données en xml 
select coddvd, titre, genre from yv.dvd order by genre;

-- creation d'un arbre <liste_films> en créant des feuilles <dvd> pour chaque ligne de notre table DVD.
SELECT XMLGROUP(TRIM(coddvd) AS "code_dvd",
                TRIM(titre) AS "titre",
                genre AS "genre"
       OPTION ROW "dvd" ROOT "liste_Films")
FROM yv.dvd; 
-- transformons le document XML en CLOB big big chaîne de caractère
SELECT xmlserialize(XMLGROUP(TRIM(coddvd) AS "code_dvd",
                TRIM(titre) AS "titre",
                genre AS "genre"
       OPTION ROW "dvd" ROOT "liste_Films") as CLOB(10000000) INCLUDING XMLDECLARATION)
FROM yv.dvd; 
-- insérons ce document dans un fichier de l'IFS.
CALL QSYS2.IFS_WRITE(                                    
     PATH_NAME => '/home/YV/xmlOUT.xml',          
  overwrite => 'REPLACE',                                
     LINE => (                                           
SELECT xmlserialize(XMLGROUP(TRIM(coddvd) AS "code_dvd",
                TRIM(titre) AS "titre",
                genre AS "genre"
       OPTION ROW "dvd" ROOT "liste_Films") as CLOB(10000000) INCLUDING XMLDECLARATION)
FROM yv.dvd),                                      
     FILE_CCSID => 1208);   