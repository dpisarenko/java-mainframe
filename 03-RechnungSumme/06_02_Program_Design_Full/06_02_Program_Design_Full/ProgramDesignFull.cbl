       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT INFILE  ASSIGN INNAME
                          ORGANIZATION SEQUENTIAL.
           SELECT OUTFILE ASSIGN OUTNAME
                          ORGANIZATION SEQUENTIAL.
       FILE SECTION.
       FD INFILE.
       01  RECORD-TYPE-A.
           05 in-name         pic X(20).
           05                 pic x.
           05 in-quant        pic 9(2).
           05                 pic x.
           05 in-unit-price   pic 9(3)V99.
           05                 pic x.
           05 in-rebate       pic 9.
           05                 pic x.
           05 in-vat          pic 9.
       FD OUTFILE.
       01  OUTREC.
           05  OUT-NAME                PIC X(19).
  
       WORKING-STORAGE SECTION .
       01  WS-END-OF-FILE     PIC 9 VALUE 0.
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
            MOVE IN-NAME TO OUT-NAME
            WRITE OUTREC
            DISPLAY OUTREC.
       READ-INPUT-FILE.
            READ INFILE
               AT END MOVE 1 TO WS-END-OF-FILE
            END-READ.  
