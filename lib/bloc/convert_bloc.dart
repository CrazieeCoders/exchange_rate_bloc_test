import 'package:bloc/bloc.dart';
import 'package:exchange_rate_bloc_test/bloc/convert_event.dart';
import 'package:exchange_rate_bloc_test/bloc/convert_states.dart';
import 'package:exchange_rate_bloc_test/model/currency.dart';
import 'package:exchange_rate_bloc_test/service/api_services.dart';



class ConvertBloc extends Bloc<ConvertEvent,ConvertState>{

  APIService _apiService =APIService();
  List<Currency> currencyList=[Currency(countryCode: 'INR')];
  Map<String,double> exchangeRates;
  int value;

  List<String> listOfCurrencies = ["AED-UnitedArab",   "AFN-Afghanistan",   "ALL-Albania",   "AMD-Armenia",   "ANG-Netherland",
    "AOA-Angola",   "ARS-Argentina",   "AUD-Australia" ,   "AWG-Aruba",
    "BAM-Bosnia",   "BBD-Barbados",   "BDT-Bangladesh",   "BGN-Bulgaria",   "BHD-Bahrain",
    "BIF-Burundi",   "BMD-Bermuda",   "BND-Brunei",   "BOB-Bolivia",   "BOV-Bolivia", "BRL-Brazil",
    "BSD-Bahamas",   "BTN-Bhutan",   "BWP-Botswana",   "BYR-Belarus",
    "BZD-Belize",   "CAD-Canada",   "CDF-Congo",   "CHE-Switzerland",   "CHF-Switzerland",
    "CHW-Switzerland",   "CLF-Chile",   "CLP-Chile",   "CNY-Mainland China",   "COP-Colombia",
    "COU-Colombia",   "CRC-Costa Rica",   "CUP-Cuba",   "CVE-Cape Verde",   "CYP-Cyprus",
    "CZK-CzechRepublic",   "DJF-Djibouti",   "DKK-Denmark",   "DOP-Dominican Republic",
    "DZD-Algeria",   "EEK-Estonia",   "EGP-Egypt",   "ERN-Eritrea",   "ETB-Ethiopia",
    "EUR-European Union",   "FJD-Fiji",   "FKP-Falkland",   "GBP-United Kingdom",
    "GEL-Georgia",   "GHS-Ghana",   "GIP-Gibraltar",   "GMD-Gambia",   "GNF-Guinea",
    "GTQ-Guatemala",   "GYD-Guyana",   "HKD-Hong",   "HNL-Honduras",   "HRK-Croatia",
    "HTG-Haiti",   "HUF-Hungary",   "IDR-Indonesia",   "ILS-Israel",   "INR-India",
    "IQD-Iraq",   "IRR-Iran",   "ISK-Iceland",   "JMD-Jamaica",   "JOD-Jordan",   "JPY-Japan",
    "KES-Kenya",   "KGS-Kyrgyzstan",   "KHR-Cambodia",   "KMF-Comoros",   "KPW-North Korea",
    "KRW-South Korea",   "KWD-Kuwait",   "KYD-Cayman Islands",   "KZT-Kazakhstan",   "LAK-Laos",
    "LBP-Lebanon",   "LKR-SriLanka",   "LRD-Liberia",   "LSL-Lesotho",   "LTL-Lithuania",
    "LVL-Latvia",   "LYD-Libya",   "MAD-Morocco, Western Sahara",   "MDL-Moldova",   "MGA-Madagascar",
    "MKD-Macedonia",   "MMK-Myanmar",   "MNT-Mongolia",
    "MOP-Macau",   "MRO-Mauritania",   "MTL-Malta",
    "MUR-Mauritius",   "MVR-Maldives",   "MWK-Malawi",   "MXN-Mexico",   "MXV-Mexico",
    "MYR-Malaysia",   "MZN-Mozambique",   "NAD-Namibia",   "NGN-Nigeria",   "NIO-Nicaragua",
    "NOK-Norway",   "NPR-Nepal",   "NZD-NewZealand",   "OMR-Oman",   "PAB-Panama",
    "PEN-Peru",   "PGK-Papua",   "PHP-Philippines",   "PKR-Pakistan",
    "PLN-Poland",   "PYG-Paraguay",   "QAR-Qatar",   "RON-Romania",   "RSD-Serbia",
    "RUB-Russia",   "RWF-Rwanda",   "SAR-Saudi Arabia",   "SBD-Solomon Islands",   "SCR-Seychelles",
    "SDG-Sudan",   "SEK-Sweden",   "SGD-Singapore",   "SHP-Saint Helena",   "SKK-Slovakia",
    "SLL-SierraLeone",   "SOS-Somalia",   "SRD-Suriname",   "STD-São Tomé and Príncipe",
    "SYP-Syria",   "SZL-Swaziland",   "THB-Thailand",   "TJS-Tajikistan",   "TMM-Turkmenistan",
    "TND-Tunisia",   "TOP-Tonga",   "TRY-Turkey",   "TTD-Trinidad and Tobago",
    "TWD-Taiwan",   "TZS-Tanzania",   "UAH-Ukraine",   "UGX-Uganda",   "USD-United States"
    ,"USN-United States",   "USS-United States",   "UYU-Uruguay",   "UZS-Uzbekistan",
    "VEB-Venezuela",   "VND-Vietnam",   "VUV-Vanuatu",   "WST-Samoa",
    "XCD-Anguilla",   "XDR-International Monetary Fund",
    "XFO-Bank for International Settlements",   "XFU-International Union of Railways",   "XOF-Benin",   "XPF-French",   "YER-Yemen",   "ZAR-South Africa",   "ZMK-Zambia",   "ZWD-Zimbabwe"];


