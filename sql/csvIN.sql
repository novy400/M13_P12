-- Creation de la table de travail.
create table YV.DVDIN as (
    select * from YV.dvd) 
    with no data;
select * from YV.DVDIN;
-- intégration des données
cl: CPYFRMIMPF FROMSTMF('/home/YV/csvOUT.csv')  
           TOFILE(YV/DVDIN)                    
           MBROPT(*REPLACE)                       
           RCDDLM(*CRLF)                          
           FLDDLM(';')                            
           RPLNULLVAL(*FLDDFT);   