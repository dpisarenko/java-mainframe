      *> Test Fixture for COBOL-2, BinaryGap

       copy "mfunit_prototypes.cpy".

       program-id. TestBinaryGap.
       working-storage section.
       copy "mfunit.cpy".
       78 TEST-TESTBINARYGAP value "TestBINARYGAP".
       01 pp procedure-pointer.

      *> Program linkage data

       procedure division.
           goback returning 0
       .

       entry MFU-TC-PREFIX & TEST-TESTBINARYGAP.

           call "BINARYGAP"

           *> Verify the outputs here
           goback returning MFU-PASS-RETURN-CODE
       .

      $region TestCase Configuration

       entry MFU-TC-SETUP-PREFIX & TEST-TESTBINARYGAP.
       perform InitializeLinkageData
           *> Add any other test setup code here
           goback returning 0
       .

       InitializeLinkageData section.
           *> Load the library that is being tested
           set pp to entry "COBOL-2"

           exit section
       .

      $end-region

       end program.
