       identification division.
       program-id. BinaryGap.

       environment division.
       configuration section.

       data division.
       working-storage section.
      *N is the decimal number (input data). In this program we will
      *find out the maximal binary gap in the binary representation of 
      *N.
       01 N PIC 9(10) VALUE 32.
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
      *MAX-GAP-SIZE -- size of the largest gap found so far in the
      *binary representation. Its maximum possible value depends on 
      *size of BIN-REP. If there are 32 bits, then the maximum binary
      *gap can be 32 bits long.
       01 MAX-GAP-SIZE pic 99 VALUE 0 COMP.
      *CUR-GAP-SIZE -- size of the current binary gap.
       01 CUR-GAP-SIZE pic 99 value 0 comp.
      *CUR-DIGIT -- current digit of binary representation of N.
       01 CUR-DIGIT pic 9.
       procedure division.
       MAINLINE SECTION.
       BIN-CONV-PARA.
      *Convert N to its binary representation and store it in BIN-REP.
           move N to TEMP.
           perform BIN-CONV-LOOP-PARA UNTIL TEMP <= 1.
           perform BIN-CONV-LOOP-END-PARA.
           perform GAP-SIZE-LOOP-SECT-LOOP-PARA UNTIL CTR = 0.
           display 'MAX-GAP-SIZE:'.
           display MAX-GAP-SIZE.
       BIN-GAP-COUNT-PARA.

      *Count the binary gaps.
           stop 'Press Enter to continue'.
           stop run.
           goback.
       BIN-CONV-LOOP-SECT SECTION.
       BIN-CONV-LOOP-PARA.
           divide TEMP by 2 giving TEMP remainder REM.
           move REM to BIN-REP(CTR:1).
           add 1 to CTR.
       BIN-CONV-LOOP-END-PARA.
           move TEMP(5:1) to BIN-REP(CTR:1).
           display 'BIN-REP'.
           display BIN-REP.
           display 'CTR'.
           display CTR.
           exit.
       BIN-CONV-LOOP-SECT-END-SECT SECTION.
       GAP-SIZE-LOOP-SECT SECTION.
       GAP-SIZE-LOOP-SECT-LOOP-PARA.
           display 'CTR:'
           display CTR.
           move BIN-REP(CTR:1) TO CUR-DIGIT.
           if CUR-DIGIT = 0 then
               add 1 to CUR-GAP-SIZE
           else
               compute MAX-GAP-SIZE = function max(MAX-GAP-SIZE, 
               CUR-GAP-SIZE)
               move 0 to CUR-GAP-SIZE
           end-if.
           subtract 1 from CTR.
       GAP-SIZE-LOOP-SECT-END-PARA.
       GAP-SIZE-LOOP-SECT-END-SECT SECTION.
       end program BinaryGap.