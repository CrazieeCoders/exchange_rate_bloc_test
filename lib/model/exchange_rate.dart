import 'dart:convert';

ExchangeRate exchangeRateFromJson(String str) => ExchangeRate.fromJson(json.decode(str));

String exchangeRateToJson(ExchangeRate data) => json.encode(data.toJson());

class ExchangeRate {
  ExchangeRate({
    this.result,
    this.conversionRates,
  });

  String result;
  Map<String, double> conversionRates;

  factory ExchangeRate.fromJson(Map<String, dynamic> json) => ExchangeRate(
    result: json["result"],
    conversionRates: Map.from(json["conversion_rates"]).map((k, v) => MapEntry<String, double>(k, v.toDouble())),
  );

  Map<String, dynamic> toJson() => {
    "result": result,
    "conversion_rates": Map.from(conversionRates).map((k, v) => MapEntry<String, dynamic>(k, v)),
  };
}
