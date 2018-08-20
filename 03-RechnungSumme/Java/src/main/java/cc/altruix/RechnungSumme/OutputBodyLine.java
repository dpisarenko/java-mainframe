package cc.altruix.RechnungSumme;

import java.math.BigDecimal;

public class OutputBodyLine {
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
        return String.format("%-20s %3d PCS %s %s", input.getName(),
                        input.getQuantity(), 
                        App.MONEY_FORMAT.format(totalWithoutVat()),
                        App.MONEY_FORMAT.format(totalWithVat()));
    }
}
