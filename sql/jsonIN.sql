-- on vide la table de travail 

select * from yv.dvdin;
delete from yv.dvdin;

-- lecture du fichier xml sur l'IFS.
SELECT * FROM TABLE(QSYS2.IFS_READ('/home/YV/jsonOUT.json'));  


-- transformons le document xml de l'ifs en table sql ? 
SELECT CODEDVD,TITRE,GENRE
    FROM JSON_TABLE(
            get_clob_from_file('/home/YV/jsonOUT.json'),
            '$.Liste_dvd'
            COLUMNS(
                CODEDVD INTEGER PATH '$.code', 
                TITRE varchar(52) PATH '$.titre',
                GENRE CHAR(1) PATH '$.genre'
            )
        ) AS a WITH CS;   

-- transformons le document xml de l'ifs en table sql ? 
SELECT CODEDVD,TITRE,GENRE
    FROM JSON_TABLE(
            get_clob_from_file('/home/YV/jsonOUT.json'),
            '$.Liste_dvd'
            COLUMNS(
                CODEDVD INTEGER PATH '$.code', 
                TITRE varchar(52) PATH '$.titre',
                GENRE CHAR(1) PATH '$.genre'
            )
        ) AS a where GENRE ='S' order by TITRE WITH CS;        