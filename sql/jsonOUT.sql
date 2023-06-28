-- lister les films 
select * from yv.dvd;
-- formater nos données en xml 
select coddvd, titre, genre from yv.dvd order by genre;

-- creation d'un objet json pour chaque ligne ==> représentant un dvd au format json.
select json_object ('code' value coddvd, 
                    'titre' value titre,
                    'genre' value genre)                  
from yv.dvd;

-- regroupons les dvds dans un tableau.
select json_arrayagg(json_object ('code' value coddvd, 
                    'titre' value titre,
                    'genre' value genre)  )                
from yv.dvd;
-- insérons le tableau dans un objet.
select json_object ('Liste_dvd' value
     json_arrayagg(json_object ('code' value coddvd, 
                    'titre' value trim(titre),
                    'genre' value genre))  )                
from yv.dvd;
-- insérons ce document dans un fichier de l'IFS.
CALL QSYS2.IFS_WRITE(                                    
     PATH_NAME => '/home/YV/jsonOUT.json',          
  overwrite => 'REPLACE',                                
     LINE => (                                           
select json_object ('Liste_dvd' value
     json_arrayagg(json_object ('code' value coddvd, 
                    'titre' value trim(titre),
                    'genre' value genre))  )                
from yv.dvd),                                      
     FILE_CCSID => 1208);   