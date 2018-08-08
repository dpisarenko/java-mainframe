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
       01 BIN-REP PIC 9(32).
       procedure division.
      * Next step: How many bits does binary representation of 99999 
      * contain?
           display 'Hello world'.
           display N.
           stop 'Press Enter to continue'.
           stop run.
           goback.

       end program BinaryGap.