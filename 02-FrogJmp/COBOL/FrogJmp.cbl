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
      *RES will contain the result. 
       01 RES pic 9(10) value 30.
       procedure division.
           display 'FrogJmp'.
           compute DIST = Y - X.
           divide DIST by D giving DIST.
           compute RES = function ceil(DIST).
           display 'Result:'.
           display RES.
           stop ' '.
           stop run.
           goback.

       end program FrogJmp.
