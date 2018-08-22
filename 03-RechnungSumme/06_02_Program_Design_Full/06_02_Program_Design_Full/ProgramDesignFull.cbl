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
           05  SR-NAME                 PIC X(19).
           05                          PIC X(5).
           05  SR-ADDRESS              PIC X(20).
           05                          PIC XXXXX.
           05  SR-PHONE                PIC X(7).
           05                          PIC XXX.
           05  SR-BIRTH-DATE           PIC X(6).
           05                          PIC XXXX.
           05  SR-RECORD-TYPE          PIC X.
           05                          PIC X(4).
       01  RECORD-TYPE-B.
           05  CR-NAME                 PIC X(19).
           05                          PIC X(5).
           05  CR-COURSE-NUMBER        PIC X(5).
           05                          PIC X(5).
           05  CR-CREDITS              PIC 9.
           05                          PIC X(34).
           05  CR-RECORD-TYPE          PIC X.
           05                          PIC X(4).
       FD OUTFILE.
       01  OUTREC.
           05  OUT-NAME                PIC X(19).
  
       WORKING-STORAGE SECTION .
       01  WS-END-OF-FILE     PIC 9 VALUE 0.
       01  WS-TYPE-B-COUNTER  PIC 9(6) VALUE 0.
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
            DISPLAY ' '
            DISPLAY WS-TYPE-B-COUNTER " 'B' RECORDS READ".
            CLOSE INFILE OUTFILE
            STOP 'PRESS <CR> TO STOP'
            STOP RUN.
       PROCESS-REC.
            IF SR-RECORD-TYPE = 'A'
                PERFORM TYPE-A-ACTIONS
            ELSE 
                PERFORM TYPE-B-ACTIONS
            END-IF
            PERFORM READ-INPUT-FILE.
       TYPE-A-ACTIONS.
            MOVE SR-NAME TO OUT-NAME
            WRITE OUTREC
            DISPLAY OUTREC.
        TYPE-B-ACTIONS .
            ADD 1 TO WS-TYPE-B-COUNTER.
       READ-INPUT-FILE.
            READ INFILE
               AT END MOVE 1 TO WS-END-OF-FILE
            END-READ.  
