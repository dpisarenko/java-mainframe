package cc.altruix.RechnungSumme;

import java.math.BigDecimal;

public class OutputBodyLine {
    private final InputReceiptLine input;

    public OutputBodyLine(final InputReceiptLine input) {
        this.input = input;
    }
    public BigDecimal totalWithVat() {
        final BigDecimal unitPrice = input.getUnitPrice();
        final BigDecimal quantity = BigDecimal.valueOf(input.getQuantity());
        final BigDecimal rebate = input.getRebateMultiplicator();
        final BigDecimal vat = input.getVatRateMultiplicator();
        
        BigDecimal result = unitPrice.multiply(quantity);
        result = result.multiply(rebate);
        result = result.multiply(vat);
        return result;
    }
    public String toString() {
        return "";
    }
}
