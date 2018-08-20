# Task description

The program should read a text file, in which every line has the following structure:

```
<Name>;<Quantity>;<UnitPrice>;<Rebate>;<VatRate>
```

where

* `<Name>` is the name of the item,
* `<Quantity>` is the quantity of that item in pieces,
* `<UnitPrice>` -- price of one unit of the item,
* `<Rebate>` -- indicator of rebate for this item (`0` -- no rebate, `5` -- 5 percent rebate, or `1` -- 1 percent rebate),
* `<VatRate>` -- the value added tax rate (valid values are `2` for 20 % and `1` for 10 %).

The program should produce an output file which consists of

* body lines and
* footer.

Each body line should contain 

* the name of the product,
* its quantity,
* total price for that product excl. VAT,
* total price for that product incl. VAT.

If there is a rebate assigned to a particular product, it should be applied before VAT is calculated. If the rebate is 10 %, the unit price of a product is 10,--, there are 2 items, and  the VAT rate is 20 %, then total price excl. VAT should be `(2 * 10)*(1-0.1) = 18`. Total price incl. VAT should equal to `(2 * 10)*(1-0.1)*1.2 = 21,60`.

The footer should contain a sum of all total prices incl. VAT and a lettering `TOTAL`. 
