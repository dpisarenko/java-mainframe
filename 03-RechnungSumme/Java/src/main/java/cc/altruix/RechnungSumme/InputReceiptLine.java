package cc.altruix.RechnungSumme;

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.Map;

public class InputReceiptLine {
    private final String name;
    private final int quantity;
    private final BigDecimal unitPrice;
    private final char rebate;
    private final char vatRate;
    private final static Map<Character,BigDecimal> 
                    REBATE_MULTIPLICANDS_BY_MARKERS;
    private final static Map<Character,BigDecimal> VAT_RATES_BY_MARKERS;
    static {
        REBATE_MULTIPLICANDS_BY_MARKERS = new HashMap<>();
        REBATE_MULTIPLICANDS_BY_MARKERS.put('0', BigDecimal.valueOf(1.0 - 0.0));
        REBATE_MULTIPLICANDS_BY_MARKERS.put('1', BigDecimal.valueOf(1.0 - 0.01));
        REBATE_MULTIPLICANDS_BY_MARKERS.put('5', BigDecimal.valueOf(1.0 - 0.05));
        VAT_RATES_BY_MARKERS = new HashMap<>();
        VAT_RATES_BY_MARKERS.put('1', BigDecimal.valueOf(1.1));
        VAT_RATES_BY_MARKERS.put('2', BigDecimal.valueOf(1.2));
    }
    public InputReceiptLine(final String name, final int quantity, 
                    final BigDecimal unitPrice, final char rebate, 
                    final char vatRate) {
        this.name = name;
        this.quantity = quantity;
        this.unitPrice = unitPrice;
        this.rebate = rebate;
        this.vatRate = vatRate;
    }

    public String getName() {
        return name;
    }

    public int getQuantity() {
        return quantity;
    }

    public BigDecimal getUnitPrice() {
        return unitPrice;
    }

    public BigDecimal getRebateMultiplicator() {
        return this.REBATE_MULTIPLICANDS_BY_MARKERS.get(this.rebate);
    }

    public BigDecimal getVatRateMultiplicator() {
        return this.VAT_RATES_BY_MARKERS.get(this.vatRate);
    }
}
