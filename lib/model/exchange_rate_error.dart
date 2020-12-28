import 'dart:convert';

ExchangeRateError exchangeRateErrorFromJson(String str) => ExchangeRateError.fromJson(json.decode(str));

String exchangeRateErrorToJson(ExchangeRateError data) => json.encode(data.toJson());

class ExchangeRateError {
  ExchangeRateError({
    this.result,
    this.errorType,
  });

  String result;
  String errorType;

  factory ExchangeRateError.fromJson(Map<String, dynamic> json) => ExchangeRateError(
    result: json["result"],
    errorType: json["error-type"],
  );

  Map<String, dynamic> toJson() => {
    "result": result,
    "error-type": errorType,
  };
}
