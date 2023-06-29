-- FakeRESTApi https://fakerestapi.azurewebsites.net/index.html
-- lancer la requête
-- GET => liste des activités (id,titre...)
-- on teste l’accès au Web Service.  
values HTTP_GET('http://power8:10014/web/services/LSTDVDRESTYV/' ,'');
-- on ajoute la gestion des erreurs
values HTTP_GET('http://power8:10014/web/services/LSTDVDRESTYV/s' ,'{"signalErrors" : "true"}');
select * from table(HTTP_GET_VERBOSE('http://power8:10014/web/services/LSTDVDRESTYV/s' ,'')) as x ;
-- GET => liste des activités (id,titre...) avec traitement des erreurs  
values HTTP_GET('http://power8:10014/web/services/LSTDVDRESTYV/' ,'{"signalErrors" : "true"}');
-- GET => liste des activités (id,titre...) avec traitement des erreurs  et spécification du format json pour les échanges
VALUES
    HTTP_GET(
        'http://power8:10014/web/services/LSTDVDRESTYV/',
        '{"header": "Accept,application/json","header": "Content-Type,application/json","signalErrors" : "true"}');
-- Parser la réponse
-- Créer et Utiliser une variable (dans votre bibliothèque par exemple RPG4**)
create or replace variable YV.json_response varchar(3000);
-- Placer le résultat de la requête dans la variable.
set YV.json_response = HTTP_GET('http://power8:10014/web/services/LSTDVDRESTYV/' ,'');
-- Visualiser le contenu de la variable.
values YV.json_response;
-- Travailler avec le contenu de la variable , pour trouver le bon chemin! 
-- trouver la ligne de la future table
-- trouver les colonnes 
select * from json_table(YV.json_response,
'$.DVD_Liste' columns( 
  annee integer path '$.annee', 
  titre varchar(132) path '$.titre' 
)) as a;
-- définir une selection,tri,calcul.... en sql sur la table résultante. 
select * from json_table(YV.json_response,
'$.DVD_Liste' columns( 
  annee integer path '$.annee', 
  titre varchar(132) path '$.titre' 
)) as a order by a.titre;
-- mixer la requête HTTP et l'analyse du résultat en une seule requête.
SELECT *
    FROM JSON_TABLE(
            HTTP_GET(
                'http://power8:10014/web/services/LSTDVDRESTYV/',
                '{"header": "Accept,application/json","header": "Content-Type,application/json","signalErrors" : "true"}'),
            '$.DVD_Liste'
            COLUMNS(
                annee INTEGER PATH '$.annee', titre VARCHAR(132) PATH '$.titre'
            )
        ) AS a
    ORDER BY a.titre;
