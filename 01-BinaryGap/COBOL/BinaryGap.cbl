       identification division.
       program-id. BinaryGap.

       environment division.
       configuration section.

       data division.
       working-storage section.
      *N is the decimal number (input data). In this program we will
      *find out the maximal binary gap in the binary representation of 
      *N.
       01 N PIC 9(5) VALUE 10.
      *Length of the binary representation is calculated according
      *to formula ln(n) / ln(2).
      *Source: https://stackoverflow.com/questions/7150035/calculating-
      *bits-required-to-store-decimal-number
      *Let's say the maximum value N can take is 2147483647.
      *CEIL(ln(2147483647)/ln(2)) = CEIL(21.4876 / 0.6931) =
      *= CEIL (31.0022) = 32
       01 BIN-REP PIC 9(32) VALUE 0.
      *This is a variable for holding current value during conversion
      *to binary.
       01 TEMP PIC 9(5) VALUE 0.
      *REM -- remainder of the last division.
       01 REM PIC 9 VALUE 0.
      *CTR -- counter for the binary conversion loop.
       01 CTR pic 99 VALUE 1 COMP.
       procedure division.
       MAINLINE SECTION.
       BIN-CONV-PARA.
      *Convert N to its binary representation and store it in BIN-REP.
           move N to TEMP.
           display 'Hello world'.
           display TEMP.
           perform BIN-CONV-LOOP-PARA UNTIL TEMP <= 1.
           perform BIN-CONV-LOOP-END-PARA.
           stop 'Press Enter to continue'.
           stop run.
           goback.
       BIN-CONV-LOOP-SECT SECTION.
       BIN-CONV-LOOP-PARA.
           divide TEMP by 2 giving TEMP remainder REM.
           display 'TEMP'.
           display TEMP.
           display 'REM'.
           display REM.
           move REM to BIN-REP(CTR:1).
           add 1 to CTR.
           display 'BIN-REP'.
           display BIN-REP.
           display 'CTR'.
           display CTR.
       BIN-CONV-LOOP-END-PARA.
           move TEMP(5:1) to BIN-REP(CTR:1).
           exit.
       END-SECT SECTION. 
       end program BinaryGap.