class Quote {
  final int id;
  final String countrySymbol;
  final String baseSymbol;
  String baseAmount;
  final String countryName;
  final String currencyName;
  final String quoteFlag;
  final String baseFlag;
  String quotePrice;

  Quote({
    this.id,
    this.countrySymbol,
    this.baseSymbol,
    this.baseAmount,
    this.countryName,
    this.currencyName,
    this.quoteFlag,
    this.baseFlag,
    this.quotePrice,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "id": id,
      "countryName": countryName,
      "currencyName": currencyName,
      "baseSymbol": baseSymbol,
      "baseAmount": baseAmount,
      "countrySymbol": countrySymbol,
      "imageUrl": quoteFlag
    };
  }
}
