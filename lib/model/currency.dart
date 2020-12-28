import 'dart:convert';

class Currency{

  String countryCode;

  Currency({this.countryCode});


  factory Currency.fromJson(Map<String,dynamic> parsedJson){
    return new Currency(
      countryCode:parsedJson['countryCode'],
    );
  }

  static Map<String,dynamic> toMap(Currency currency)=>{
    'countryCode':currency.countryCode,
  };


  static String encodeTask(List<Currency> currency)=> jsonEncode(
    currency.map<Map<String,dynamic>>((currency) => Currency.toMap(currency)).toList(),
  );


  static List<Currency> decodeTask(String currency)=>(jsonDecode(currency) as List<dynamic>)
      .map<Currency> ((item) =>Currency.fromJson(item)).toList();





}