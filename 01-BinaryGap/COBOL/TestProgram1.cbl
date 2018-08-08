       copy "mfunit_prototypes.cpy".
       
       identification division.
       program-id. TestProgram1.

       data division.
       working-storage section.
       78 TEST-TestProgram1 value "TestProgram1".
       copy "mfunit.cpy".

       procedure division.
           goback returning 0
       .

       entry MFU-TC-PREFIX & TEST-TestProgram1.
           *> Test code goes here.
           goback returning MFU-PASS-RETURN-CODE
       .

      $region Test Configuration

       entry MFU-TC-SETUP-PREFIX & TEST-TestProgram1.
           goback returning 0
       .

       entry MFU-TC-TEARDOWN-PREFIX & TEST-TestProgram1.
           goback returning 0
       .

       entry MFU-TC-METADATA-SETUP-PREFIX & TEST-TestProgram1.
           move "This is a example of a dynamic description"
             to MFU-MD-TESTCASE-DESCRIPTION
           move 10000 to MFU-MD-TIMEOUT-IN-MS
           move "smoke,dynmeta" to MFU-MD-TRAITS
           set MFU-MD-SKIP-TESTCASE to false
           goback returning 0
       .

      $end-region

       end program TestProgram1.