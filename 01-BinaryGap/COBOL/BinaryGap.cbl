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
     
       procedure division.
      * Next step: How many bits does binary representation of 99999 
        contain?
           display 'Hello world'.
           display N.
           stop 'Press Enter to continue'.
           stop run.
           goback.

       end program BinaryGap.