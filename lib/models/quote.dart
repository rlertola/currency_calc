class Quote {
  final countrySymbol;
  final baseSymbol;
  var baseAmount;
  final countryName;
  final currencyName;
  final imageUrl;
  var quotePrice;

  Quote({
    this.countrySymbol,
    this.baseSymbol,
    this.baseAmount,
    this.countryName,
    this.currencyName,
    this.imageUrl,
    this.quotePrice,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "countryName": countryName,
      "currencyName": currencyName,
      "baseSymbol": baseSymbol,
      "baseAmount": baseAmount,
      "countrySymbol": countrySymbol,
      "imageUrl": imageUrl,
    };
  }

  // Quote.fromMap(Map<String, dynamic> map) {

  // }
}
