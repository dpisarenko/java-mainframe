package cc.altruix.RechnungSumme;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.stream.Collectors;

import org.apache.commons.io.FileUtils;
import org.apache.commons.lang3.StringUtils;

public class App {
    private final static String USAGE = "java -jar App <inputFileName>";
    
    public String run(final String inputPath) {
        final File file = new File(inputPath);
        if (!(file.exists() && file.canRead())) {
            System.err.println("Input file does not exist and/or is not readable");
            return "";
        }
        try {
            final List<String> lines = FileUtils.readLines(file, "UTF-8");
            final List<InputReceiptLine> inputReceiptLines = 
                            lines.stream().map(this::stringToReceiptLine)
                                            .collect(Collectors.toList());
            final List<InputReceiptLine> validLines = 
                            inputReceiptLines.stream()
                                            .filter(x -> x != null)
                                            .collect(Collectors.toList());
            if (inputReceiptLines.size() != validLines.size()) {
                System.err.println("Invalid input data detected");
                return "";
            }
            return "";
        } catch (final IOException exception) {
            System.err.println("An error occured");
            exception.printStackTrace(System.err);
            return "";
        }
    }
    private InputReceiptLine stringToReceiptLine(final String input) {
        
    }
    public static void main(final String[] args) {
        final App app = new App();
        if ((args == null) || (args.length != 1) || 
                        StringUtils.isEmpty((args[0]))) {
            System.err.println(USAGE);
            return;
        }
        final String result = app.run(args[0]);
        System.out.println(result);
    }
}
