package cc.altruix.RechnungSumme;

import java.io.File;
import java.io.IOException;

import org.junit.Test;
import org.junit.runner.RunWith;

import org.apache.commons.io.FileUtils;

import junitparams.JUnitParamsRunner;
import junitparams.Parameters;
import static org.fest.assertions.api.Assertions.*;

@RunWith(JUnitParamsRunner.class)
public class AppTests {

    public static final String FILE_NAME_PATTERN = "src/test/resources/%s";

    @Test
    @Parameters({
        "AppTests_1_input.txt, AppTests_1_expRes.txt",
        "AppTests_2_input.txt, AppTests_2_expRes.txt"
    }) 
    public void test(final String inputFile, final String expResFile)
                    throws IOException {
        // Prepare
        final String input = String.format(FILE_NAME_PATTERN, inputFile);
        final String expRes = FileUtils.readFileToString(
                        new File(String.format(FILE_NAME_PATTERN, expResFile)), 
                        "UTF-8");
        
        // Run method under test
        final App sut = new App();
        final String actRes = sut.run(input);
        
        // Verify
        assertThat(actRes).isEqualTo(expRes);
    } 
}
