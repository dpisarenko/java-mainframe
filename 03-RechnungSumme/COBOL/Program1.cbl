       identification division.
       program-id. RechnungSumme.

       environment division.
       input-output section.
       file-control.
           select infile assign INNAME
               ORGANIZATION SEQUENTIAL.
           select outfile assign OUTNAME
               ORGANIZATION SEQUENTIAL.

       file section.
      *Input file
       fd infile.
       01 inrec.
         03 in-name         pic X(20).
         03 in-quant        pic 9(2).
         03 in-unit-price   pic 9(3)V99.
         03 in-rebate       pic 9.
         03 in-vat          pic 9.
      *Output file.
       fd outfile.
       01 outrec.
         03 out-rec-type    pic 9.
         03 out-name        pic X(20).
         03 out-quant       pic 9(2).
         03 out-price-novat pic 9(3)V99.
         03 out-price-vat   pic 9(3)V99.
       working-storage section.
       01 eof-flag pic 9 value 0.
       procedure division.
       main.
           perform init-para.
      *    perform BOD-PARA.
           perform end-para.
       init-para.
           open input infile.
           open output outfile.
           PERFORM READ-INPUT-FILE.
       BOD-PARA.
           PERFORM PROCESS-REC
               UNTIL eof-flag = 1.
       READ-INPUT-FILE.
           read infile
               at end
                   move 1 to eof-flag.
       PROCESS-REC.
           display 'in-name:'.
           display in-name.
           PERFORM READ-INPUT-FILE.
       end-para.
           close infile outfile.
           display 'Press <CR> to exit'.
           stop ' '.
           stop run.
           goback.

       end program RechnungSumme.