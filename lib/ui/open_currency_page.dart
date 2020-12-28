import 'package:exchange_rate_bloc_test/bloc/convert_bloc.dart';
import 'package:exchange_rate_bloc_test/bloc/convert_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OpenCurrencyPageUI extends StatefulWidget {

  List<String> listOfCurrencies;

  OpenCurrencyPageUI({@required this.listOfCurrencies});
  @override
  _OpenCurrencyPageUIState createState() => _OpenCurrencyPageUIState();
}

class _OpenCurrencyPageUIState extends State<OpenCurrencyPageUI> {
  ConvertBloc _convertBloc;
  @override
  Widget build(BuildContext context) {
    _convertBloc = BlocProvider.of<ConvertBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('select currency code'),
      ),
      body: Container(
        color: Colors.white,
        child: ListView.builder(
          itemCount: widget.listOfCurrencies.length,
          itemBuilder: (context,index){
            return Card(
              child: ListTile(
                onTap: (){
                  _convertBloc.add(SelectCurrencyEvent(countryCodeIndex: index));
                },
                leading: Text(widget.listOfCurrencies[index]),
              ),
            );
          },
        ),
      ),
    );
  }
}
