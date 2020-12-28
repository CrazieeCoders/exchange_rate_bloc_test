import 'package:equatable/equatable.dart';
import 'package:exchange_rate_bloc_test/model/currency.dart';
import 'package:flutter/cupertino.dart';

abstract class ConvertEvent extends Equatable{}



class AddCurrencyEvent extends ConvertEvent{

  @override
  // TODO: implement props
  List<Object> get props => [];

}

class SelectCurrencyEvent extends ConvertEvent{

  int countryCodeIndex;
  SelectCurrencyEvent({this.countryCodeIndex});
  @override
  // TODO: implement props
  List<Object> get props =>[countryCodeIndex];

}

class LoadDataEvent extends ConvertEvent{

  List<Currency> currencyList;
  Map<String,double> exchangeRates;

  LoadDataEvent({@required this.currencyList,@required this.exchangeRates});

  @override
  // TODO: implement props
  List<Object> get props => [currencyList,exchangeRates];
}


class OnReorderEvent extends ConvertEvent{

  List<Currency> currencyList;
  OnReorderEvent({this.currencyList});
  @override
  // TODO: implement props
  List<Object> get props =>[currencyList];

}


class OnValueAddEvent extends ConvertEvent{

   int value;
  List<Currency> currencyList;
   Map<String,double> exchangeRates;

   OnValueAddEvent({this.currencyList,this.value,this.exchangeRates});
  @override
  // TODO: implement props
  List<Object> get props =>[currencyList];

}

class OnDeleteEvent extends ConvertEvent{

  int value;
  int deleteIndex;
  List<Currency> currencyList;
  Map<String,double> exchangeRates;

  OnDeleteEvent({this.currencyList,this.value,this.exchangeRates,this.deleteIndex});
  @override
  // TODO: implement props
  List<Object> get props =>[currencyList];

}