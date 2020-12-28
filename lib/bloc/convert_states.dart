import 'package:equatable/equatable.dart';
import 'package:exchange_rate_bloc_test/model/currency.dart';
import 'package:flutter/cupertino.dart';

abstract class ConvertState extends Equatable{
}

class InitialState extends ConvertState{

  List<Currency> currencyList;
  double value;
  InitialState({@required this.currencyList,@required this.value});

  @override
  // TODO: implement props
  List<Object> get props => [currencyList];

}

class OpenCurrencyPageState extends ConvertState{
  List<String> listOfCurrencies;

  OpenCurrencyPageState({@required this.listOfCurrencies});
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();

}

class LoadingState extends ConvertState{
  @override
  // TODO: implement props
  List<Object> get props => [];

}

class LoadedState extends ConvertState{

  List<Currency> currencyList;
  Map<String,double> exchangeRate;
  int value;

  LoadedState({@required this.currencyList,@required this.exchangeRate,this.value});

  @override
  // TODO: implement props
  List<Object> get props => [currencyList,exchangeRate];

}

class ErrorState extends ConvertState{
   String errorMsg;
   List<Currency> currencyList;
   int value;

   ErrorState({this.currencyList,this.value,this.errorMsg});

  @override
  // TODO: implement props
  List<Object> get props => [errorMsg];

}
