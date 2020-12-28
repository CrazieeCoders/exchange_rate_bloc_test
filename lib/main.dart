import 'package:exchange_rate_bloc_test/bloc/convert_bloc.dart';
import 'package:exchange_rate_bloc_test/themes/size_config.dart';
import 'package:exchange_rate_bloc_test/ui_bloc/ui_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context,constraints){
        return OrientationBuilder(
          builder: (context,orientation){
            SizeConfig().init(constraints,orientation);
            return MaterialApp(
              title: 'Flutter Demo',
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                primarySwatch: Colors.indigo,
              ),
              home: BlocProvider(
                  builder: (context)=>ConvertBloc(),
                  child: ConvertUIBloc()),
            );

          },
        );
      },
    );
  }
}


