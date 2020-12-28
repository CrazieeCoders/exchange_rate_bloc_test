import 'package:exchange_rate_bloc_test/bloc/convert_bloc.dart';
import 'package:exchange_rate_bloc_test/bloc/convert_event.dart';
import 'package:exchange_rate_bloc_test/model/currency.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flag/flag.dart';
import 'package:exchange_rate_bloc_test/themes/size_config.dart';

class ConvertPageUI extends StatefulWidget {
  List<Currency> currencyList;
  Map<String,double> exchangeRate;
  int value;

  ConvertPageUI({@required this.currencyList,@required this.exchangeRate,this.value});

  @override
  _ConvertPageUIState createState() => _ConvertPageUIState();
}

class _ConvertPageUIState extends State<ConvertPageUI> {

  ConvertBloc _convertBloc;
  TextEditingController _valueInputController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void onReorder(int oldIndex,int newIndex){

      if(newIndex > oldIndex){
        newIndex-=1;
      }
      var x = widget.currencyList.removeAt(oldIndex);
      widget.currencyList.insert(newIndex, x);
      _convertBloc.add(OnReorderEvent(currencyList:widget.currencyList ));
    }

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
      body: ReorderableListView(
          children: <Widget>[
            for (int i= 0 ;i<widget.currencyList.length;i++)
              i==0?
    ListTile(
      key: ObjectKey(widget.currencyList[i]),
      leading:  Flag(
        '${widget.currencyList[i].countryCode.substring(0,2)}',
        height: 3.65 * SizeConfig.heightMultiplier,
        width: 7.5 * SizeConfig.widthMultiplier,
      ),
      title: Text('${widget.currencyList[i].countryCode}'),
      subtitle:   widget.value == null?
      Text(
    '1 ${widget.currencyList[i].countryCode.substring(0,3)} = '+
          widget.exchangeRate[widget.currencyList[i].countryCode.substring(0,3)]
              .toString()):
      Text(
          '1 ${widget.currencyList[i].countryCode.substring(0,3)} = '+
              (widget.exchangeRate[widget.currencyList[i].countryCode.substring(0,3)]*widget.value)
                  .toStringAsFixed(2))
      ,
      trailing: Wrap(
        spacing: 12, // space between two icons
        children: <Widget>[
          Container(
              width: 15 *SizeConfig.widthMultiplier,
              height: 3.65 * SizeConfig.heightMultiplier,
              decoration: BoxDecoration(
                color: Colors.indigoAccent.withOpacity(0.3),
                borderRadius: BorderRadius.circular(10.0),
              ),

              child: Form(
                key: _formKey,
                child: TextFormField(
                  controller: _valueInputController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                  ),
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return 'empty!!';
                    }else if(int.parse(text) > 99999){
                      return 'not valid input';
                    }
                    return null;
                  },
                ),
                ),
              ),
           GestureDetector(
             onTap: (){

    if(_formKey.currentState.validate()) {
      _convertBloc.add(OnValueAddEvent(currencyList: widget.currencyList,
          exchangeRates: widget.exchangeRate, value: int.parse(
              _valueInputController.text)
      ));
      _formKey.currentState.reset();
      _valueInputController.clear();
    }

             },
             child: Icon(Icons.dialpad,
             size: 3.65 * SizeConfig.heightMultiplier,),
           ),


        ],
      ),
    )
          :
          ListTile(
           key: ObjectKey(widget.currencyList[i]),
            leading:  Flag(
    '${widget.currencyList[i].countryCode.substring(0,2)}',
              height:3.65 * SizeConfig.heightMultiplier,
              width: 7.5 * SizeConfig.widthMultiplier,
            ),
            title: Text('${widget.currencyList[i].countryCode}'),
            subtitle: Text(
                '1 ${widget.currencyList[0].countryCode} = '+
            widget.exchangeRate[widget.currencyList[i].countryCode.substring(0,3)]
                .toString() +'  ${widget.currencyList[i].countryCode.substring(0,3)}' ),
            trailing: Wrap(
              spacing: 12, // space between two icons
              children: <Widget>[
                widget.value != null && widget.exchangeRate[widget.currencyList[i].countryCode.substring(0,3)] != null?
                Text((widget.value*widget.exchangeRate[widget.currencyList[i].countryCode.substring(0,3)]).toStringAsFixed(2)):
                    Text(''),


                  GestureDetector(
                    onTap: (){
                      _convertBloc.add(OnDeleteEvent(currencyList:widget.currencyList,
                      exchangeRates: widget.exchangeRate,
                        value: widget.value,
                        deleteIndex: i,
                      ));
                    },
                    child: Icon(Icons.remove_circle,
                      size: 3.65 * SizeConfig.heightMultiplier,),
                  ),


              ],
            ),


           ),

    ],

    onReorder: onReorder),



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
