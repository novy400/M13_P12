select * from yv.dvd;
cl: dspsyssts;

cl: CPYTOIMPF FROMFILE(YV/DVD)        
          TOSTMF('/home/YV/csvOUT.csv')     
          MBROPT(*REPLACE)                        
          STMFCCSID(1208)                         
          RCDDLM(*CRLF)                           
          FLDDLM(';');