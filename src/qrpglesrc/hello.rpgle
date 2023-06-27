**free
ctl-opt copyright('Company');
ctl-opt decEdit('0,') datEdit(*YMD.);
ctl-opt BndDir('QC2LE');
ctl-opt main(main); 
// ------------------------------------------------------------------------------------
// Main entry procedure
// ------------------------------------------------------------------------------------
dcl-proc main;
    dcl-s message char(50);
    message = 'bonjour';
    dsply message;
end-proc;