package cc.altruix.RechnungSumme;

import java.math.BigDecimal;

public class OutputBodyLine {
    private final InputReceiptLine input;

    public OutputBodyLine(final InputReceiptLine input) {
        this.input = input;
    }
    public BigDecimal totalWithVat() {
        return null;
    }
    public String toString() {
        return "";
    }
}
