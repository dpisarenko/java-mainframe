package cc.altruix.RechnungSumme;

import java.math.BigDecimal;

import org.apache.commons.lang3.StringUtils;

public class OutputBodyLine {
    private final static int NAME_LENGTH = 20;
    public static final String FORMAT_STRING =
                    "%-" + NAME_LENGTH + "s %3d PCS %s %s";
    private final InputReceiptLine input;

    public OutputBodyLine(final InputReceiptLine input) {
        this.input = input;
    }
    private BigDecimal totalWithoutVat() {
        final BigDecimal unitPrice = input.getUnitPrice();
        final BigDecimal quantity = BigDecimal.valueOf(input.getQuantity());
        final BigDecimal rebate = input.getRebateMultiplicator();

        BigDecimal result = unitPrice.multiply(quantity);
        result = result.multiply(rebate);
        return result; 
    } 
    public BigDecimal totalWithVat() {
        final BigDecimal totalWithoutVat = totalWithoutVat();
        final BigDecimal vat = input.getVatRateMultiplicator();
        return totalWithoutVat.multiply(vat);
    }
    public String toString() {
        return String.format(FORMAT_STRING, 
                        StringUtils.truncate(input.getName(), NAME_LENGTH),
                        input.getQuantity(), 
                        App.MONEY_FORMAT.format(totalWithoutVat()),
                        App.MONEY_FORMAT.format(totalWithVat()));
    }
}
