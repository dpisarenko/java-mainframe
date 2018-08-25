       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT INFILE  ASSIGN INNAME
                          ORGANIZATION SEQUENTIAL.
           SELECT OUTFILE ASSIGN OUTNAME
                          ORGANIZATION LINE SEQUENTIAL.
       FILE SECTION.
       FD INFILE.
       01  INPUT-RECORD.
           05 in-name          pic X(20).
           05                  pic x.
           05 in-quant         pic 9(2).
           05                  pic x.
           05 in-unit-price    pic 9(3)V99.
           05                  pic x.
           05 in-rebate        pic 9.
           05                  pic x.
           05 in-vat           pic 9.
       FD OUTFILE.
       01  OUTREC-TYPE-BODY-LINE.
           05 OUT-NAME           PIC X(19).
           05                    PIC X.
           05 OUT-QUANT          pic 9(2).
           05                    PIC X.
           05 OUT-TOTAL-NO-VAT   PIC 9(5)V99.
           05                    PIC X.
           05 OUT-TOTAL-VAT-BODY PIC 9(5)V99.
           05                    PIC X.
       01  OUTREC-TYPE-TOTAL.
           05 OUT-TOTAL          PIC X(19).
           05                    PIC X(12).
           05 OUT-TOTAL-VAT      PIC 9(5)V99.

       WORKING-STORAGE SECTION .
       01  WS-END-OF-FILE     PIC 9 VALUE 0.
       01  ALL-TOTAL-VAT      PIC 9(5)V99 VALUE 0.
       01  CUR-REBATE-MULT    PIC 9(5)V99 VALUE 0.
       01  CUR-VAT-MULT    PIC 9(5)V99 VALUE 0.
       01  CUR-TOTAL-VAT      PIC 9(5)V99 VALUE 0.
       01  CUR-TOTAL-NO-VAT   PIC 9(5)V99 VALUE 0.
       PROCEDURE DIVISION .
       PROGl.
            PERFORM INIT-PARA
            PERFORM BOD-PARA
            PERFORM END-PARA.
       INIT-PARA.
            OPEN INPUT  INFILE
            OPEN OUTPUT OUTFILE
            PERFORM READ-INPUT-FILE.
       BOD-PARA.
            PERFORM PROCESS-REC
                UNTIL WS-END-OF-FILE = 1.
       END-PARA.
      *Write total for all rows.
            move spaces to OUTREC-TYPE-BODY-LINE
            move 'Total' to OUT-TOTAL
            move ALL-TOTAL-VAT to OUT-TOTAL-VAT
            write OUTREC-TYPE-TOTAL
      *Close files
            CLOSE INFILE OUTFILE
            STOP 'PRESS <CR> TO STOP'
            STOP RUN.
       PROCESS-REC.
      *Calculate the rebate multiplicator (CUR-REBATE-MULT).
            evaluate in-rebate
                when 1
                    compute CUR-REBATE-MULT = 1.0 - 0.01
                when 5
                    compute CUR-REBATE-MULT = 1.0 - 0.05
                when other
                    compute CUR-REBATE-MULT = 1 - 0
            end-evaluate
      *Calculate the VAT multiplicator (CUR-VAT-MULT).
            IF in-vat = 1 then
                move 1.1 to CUR-VAT-MULT
            else
                move 1.2 to CUR-VAT-MULT
            END-IF
      *Calculate total amount without VAT
            COMPUTE CUR-TOTAL-NO-VAT = in-quant * in-unit-price * 
              CUR-REBATE-MULT
      *Calculate total amount with VAT
            COMPUTE CUR-TOTAL-VAT = CUR-TOTAL-NO-VAT * CUR-VAT-MULT
      *Update the "total" variable (for all rows).
            ADD CUR-TOTAL-VAT TO ALL-TOTAL-VAT
      *Set the values of the output record
            move in-name to out-name
            move in-quant to OUT-QUANT
            move cur-total-no-vat to out-total-no-vat
            move cur-total-vat to OUT-TOTAL-VAT-BODY
            WRITE OUTREC-TYPE-BODY-LINE
            PERFORM READ-INPUT-FILE.
       READ-INPUT-FILE.
            READ INFILE
               AT END MOVE 1 TO WS-END-OF-FILE
            END-READ.  
