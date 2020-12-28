import 'package:exchange_rate_bloc_test/bloc/convert_bloc.dart';
import 'package:exchange_rate_bloc_test/bloc/convert_event.dart';
import 'package:exchange_rate_bloc_test/model/currency.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InitialConvert extends StatefulWidget {

  List<Currency> currencyList;
  double value;
  String errorMsg;


  InitialConvert({this.currencyList,this.value,this.errorMsg});

  @override
  _InitialConvertState createState() => _InitialConvertState();
}

class _InitialConvertState extends State<InitialConvert> {

  ConvertBloc _convertBloc;

  @override
  Widget build(BuildContext context) {
    _convertBloc = BlocProvider.of<ConvertBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Convert"),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.money),
          )
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        color: Colors.indigoAccent.withOpacity(0.2),
        child: Column(
          children: [
            ListTile(
                title: Text(widget.currencyList[0].countryCode),
                subtitle: Text(widget.value.toString()),
            ),
            widget.errorMsg != null?
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Center(child: Text('${widget.errorMsg}',
                  style: TextStyle(
                    color: Colors.redAccent
                  ),)),
                )
                 :
                Text(''),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.indigoAccent,
        foregroundColor: Colors.white,
        icon: Icon(Icons.library_add_outlined),
        label: Text('add currency'),
        onPressed: (){
          _convertBloc.add(AddCurrencyEvent());
        },
      ),
    );
  }
}
