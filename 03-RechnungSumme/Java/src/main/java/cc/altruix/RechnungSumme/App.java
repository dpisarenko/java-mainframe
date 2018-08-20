package cc.altruix.RechnungSumme;

import java.io.File;
import java.io.IOException;
import java.math.BigDecimal;
import java.text.NumberFormat;
import java.util.Currency;
import java.util.List;
import java.util.Locale;
import java.util.stream.Collectors;

import org.apache.commons.io.FileUtils;
import org.apache.commons.lang3.StringUtils;

public class App {
    private final static String USAGE = "java -jar App <inputFileName>";
    private final static NumberFormat MONEY_FORMAT = createMoneyNumberFormat();
    
    private static NumberFormat createMoneyNumberFormat() {
        final NumberFormat format = NumberFormat.getInstance(Locale.GERMANY);
        format.setCurrency(Currency.getInstance("EUR"));
        format.setMaximumFractionDigits(2);
        format.setMinimumFractionDigits(2);
        return format;
    } 
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
            final List<OutputBodyLine> bodyLines = validLines.stream()
                            .map(OutputBodyLine::new)
                            .collect(Collectors.toList());
            final BigDecimal total = bodyLines.stream()
                            .map(OutputBodyLine::totalWithVat)
                            .reduce(BigDecimal.ZERO, BigDecimal::add);
            return composeText(bodyLines, total);
        } catch (final IOException exception) {
            System.err.println("An error occured");
            exception.printStackTrace(System.err);
            return "";
        }
    }

    private String composeText(
                    final List<OutputBodyLine> bodyLines, 
                    final BigDecimal total) {
       final StringBuilder builder = new StringBuilder();
       bodyLines.stream().map(OutputBodyLine::toString).forEach(str -> {
           builder.append(str);
           builder.append(System.getProperty("line.separator"));
       });
       builder.append("TOTAL: ");
       builder.append(MONEY_FORMAT.format(total));
       return builder.toString();
    }

    private InputReceiptLine stringToReceiptLine(final String input) {
        if (!input.contains(";")) {
            System.err.println("Input line has no delimiters");
            return null;
        }
        final String[] parts = input.split(";"); 
        if (parts.length != 5) {
            System.err.println("Incorrect number of parts in the input line");
            return null;
        }
        final String name = parts[0];
        final String quantityTxt = parts[1];
        final String unitPriceTxt = parts[2];
        final String rebateTxt = parts[3];
        final String vatRateTxt = parts[4];
        
        if (StringUtils.isBlank(name)) {
            return null;
        }
        if (!StringUtils.isNumeric(quantityTxt)) {
            return null;
        }
        final int quantity = Integer.parseInt(quantityTxt.trim());
        final BigDecimal unitPrice;
        try {
            unitPrice = new BigDecimal(unitPriceTxt);
        }
        catch (final NumberFormatException exception) {
            return null;
        }
        if (rebateTxt.length() != 1) {
            return null;
        }
        final char rebate = rebateTxt.charAt(0);
        if (!rebateValid(rebate)) {
            return null;
        }
        if (vatRateTxt.length() != 1) {
            return null;
        }
        final char vatRate = vatRateTxt.charAt(0);
        if (!vatValid(vatRate)) {
            return null;
        }
        return new InputReceiptLine(name,quantity, 
                        unitPrice, rebate, vatRate);
    }
    private boolean rebateValid(final char rebate) {
        return (rebate == '0') || (rebate == '5') || (rebate == '1');
    }
    private boolean vatValid(final char vat) {
        return (vat == '1') || (vat == '2');
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
