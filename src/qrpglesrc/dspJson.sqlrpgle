**free
// Exercice 21 - Sous-fichier statique - Partie A

 dcl-f dsp21a workstn sfile(fmtenr:rrn);
 dcl-s rrn zoned(4);
  exec sql set option COMMIT = *CS , DATFMT=*ISO;
   exec sql
    declare listeFilms cursor for
    SELECT TITRE
    FROM JSON_TABLE(
            get_clob_from_file('/home/YV/jsonOUT.json'),
            '$.Liste_dvd'
            COLUMNS(
                CODEDVD INTEGER PATH '$.code', 
                TITRE varchar(52) PATH '$.titre',
                GENRE CHAR(1) PATH '$.genre'
            )
        ) AS a order by titre
        for fetch only;
 exsr remplissageSfl;
 exsr affichagePage1;

 *inlr = *on;

 begsr remplissageSfl;
    exec  sql
     open listeFilms;
     
    DoU 1 = 0;
     exec sql
     fetch from listeFilms into :titre;
     if sqlcode < *zeros or sqlcode = 100;
        leave;
     endif;
     rrn = rrn + 1;
     write fmtenr;
   enddo;
 exec sql
 close listeFilms;
   *in34 = *on;
 endsr;

 begsr affichagePage1;
   write touches;
   exfmt sflctl;
 endsr;