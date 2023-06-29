**free
ctl-opt pgminfo(*pcml:*module:*dclcase);

// Exercice 21 - Sous-fichier statique - Partie A
dcl-ds DVD_Item template qualified;
         titre char(40);
         annee zoned(4:0);
end-ds;
//dcl-ds DVD_Liste likeds(DVD_Item) dim(10);
dcl-pi *N;
  DVD_Liste likeds(DVD_Item) dim(10);
end-pi;
  exec sql set option COMMIT = *NONE , DATFMT=*ISO;
   exec sql
    declare listeFilms cursor for
   select titre,annee 
   FROM JSON_TABLE(
            HTTP_GET(
                'http://power8:10014/web/services/LSTDVDRESTYV/',
                '{"header": "Accept,application/json","header": "Content-Type,application/json","signalErrors" : "true"}'),
            '$.DVD_Liste'
            COLUMNS(
                annee INTEGER PATH '$.annee', titre VARCHAR(132) PATH '$.titre'
            )
        ) AS a
    ORDER BY a.titre
   optimize for 10 rows
    for fetch only;
    exec  sql
     open listeFilms;
     if sqlcode < *zeros or sqlcode = 100;
        return;
     endif;
     clear DVD_Liste;
    exec sql
      fetch next
      from listeFilms
      for 10 rows
      into :DVD_Liste;
 SND-MSG DVD_Liste(1).titre;     
 SND-MSG DVD_Liste(10).titre;
 *inlr = *on;

