package cc.altruix.RechnungSumme;

import java.math.BigDecimal;

public class InputReceiptLine {
    private final String name;
    private final int quantity;
    private final BigDecimal unitPrice;
    private final char rebate;
    private final char vatRate;

    public InputReceiptLine(final String name, final int quantity, 
                    final BigDecimal unitPrice, final char rebate, 
                    final char vatRate) {
        this.name = name;
        this.quantity = quantity;
        this.unitPrice = unitPrice;
        this.rebate = rebate;
        this.vatRate = vatRate;
    }
}
