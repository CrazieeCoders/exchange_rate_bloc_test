import 'package:exchange_rate_bloc_test/bloc/convert_bloc.dart';
import 'package:exchange_rate_bloc_test/bloc/convert_states.dart';
import 'package:exchange_rate_bloc_test/ui/ConvertPageUI.dart';
import 'package:exchange_rate_bloc_test/ui/initial_convert.dart';
import 'package:exchange_rate_bloc_test/ui/open_currency_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class ConvertUIBloc extends StatefulWidget {
  @override
  _ConvertUIBlocState createState() => _ConvertUIBlocState();
}

class _ConvertUIBlocState extends State<ConvertUIBloc> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ConvertBloc,ConvertState>(
        builder: (context,state){
           if(state is InitialState){
             return InitialConvert(currencyList: state.currencyList,value: state.value,);
           }else if(state is OpenCurrencyPageState) {
             return OpenCurrencyPageUI(listOfCurrencies: state.listOfCurrencies,);
           }else if(state is LoadingState){
             return   Center(
               child: CircularProgressIndicator(
                 backgroundColor: Colors.white,
               ),
             );
           }else if (state is LoadedState){
             return ConvertPageUI(currencyList: state.currencyList,exchangeRate: state.exchangeRate,value: state.value,);
           }else  if (state is ErrorState){
             return InitialConvert(currencyList: state.currencyList,value: 1.0,errorMsg: state.errorMsg,);
           }else{
             return Center(child: Container(child: Text('UnExpected error occurred!!'),));
           }


        },
      ),
    );
  }
}
