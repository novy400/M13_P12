**free
// Exercice 21 - Sous-fichier statique - Partie A
dcl-ds DVD_Item qualified;
         titre char(40);
         annee zoned(4:0);
end-ds;
dcl-f dsp21a workstn sfile(fmtenr:rrn);
dcl-s rrn zoned(4);
dcl-ds  DVD_Liste likeds(DVD_Item) dim(10);

dcl-pr getDVDs extpgm('LSTDVD');
    pDVDs likeds(DVD_Item) dim(10);
end-pr;

 exsr remplissageSfl;
 exsr affichagePage1;

 *inlr = *on;

 begsr remplissageSfl;
  clear DVD_Liste;
  getDVDs(DVD_Liste);
  For-Each  DVD_Item in DVD_Liste;
    if DVD_Item.titre = *blanks;
      iter;
    endif; 
    rrn = rrn + 1;
    titre = DVD_Item.titre;
    annee = DVD_Item.annee;
    write fmtenr;
  EndFor;
    *in34 = *on;
 endsr;

 begsr affichagePage1;
   write touches;
   exfmt sflctl;
 endsr;