import 'dart:io';


import 'package:exchange_rate_bloc_test/exception/custom_exception.dart';
import 'package:exchange_rate_bloc_test/model/exchange_rate.dart';
import 'package:exchange_rate_bloc_test/model/exchange_rate_error.dart';
import 'package:http/http.dart' as http;

class APIService{


   static String baseUrl = "https://v6.exchangerate-api.com/v6/6ce72bbb5adf57c76500e248/latest/";



  Future<Map<String, double>> getCurrencyRate(String currencyName) async{
    var responseJson;
    Map<String,double> conversionRates ;
   try {

     final response = await http.get(baseUrl+currencyName);
     responseJson =_returnResponse(response);

      final exchangeRate = exchangeRateFromJson(responseJson);
     conversionRates = exchangeRate.conversionRates;

   }on SocketException{
      throw FetchDataException(":please verify your internet connection! ");
   }

  return conversionRates;
  }

  static _returnResponse(http.Response response){

    switch(response.statusCode){
      case 200:
        final exchangeRateError = exchangeRateErrorFromJson(response.body);

        if(exchangeRateError.result == "error"){
          throw ExchangeRateNotFoundException(exchangeRateError.result);
        }else {
          return response.body;
        }
        break;

      case 400:
        throw BadRequestException(response.body.toString());
        break;

      case 403:
        throw UnAuthorisedException(response.body.toString());
        break;

      case 404:
        throw URLNotAvailable(response.body.toString());
        break;
      default:
        throw FetchDataException("Error occured while communicating with Server:${response.statusCode}");
        break;
    }


  }



}