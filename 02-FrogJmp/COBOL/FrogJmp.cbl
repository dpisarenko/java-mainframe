       program-id. FrogJmp as "FrogJmp".

       environment division.
       configuration section.

       data division.
       working-storage section.
      *According to specification, X, Y and D are integers within the 
      *range [1..1,000,000,000]
       01 X pic 9(10) value 10.
       01 Y pic 9(10) value 85.
       01 D pic 9(10) value 30.
       01 DIST pic 9(10)V99 value 0.
      *DEC-PART will contain the decimal part (two decimal digits after
      *V) of DIST after division.
       01 DEC-PART pic 99 value 0.
      *RES will contain the result. 
       01 RES pic 9(10) value 0.
       procedure division.
           display 'FrogJmp'.
           compute DIST = Y - X.
           divide DIST by D giving DIST.
           move DIST(11:2) to DEC-PART.
           move DIST(1:10) to RES.
           if DEC-PART > 0 then
               add 1 to RES.
           display 'Result:'.
           display RES.
           stop ' '.
           stop run.
           goback.

       end program FrogJmp.
