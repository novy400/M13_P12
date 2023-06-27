-- on vide la table de travail 

select * from yv.dvdin;
delete from yv.dvdin;

-- lecture du fichier xml sur l'IFS.
SELECT * FROM TABLE(QSYS2.IFS_READ('/home/YV/xmlOUT.xml'));  


-- transformons le document xml de l'ifs en table sql ? 
SELECT CODEDVD,TITRE,GENRE
FROM XMLTABLE('$result/liste_Films/dvd'
PASSING XMLPARSE(
DOCUMENT
GET_XML_FILE('/home/YV/xmlOUT.xml')
) as "result"
COLUMNS
CODEDVD CHAR(3) PATH 'code_dvd',
TITRE varchar(52) PATH 'titre',
GENRE CHAR(1) PATH 'code_dvd'
) AS TABLEXML WITH CS;   

-- transformons le document xml de l'ifs en table sql ? 
SELECT CODEDVD,LCASE(TITRE),GENRE
FROM XMLTABLE('$result/liste_Films/dvd'
PASSING XMLPARSE(
DOCUMENT
GET_XML_FILE('/home/YV/xmlOUT.xml')
) as "result"
COLUMNS
CODEDVD CHAR(3) PATH 'code_dvd',
TITRE varchar(52) PATH 'titre',
GENRE CHAR(1) PATH 'code_dvd'
) AS TABLEXML where GENRE ='1' order by TITRE WITH CS;        