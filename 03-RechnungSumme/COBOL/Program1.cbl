       identification division.
       program-id. RechnungSumme.

       environment division.
       input-output section.
       file-control.
           select infile assign inname.
           select outfile assign outname.
       configuration section.

       data division.
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

       procedure division.
           stop ' '.
           stop run.
           goback.

       end program RechnungSumme.