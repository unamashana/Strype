/**
 * Variant of Avraham Plotnitzky's String.prototype method mixed with the "fast" version
 * see: https://sites.google.com/site/abapexamples/javascript/luhn-validation
 * @author ShirtlessKirk. Copyright (c) 2012.
 * Licensed under WTFPL (http://www.wtfpl.net/txt/copying)
 */

LuhnCheck = {
  check: function (luhn) {
    var len = luhn.length,
        mul = 0,
        prodArr = [[0, 1, 2, 3, 4, 5, 6, 7, 8, 9], [0, 2, 4, 6, 8, 1, 3, 5, 7, 9]],
        sum = 0;

    while (len--) {
        sum += prodArr[mul][parseInt(luhn.charAt(len), 10)];
        mul ^= 1;
    }

    return sum % 10 === 0 && sum > 0;
  }
}
