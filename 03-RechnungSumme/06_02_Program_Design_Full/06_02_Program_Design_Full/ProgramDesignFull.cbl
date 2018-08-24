       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT INFILE  ASSIGN INNAME
                          ORGANIZATION SEQUENTIAL.
           SELECT OUTFILE ASSIGN OUTNAME
                          ORGANIZATION SEQUENTIAL.
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
           05 OUT-NAME         PIC X(19).
           05                  PIC X.
           05 OUT-TOTAL-NO-VAT PIC 9(5)V99.
           05                  PIC X.
           05 OUT-TOTAL-VAT    PIC 9(5)V99.
           05                  PIC X.
       01  OUTREC-TYPE-TOTAL.
           05 OUT-TOTAL        PIC X(5).
           05                  PIC X.
           05 OUT-TOTAL-VAT    PIC 9(5)V99.

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
            DISPLAY "START OF PROGRAM"
            DISPLAY " "
            OPEN INPUT  INFILE
            OPEN OUTPUT OUTFILE
            PERFORM READ-INPUT-FILE.
       BOD-PARA.
            PERFORM PROCESS-REC
                UNTIL WS-END-OF-FILE = 1.
       END-PARA.
            CLOSE INFILE OUTFILE
            STOP 'PRESS <CR> TO STOP'
            STOP RUN.
       PROCESS-REC.
            display 'WS-END-OF-FILE = ' WS-END-OF-FILE
            display 'IN-NAME = ' IN-NAME
      *Calculate the rebate multiplicator (CUR-REBATE-MULT).
            IF IN-REBATE = 1 then
                compute CUR-REBATE-MULT = (1.0 - 0.01) 
            else if IN-REBATE = 5 then
                compute CUR-REBATE-MULT = (1.0 - 0.5)
            else 
                compute CUR-REBATE-MULT = (1 - 0) 
            END-IF
      *Calculate the VAT multiplicator (CUR-VAT-MULT).
            IF in-vat = 1 then
                move 1.1 to CUR-VAT-MULT
            else
                move 1.2 to CUR-VAT-MULT
            END-IF
      *TODO: Calculate total amount without VAT
            MOVE ZERO TO CUR-TOTAL-NO-VAT
            MOVE IN-NAME TO OUT-NAME
            WRITE OUTREC-TYPE-BODY-LINE
            DISPLAY '12'
            PERFORM READ-INPUT-FILE.
       READ-INPUT-FILE.
            display 'READ-INPUT-FILE'
            READ INFILE
               AT END MOVE 1 TO WS-END-OF-FILE
            END-READ.  