  @override
  // TODO: implement initialState
  ConvertState get initialState {
    return InitialState(currencyList: currencyList,value: 1.0);
  }

  @override
  Stream<ConvertState> mapEventToState(ConvertEvent event) async*{
    // TODO: implement mapEventToState

    if(event is AddCurrencyEvent) {
      try {
        yield OpenCurrencyPageState(listOfCurrencies: listOfCurrencies);
      } catch(e){
        yield ErrorState(currencyList: currencyList,value: 1,errorMsg: e.toString());
      }

    }else if(event is SelectCurrencyEvent){
      try {
           String currencyCode = listOfCurrencies[event.countryCodeIndex];
          currencyList.add(Currency(countryCode: currencyCode));

           yield LoadingState();
           exchangeRates = await _apiService.getCurrencyRate(currencyList[0].countryCode);

           yield LoadedState(currencyList: currencyList,exchangeRate: exchangeRates);

    } catch(e){
    yield ErrorState(currencyList: currencyList,value: 1,errorMsg: e.toString());
    }

  }else if(event is LoadDataEvent){

      try{
        yield LoadingState();
        exchangeRates = await _apiService.getCurrencyRate(currencyList[0].countryCode.substring(0,3));
        yield LoadedState(currencyList: currencyList,exchangeRate: exchangeRates);

      }catch(e){
         yield ErrorState(currencyList: currencyList,value: 1,errorMsg: e.toString());
      }


    }else if (event is OnReorderEvent){
      try{
      yield LoadingState();
      currencyList = event.currencyList;
      exchangeRates = await _apiService.getCurrencyRate(currencyList[0].countryCode.substring(0,3));
      yield LoadedState(currencyList: currencyList,exchangeRate: exchangeRates);
      }catch(e){
        yield ErrorState(currencyList: currencyList,value: 1,errorMsg: e.toString());
      }
    }else if (event is OnValueAddEvent){

      try{
        yield LoadingState();
        currencyList = event.currencyList;
        value = event.value;
        exchangeRates = event.exchangeRates;
        yield LoadedState(currencyList: currencyList,exchangeRate: exchangeRates,value: value);
      }catch(e){
        yield ErrorState(currencyList: currencyList,value: 1,errorMsg: e.toString());
      }
      }else if (event is OnDeleteEvent){

      yield LoadingState();
      currencyList = event.currencyList;
      currencyList.removeAt(event.deleteIndex);
      value = event.value;
      exchangeRates = event.exchangeRates;
      yield LoadedState(currencyList: currencyList,exchangeRate: exchangeRates,value: value);
    }
    }
  }






