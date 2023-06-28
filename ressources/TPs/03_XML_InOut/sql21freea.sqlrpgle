**free
// Exercice 21 - Sous-fichier statique - Partie A

 dcl-f dsp21a workstn sfile(fmtenr:rrn);
 dcl-s rrn zoned(4);
  exec sql set option COMMIT = *NONE , DATFMT=*ISO;
   exec sql
    declare listeFilms cursor for
   select titre,annee from dvd order by titre
    for fetch only;
 exsr remplissageSfl;
 exsr affichagePage1;

 *inlr = *on;

 begsr remplissageSfl;
    exec  sql
     open listeFilms;
     
    DoU 1 = 0;
     exec sql
     fetch from listeFilms into :titre,:annee;
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